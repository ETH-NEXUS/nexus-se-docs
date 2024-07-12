---
title: Linux Commands
---

# Useful Linux Commands

This is a collection of useful linux commands that can be easily copy pasted.

#### CRON
The cron command-line utility is a job scheduler on Unix-like operating systems [^1]. It can be used to periodically run various scripts on your server. A detailed CRON guide is provide by [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804). A helpful utility for understanding the cron time settings can be found on the following link: [https://crontab.guru](https://crontab.guru)

!!! note

    In some environments you may need to setup environment variables such as the `PATH` and the `DOCKER_HOST`. This will enable your cron scripts to access and interact with services such as docker.


Editing the crontab of the current user:
```bash linenums="1"
crontab -e
```

Erasing the crontab of the current user:
```bash linenums="1"
crontab -r
```

Storing the output of a cron job to a log file:
```bash linenums="1"
your_cron_command >> /path/to/cron_output.log 2>&1
```

[^1]: [https://en.wikipedia.org/wiki/Cron](https://en.wikipedia.org/wiki/Cron "Link to wikipedia CRON page")
