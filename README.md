# Terraria TML Docker

[![MIT LICENSE](https://badgen.net/github/license/paul1365972/terraria-tml-server)](https://github.com/Paul1365972/terraria-tml-server/blob/master/LICENSE)
[![Docker Image Size](https://badgen.net/docker/size/paul1365972/terraria-tml-server?icon=docker&label=image%20size)](https://hub.docker.com/r/paul1365972/terraria-tml-server)
[![Docker Stars](https://badgen.net/docker/stars/paul1365972/terraria-tml-server?icon=docker&label=stars)](https://hub.docker.com/r/paul1365972/terraria-tml-server)
[![Docker Pulls](https://badgen.net/docker/pulls/paul1365972/terraria-tml-server?icon=docker&label=pulls)](https://hub.docker.com/r/paul1365972/terraria-tml-server)

Docker and docker-compose project for running a simple dedicated tModLoader server

## Running

Go to the directory where you want to install the server and execute either

```shell
git clone https://github.com/Paul1365972/terraria-tml-server.git
cd terraria-tml-server
docker-compose up -d
```

or

```shell
docker run --rm -itd \
  --name=terraria-tml-server \
  -p 7777:7777 \
  -v "$(pwd)/logs/":"/root/.local/share/Terraria/ModLoader/Logs/" \
  -v "$(pwd)/worlds/":"/tml-server/worlds/" \
  -v "$(pwd)/mods/:/tml-server/mods/" \
  -v "$(pwd)/config/:/tml-server/config/" \
  -v "$(pwd)/mod-configs/:/root/.local/share/Terraria/ModLoader/Mod Configs/" \
  -v "$(pwd)/init/:/tml-server/init/" \
  paul1365972/terraria-tml-server
```
