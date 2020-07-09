ARG ALPINE_MONO_VERSION=5.20

FROM frolvlad/alpine-mono:${ALPINE_MONO_VERSION}-glibc

ARG TMOD_VERSION=0.11.7.5

WORKDIR /tml-server

RUN wget -qO tml.zip https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.zip

RUN unzip -q tml.zip && \
    find . ! -name 'tModLoaderServer.exe' ! -name 'FNA.dll' -delete

COPY entrypoint.sh ./

EXPOSE 7777/tcp

ENTRYPOINT [ "/bin/sh", "./entrypoint.sh" ]
