FROM docker.io/library/ubuntu:22.04

MAINTAINER danilo.horta@pm.me

RUN apt-get update && apt-get upgrade --yes && apt-get install git build-essential autoconf supervisor --yes

RUN mkdir -p /app/bin
RUN mkdir -p /app/data
RUN mkdir -p /app/logs

RUN git clone --depth 1 --single-branch --branch develop https://github.com/EddyRivasLab/hmmer.git /hmmer
RUN git clone --depth 1 --single-branch --branch develop https://github.com/EddyRivasLab/easel.git /hmmer/easel
RUN cd /hmmer && autoconf && ./configure && make && make dev
RUN mv /hmmer/src/hmmpgmd /app/bin/ && mv /hmmer/src/hmmpress /app/bin/
RUN rm -rf /hmmer

EXPOSE 51371
COPY supervisord.conf /app/conf/supervisord.conf
COPY entrypoint /app/bin/entrypoint
RUN chown root:root /app/conf/supervisord.conf
RUN chown root:root /app/bin/entrypoint
WORKDIR /app

ENTRYPOINT ["/app/bin/entrypoint"]
