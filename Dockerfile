ARG ALPINE_MONO_VERSION=5.20

FROM frolvlad/alpine-mono:${ALPINE_MONO_VERSION}-glibc

ARG TMOD_VERSION=0.11.8.9
ARG TSW_VERSION=1.0.2

WORKDIR /tml-server/

ADD https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.zip tml.zip

RUN unzip -q tml.zip && \
    find . ! -name 'tModLoaderServer.exe' ! -name 'FNA.dll' -delete

ADD https://github.com/joshbarrass/TerrariaServerWrapper/releases/download/v${TSW_VERSION}/TerrariaServerWrapper-x64 TerrariaServerWrapper
RUN chmod +x TerrariaServerWrapper

COPY entrypoint.sh ./

VOLUME [ "/root/.local/share/Terraria/ModLoader/Logs/" ]
VOLUME [ "/tml-server/worlds/", "/tml-server/mods/" ]
VOLUME [ "/tml-server/config/", "/root/.local/share/Terraria/ModLoader/Mod Configs/" ]

EXPOSE 7777/tcp

ENTRYPOINT [ "/bin/sh", "./entrypoint.sh" ]
