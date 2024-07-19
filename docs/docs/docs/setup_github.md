---
title: GitHub Setup
---

### Folder Structure
The folder `docs/docs` contains the main content of the docs.

- assets - contains additional assets such as images.
- stylesheets - contains custom styles
- docs - is a chapter folder and contains additional .md files inside
- index.md - is the main welcome page you see when you visit the docs for the first time

!!! info

    You can add one or more chapter folders inside of the `docs/docs` folder. Make sure each one of them has an `index.md` file which represents the first page of your chapter. Additioanlly you can add a `.pages` file which includes the order of the pages.

```yaml title=".pages" linenums="1"
nav:
    - index.md
    - general.md
    - advanced.md
    - visual.md
    - setup.md
```



### Adding Your Project

1. Login to the docs server and open the `.env` file in the docs folder on the server. Add the project url under the `REPOSITORIES` key and the desired branch under `BRANCHES` key.

    !!! warning

        Make sure the values in the `.env` file are comma separated and there is no spaces in between!

    !!! info
        Alternatively ask one of the server admins to add your project to the `.env` file.

2. Add or expand the `.github/workflows/main.yml` at the root of your project with the following entries:

    ```yaml title="main.yml" linenums="1"
    name: Documentation deployment workflow

    on:
      push:
        branches:
          - main
        paths:
          - docs/**/*
      pull_request:
        branches:
          - main
        paths:
          - docs/**/*

    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
        - name: Checkout code
          uses: actions/checkout@v3

        - name: Install curl
          run: sudo apt-get update && sudo apt-get install -y curl

        - name: Deploying the docs
          run: |
            echo "Deploying the docs"
            curl --request POST ${{ secrets.ACINT_URL }} -H "Content-Type: application/json" -d "{\"action\": \"${{ secrets.ACINT_ACTION }}\", \"token\": \"${{ secrets.ACINT_TOKEN }}\"}"
    ```
3. Make sure to modify the branch on which you want this job to be triggered.
4. Set the required secrets
5. Copy the `docs` folder at the root of the [docs project](https://github.com/ETH-NEXUS/nexus-docs) into the root of your project.

6. Expand your `docker-compose.yml` file:

    ```yaml title="docker-compose.yml" linenums="1"
    services:
        mkdocs:
            build:
            context: docs
            dockerfile: Dockerfile
            ports:
            - "8000:8000"
            volumes:
            - ./docs/:/docs/:z
    ```

That's it! Congratulations you now have your local project documentation! 🥳 Next time you push changes to the `docs` repository your project documentation will be visible in 2-3 minutes on the [docs.nexus.ethz.ch](docs.nexus.ethz.ch) webpage.

