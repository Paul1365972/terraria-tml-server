FROM alpine:3.12

ARG TMOD_VERSION=0.11.7.5

RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del .build-dependencies

RUN apk add --no-cache tmux

WORKDIR /tml-server

ADD https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.zip tml.zip
# ADD tModLoader.Linux.v${TMOD_VERSION}.zip tml.zip
RUN unzip tml.zip -x Content/ -x System* -x Mono* -x monoconfig -x mscorlib.dll && \
    rm tml.zip

COPY entrypoint.sh ./

EXPOSE 7777/tcp

ENTRYPOINT [ "/bin/sh", "./entrypoint.sh" ]
