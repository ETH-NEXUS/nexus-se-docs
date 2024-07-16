---
title: Commands
---

# Useful Commands

This is a collection of useful linux commands that can be easily copy pasted.

#### General

**Replacing lines in a file**
```bash linenums="1"
sed -i 's/^key_in_file=.*$/key_in_file=new_value/' ./path/to/my_file.txt
```
This will iterate over all lines of `./path/to/my_file.txt` and apply the specified changes. In this case these changes are the value of the `key_in_file` key. The sed command can also be used to apply the same changes to outputs of other functions.

**Extract values from JSON files**
```bash linenums="1"
MY_VARIABLE=$(jq -r '.version' path/to/my/file.json)
```
The [jq package](https://jqlang.github.io/jq/) is a useful utility for processing `.json` files. Make sure to install it before attempting to use the above command. As mentioned on the webpage `jq is like sed for JSON data`.

#### GIT

**View all remotes**
```bash linenums="1"
git remote -v
```

**Change remote URL of specific remote**
```bash linenums="1"
git remote set-url remote_name new_url
```
This can be useful if you for example moved your repository to a new domain / git platform or if you want to change the way you interact with a repository (e.g. change from ssh to https).

**Add a new remote**
```bash linenums="1"
git remote add remote_name https://my.gitlab.instance/user/project.git
```
In some cases you may wish to add a second remote. For example in cases where your code is stored on multiple git platforms that you wish to keep in sync.

**Push to a specific remote**
```bash linenums="1"
git push -u -f remote_name
```

#### CRON
The cron command-line utility is a job scheduler on Unix-like operating systems [^1]. It can be used to periodically run various scripts on your server. A detailed CRON guide is provide by [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804). A helpful utility for understanding the cron time settings can be found on the following link: [https://crontab.guru](https://crontab.guru)

**Editing the crontab of the current user:**
```bash linenums="1"
crontab -e
```

**Erasing the crontab of the current user:**
```bash linenums="1"
crontab -r
```

**Storing the output of a cron job to a log file:**
```bash linenums="1"
*/1 * * * * bash /path/to/your/command_or_script >> /path/to/cron_output.log 2>&1
```

!!! info

    In some environments you may need to setup environment variables such as the `PATH` and the `DOCKER_HOST`. This will enable your cron scripts to access and interact with services such as docker.


!!! tip

    Ensure that you terminate commands with new lines and escape percentage signs using a backslash `\%` as this may cause issues if it is not done.


[^1]: [https://en.wikipedia.org/wiki/Cron](https://en.wikipedia.org/wiki/Cron "Link to wikipedia CRON page")
