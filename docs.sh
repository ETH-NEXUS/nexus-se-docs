#!/bin/bash

update() {
    echo -e "\033[32mStarting update \033[0m"
    root_dir=$1
    echo -e "Root dir is: $root_dir\n"

    cd $root_dir

    if [ -f .env ]; then
        export $(grep -E '^(TOKEN_NAME|TOKEN_PASS|REPOSITORIES|BRANCHES|DCC_ENV)=' .env | xargs)
    fi

    IFS=',' read -r -a repos <<< "$REPOSITORIES"
    IFS=',' read -r -a branches <<< "$BRANCHES"

    if [ ! -d "projects" ]; then
        mkdir projects
    fi


    for i in "${!repos[@]}"
    do
        cd $root_dir
        echo -e "\033[32mUpdating  ${repos[i]} on branch ${branches[i]} \033[0m"

        repo_name=$(echo ${repos[i]} | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}')


        if [ ! -d "projects/$repo_name" ]; then
            echo -e "\033[34mCloning repository ${repos[i]}...\033[0m"
            git clone https://$TOKEN_NAME:$TOKEN_PASS@${repos[i]} projects/$repo_name
            cd projects/$repo_name
            git checkout ${branches[i]}
        else
            echo -e "\033[34mPulling repository ${repos[i]} with branch ${branches[i]}...\033[0m"
            cd projects/${repo_name}
            git pull
            git checkout ${branches[i]}
        fi

        echo -e "\033[34mCopying files from projects to docs folder ...\033[0m"

        if [ ! -d "$root_dir/docs/docs/$repo_name" ]; then
            echo "Creating docs folder: $root_dir/docs/docs/$repo_name"
            mkdir $root_dir/docs/docs/$repo_name
        else
            echo "Recreating docs folder: $root_dir/docs/docs/$repo_name"
            rm -rf $root_dir/docs/docs/$repo_name
            mkdir -p $root_dir/docs/docs/$repo_name
        fi

        find $root_dir/projects/$repo_name/docs/docs/ \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            ! \( -name assets -o -name stylesheets \) \
            -exec rsync -a {} $root_dir/docs/docs/$repo_name/ \;

        if [ "$repo_name" != "docs" ]; then
            cp $root_dir/projects/$repo_name/docs/docs/index.md $root_dir/docs/docs/$repo_name/index.md
        fi
    done
    echo -e "\033[32mData preparation done \xE2\x9C\x93\033[0m"

    echo -e "\033[34mRestarting docker ...\033[0m"

    cd $root_dir

    if [ "$DCC_ENV" = "prod" ]; then
        docker compose -f docker-compose.yml -f docker-compose.prod.yml down
        docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
    else
        docker compose down
        docker compose up -d
    fi

    echo -e "\033[32mDone \xE2\x9C\x93\033[0m"
}

update_with_trigger() {
    root_dir=$1
    UPDATE_TRIGGER="$root_dir/.acint/.build"

    if [ -f $UPDATE_TRIGGER ]; then
        echo -e "##############"
        echo `date`
        update $root_dir
        echo -e "Removing update trigger"
        rm -rf $UPDATE_TRIGGER
        echo -e "Automated update done"
    fi
}

usage() {
  echo -e "\033[1mUsage instructions:\033[0m\n"
  echo -e "- Update all documentation pages for given repositories:"
  echo -e "  docs.sh update path/to/docs/project\n"
}

case $1 in
  update)
    update "${@:2}"
    ;;
  update_with_trigger)
    update_with_trigger "${@:2}"
    ;;
  *)
    echo -e "\033[31mUnknown function $1\033[0m\n"
    usage
    exit 1
    ;;
esac