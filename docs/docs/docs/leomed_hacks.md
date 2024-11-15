---
title: LeoMed Hacks
---

### Access services running within LeoMed without directly exposing their ports

Let's assume we have a `web-service` (like a LabKey server) installed on a LeoMed VM that is listening on `port 8080`. Now we want to access this service from our laptop **without** exposing the `port 8080`.

```grafic
+--------------+                    +--------------+
|              | -----------------> |              |
|              |    ssh tunnel    > |    LeoMed    |
|    laptop    | -----------------> |      VM      |
+--------------+                    +--------------+
 localhost:8888 -------------------> leomed-vm:8080
```

1. `[laptop]` All we need to do, is creating a **forward** ssh tunnel:

    ```bash
    ssh -4 -N -T -L 8888:localhost:8080 <leomed-vm>
    ```

Now you are able to access `http://leomed-vm:8080` from your laptop using `http://localhost:8888`.

### Access github from inside LeoMed

Let's assume you want to have ssh access to github from inside LeoMed. This is possible by installing and configuring a few things.

```graphic
+------------------+                    +--------------+
|  +------------+  |                    |              |
|  |  ssh-proxy |  | <----------------- |              |
|  +------------+  | <  ssh tunnel      |    LeoMed    |
|    laptop        | <----------------- |      VM      |
+------------------+                    +--------------+
   localhost:2222 <--------------------- leomed-vm:2222
```

That can be setup going through the following steps:

1. `[laptop]` Setup a local `ssh-proxy` using the following script:
  
    ```bash
    #!/usr/bin/env bash

    echo "### Starting local ssh-proxy on port 2222..."
    if [ ! -f ~/.ssh/tunnel ]
    then
      ssh-keygen -t ed25519 -b 4096 -C tunnel -f ~/.ssh/tunnel -N ''
    fi
    KEY=$(cat "$HOME"/.ssh/tunnel.pub)
    if [ ! "$(docker ps -q -f name=ssh-proxy -f status=running)" ]
    then
      if [ "$(docker ps -aq -f name=ssh-proxy -f status=exited)" ]
      then
        docker rm ssh-proxy
      fi
      docker run \
      --name=ssh-proxy \
      --hostname=ssh-proxy \
      -d \
      -e PUBLIC_KEY="${KEY}" \
      -p 2222:2222 \
      --restart unless-stopped \
      ethnexus/ssh-proxy
    fi
    ```

    !!! tip
        I personally store this script in `~/.local/bin/ssh-proxy` to be able to run it whenever needed.

2. `[laptop]` Create a **reverse** ssh tunnel:

    ```bash
    ssh -4 -N -T -R 2222:localhost:2222 <leomed-vm>
    ```

3. `[laptop]` Copy over the private key of the tunnel (created by the script in 1.):

    ```bash
    cd ~
    scp .ssh/tunnel <leomed-vm>:.ssh/tunnel
    ```

4. `[leomed-vm]` Configure `.ssh/config` entry for `github.com`:

    ```bash
    cd ~
    vi .ssh/config
    Host proxy
        HostName localhost
        User tunnel
        Port 2222
        IdentityFile ~/.ssh/tunnel

    Host github.com
        HostName github.com
        User git
        ProxyJump proxy
    :wq
    ```

5. `[laptop]` Make sure you have loaded your github ssh key:

    ```bash
    ssh-add .ssh/<github-key>
    ```

    !!! tip
        To check if the git key is available on the `leomed-vm`, you can execute:
        ```bash
        ssh-add -L
        ```

6. `[laptop]` Make sure you have configured `ForwardAgent` for your ssh connection to the `leomed-vm`:

    ```bash
    vi ~/.ssh/config
    ...
    Host leomed-vm
        ForwardAgent yes
    ...
    ```

    !!! tip
        You can also add the `ForwardAgent yes` to the general section (`Host *`) inside the `~/.ssh/config`:
        ```bash
        Host *
            ForwardAgent yes
        ```

7. `[laptop]` Now you can `ssh` to the `leomed-vm` and do what ever you want with git(hub).

### Share existing, authenticated ssh session with subsequent ssh sessions

Assume you want to **login only once** to a `leomed-vm` but open additional ssh sessions to the **same** `leomed-vm`. This can be done by using the `SSH ControlMaster` that enables the sharing of multiple sessions over a single network connection. This means that you can connect to the cluster once, enter your password and verification code, and have all other subsequent ssh sessions (including svn, rsync, etc. that run over ssh) piggy-back off the initial connection without need for re-authentication. 

1. Enable the `ControlMaster` in your general section (`Host *`) of the `~/.ssh/config` file:

    ```bash
    Host *
        ControlMaster auto
        ControlPath ~/.ssh/masters/%C
    ```