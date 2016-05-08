FROM alpine:3.3
MAINTAINER Marcelo Waisman <marcelo.waisman@gmail.com>

RUN apk --update add \
    bash \
    python \
    git \
    py-lxml \
    && adduser -D -s /bin/bash sickrage \
    && rm -rf /var/cache/apk/*

EXPOSE 8081

VOLUME /config /downloads /library

COPY sickrage.sh /usr/bin/
COPY run.sh /usr/bin/

ENTRYPOINT ["sickrage.sh"]
