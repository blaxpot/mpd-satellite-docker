FROM alpine:3.16

RUN set -ex && \
    apk add --no-cache libcap mpd mpc && \
    setcap -r /usr/bin/mpd && \
    apk del libcap && \
    mkdir -p /music

COPY mpd.conf /etc/mpd.conf

COPY mpd.sh /mpd.sh

VOLUME /var/lib/mpd

EXPOSE 6600 8000

ENTRYPOINT ["sh", "mpd.sh"]

