FROM debian:stretch
LABEL maintainer="Arsa Developers <dev@arsa.org>"
LABEL description="Dockerised ArsaCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
