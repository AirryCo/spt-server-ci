# Single Player Tarkov - Server Project(community)

This repository is for compiling the SPT server, not for source code. It automatically compiles the SPT code daily at midnight and pushes the compiled version to the releases. 

You can find the lanucher from [here](https://github.com/AirryCo/spt-launcher-ci/releases)

[![SPT-Server Build Release](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-release-cron.yaml/badge.svg)](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-release-cron.yaml)

[![SPT-Server Build Nightly](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-nightly-cron.yaml/badge.svg)](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-nightly-cron.yaml)

[![SPT-Server Manual Build](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-nightly-manual.yaml/badge.svg)](https://github.com/AirryCo/spt-server-ci/actions/workflows/build-nightly-manual.yaml)

## How to use

### For windows

1. go to https://github.com/AirryCo/spt-server-ci/releases

2. download the `.zip` file

3. use extraction software to unzip the files

4. then run `SPT.Server.exe`

5. run `SPT.Launcher` to connect

### For linux

repository: ~~https://dev.sp-tarkov.com/medusa/spt-server~~ https://github.com/AirryCo/spt-server

~~SPT Registry: https://dev.sp-tarkov.com/medusa/-/packages/container/spt-server/nightly~~

Docker Hub: https://hub.docker.com/r/stblog/spt-server

Github Container Registry: https://github.com/AirryCo/spt-server-ci/pkgs/container/spt-server

Aliyun Registry: registry.cn-shenzhen.aliyuncs.com/spt-server/spt-server

> [!NOTE]
> ***Mods using***: please replace all instances of the string "/snapshot/project" in the mod folder with "/snapshot/workspace/medusa/spt-server/code/project" before running.(**version 3.9 only**，No changes required for version 3.10)
> 
> You can run the commond `sed -i "s/\/snapshot\/workspace\/project/\/snapshot\/workspace\/medusa\/spt-server\/code\/project/g" $(grep -rl "/snapshot/workspace" .)` to replace all.

### 3.10

1. use docker shell

```bash
docker pull stblog/spt-server:nightly
docker run -d --name spt-server -v ./spt-server:/opt/spt-server -e backendIp=192.168.1.1 -e backendPort=6969 -p 6969:6969 stblog/spt-server:nightly
```

2. or use docker compose

```yaml
services:
  spt-server:
    image: stblog/spt-server:nightly
    container_name: spt-server
    hostname: spt-server
    restart: unless-stopped
    volumes:
      - ./spt-server:/opt/spt-server
    network_mode: host
    environment:
      - backendIp=192.168.1.1
      - backendPort=6969
```

`backendIp`(optional): Your server IP, default is your container IP like `172.17.0.2`. If `network_mode` is set to `host`, it will be your server IP by default

`backendPort`(optional): Your server port, default is `6969`

### 3.9

```bash
docker run -d --name spt-server --restart always -p 6969:6969 -v ./spt-server:/opt/spt-server stblog/spt-server:3.9
```

docker compose
```yaml
services:
  spt-server:
    image: stblog/spt-server
    container_name: spt-server
    restart: always
    volumes:
      - './spt-server:/opt/spt-server'
    ports:
      - '6969:6969'
```

You need to modify the value of `backendIp` to your server IP in `SPT_Data/Server/configs/http.json`
