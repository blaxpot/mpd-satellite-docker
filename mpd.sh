#!/bin/sh

UID=${1:-100}

case "${UID}" in
    ''|*[!0-9]*)
      echo 'Please pass a numeric UID for MPD to run as (default 100)'
      ;;
    *)
      ;;
esac

echo "Setting up MPD directory for UID ${UID}..."
mkdir -p /var/lib/mpd/playlists && \
touch /var/lib/mpd/database \
    /var/lib/mpd/mpd.pid \
    /var/lib/mpd/state \
    /var/lib/mpd/sticker.sql && \
adduser -S -u 1024 -G audio -s /bin/sh admin && \
chown -R admin:audio /var/lib/mpd
chown admin:audio /music
echo 'Starting MPD...'
mpd --stdout --no-daemon
