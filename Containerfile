FROM docker.io/library/ubuntu:22.04

LABEL maintainer="Danilo Horta <danilo.horta@pm.me>"

RUN apt-get update
RUN apt-get upgrade --yes

RUN apt-get install git build-essential autoconf --yes
RUN git clone --depth 1 --single-branch --branch develop https://github.com/EddyRivasLab/hmmer.git /hmmer
RUN git clone --depth 1 --single-branch --branch develop https://github.com/EddyRivasLab/easel.git /hmmer/easel
RUN cd /hmmer && autoconf && ./configure && make && make dev

RUN mkdir -p /app/bin
RUN mkdir -p /app/data
RUN mv /hmmer/src/hmmpgmd /app/bin/ && mv /hmmer/src/hmmpress /app/bin/

EXPOSE 51371

COPY master.sh /app/bin/
WORKDIR /app

ENTRYPOINT ["/app/bin/master.sh"]
