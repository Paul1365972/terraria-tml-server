FROM frolvlad/alpine-mono:5.20-glibc

ARG TMOD_VERSION=0.11.7.5

WORKDIR /tml-server

ADD https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.zip tml.zip
# ADD tModLoader.Linux.v${TMOD_VERSION}.zip tml.zip
RUN unzip tml.zip -x Content/ -x System* -x Mono* -x monoconfig -x mscorlib.dll && \
    rm tml.zip

COPY entrypoint.sh ./

EXPOSE 7777/tcp

ENTRYPOINT [ "/bin/sh", "./entrypoint.sh" ]
