FROM docker.io/library/ubuntu:22.04

MAINTAINER danilo.horta@pm.me

RUN apt-get update && apt-get upgrade --yes && apt-get install git build-essential autoconf netcat --yes

RUN mkdir -p /app/bin
RUN mkdir -p /app/data
RUN mkdir -p /app/logs

RUN git clone https://github.com/horta/hmmer.git /hmmer && cd /hmmer && git reset --hard 4debe0dd5b49fa5f8cbae20fbf66fdaebf67e836
RUN git clone https://github.com/horta/easel.git /hmmer/easel && cd /hmmer/easel && git reset --hard fc4a44acc0773125bb16dc13cf529adc99d6ddd6
RUN cd /hmmer && autoconf && ./configure && make && make dev
RUN mv /hmmer/src/hmmpgmd /app/bin/ && mv /hmmer/src/hmmpress /app/bin/
RUN rm -rf /hmmer

EXPOSE 51371
COPY entrypoint /app/bin/entrypoint
COPY check-health /app/bin/check-health
RUN chown root:root /app/bin/entrypoint
RUN chown root:root /app/bin/check-health
WORKDIR /app

ENTRYPOINT ["/app/bin/entrypoint"]
