#!/bin/sh

echo 'Running setup...'
mkdir -p /var/lib/mpd/playlists && \
touch /var/lib/mpd/database \
    /var/lib/mpd/mpd.pid \
    /var/lib/mpd/state \
    /var/lib/mpd/sticker.sql && \
chown -R admin:audio /var/lib/mpd
echo 'Starting MPD...'
mpd --stdout --no-daemon
