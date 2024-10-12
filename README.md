# Single Player Tarkov - Server Project(community)

This repository is for compiling the SPT server, not for source code. It automatically compiles the SPT code daily at midnight and pushes the compiled version to the releases. The compiled `.zip` file is intended for use with Windows. If you need the Linux version, please refer to the tutorial below.

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

repository: https://dev.sp-tarkov.com/medusa/spt-server

~~SPT Registry: https://dev.sp-tarkov.com/medusa/-/packages/container/spt-server/nightly~~

Docker Hub: https://hub.docker.com/r/stblog/spt-server

Github Container Registry: https://github.com/AirryCo/spt-server-ci/pkgs/container/spt-server

Aliyun Registry: registry.cn-shenzhen.aliyuncs.com/spt-server/spt-server

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
