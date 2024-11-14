---
title: Leomed Hacks
---

### SSH Forward Tunnel to a port inside Leomed

Let's assume we have a web-service installed on a LeoMed VM that is listening on port 8080. Now we want to access this service from our labtop **without** exposing the port 8080 to the internet.

```grafic
+--------------+                    +--------------+
|              | -----------------> |              |
|              |    ssh tunnel    > |    LeoMed    |
|    laptop    | -----------------> |      VM      |
+--------------+                    +--------------+
 localhost:8888 -------------------> leomed-vm:8080
```

All we need to do, is creating a `forward ssh tunnel`:

```bash
ssh -4 -N -T -L 8888:localhost:8080 <leomed-vm>
```

Now you are able to access `http://leomed-vm:8080` from your labtop using `http://localhost:8888`.

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

1. [laptop] Setup a local ssh-proxy using the following script:

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

2. [labtop] Create a reverse ssh tunnel:

```bash
ssh -4 -N -T -R 2222:localhost:2222 <leomed-vm>
```

3. [labtop] Copy over the private key of the tunnel (created by the script in 1.):

```bash
cd ~
scp .ssh/tunnel <leomed-vm>:.ssh/tunnel
```

4. [leomed-vm] Configure `.ssh/config` entry for `github.com`:

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

5. [labtop] Make sure you have loaded your github ssh key:

```bash
ssh-add .ssh/<github-key>
```

6. [labtop] Make sure you have configured `ForwardAgent` for your ssh connection to the `leomed-vm`:

```bash
cd ~
vi .ssh/config
...
Host leomed-vm
    ForwardAgent yes
...
```

7. [labtop] Now you can `ssh` to the `leomed-vm` and do what ever you want with git(hub).