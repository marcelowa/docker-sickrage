FROM alpine:3.6
MAINTAINER Marcelo Waisman <marcelo.waisman@gmail.com>

RUN apk --update add \
    nodejs \
    unrar \
    bash \
    python \
    py-pip \
    git \
    py-lxml \
    && adduser -D -s /bin/bash sickrage \
    && rm -rf /var/cache/apk/*

EXPOSE 8081

VOLUME /config /downloads /library

COPY sickrage.sh /usr/bin/
COPY run.sh /usr/bin/

CMD "sickrage.sh"
