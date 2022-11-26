# mpd-satellite-docker
MPD intended to run on a music fileserver for other instances of MPD running on client devices to stream from. This is known as the ["satellite setup"](https://wiki.archlinux.org/title/Music_Player_Daemon/Tips_and_tricks#Music_streaming_with_the_satellite_setup).

It works in conjuction with a webserver, which handles actually serving the files. [nginx's autoindex](https://nginx.org/en/docs/http/ngx_http_autoindex_module.html) is a good option for this.

Client machine instances of MPD connect to this instance of MPD using the proxy database plugin so they can find stuff on the webserver. The clients can then stream the files over HTTP/S. The client machine MPD configuration looks like this:
```
music_directory "http://<server address>:<webserver port>/"

database {
  plugin "proxy"
  host "<server address>"
}
```

## Usage:
Use `docker-compose.yaml` (included in this repo):
```
version: "3.8"

services:

  mpd:
    image: blaxpot/mpd
    ports:
      - "6600:6600"
      - "8800:8800"
    volumes:
      - <your music>:/music
      - <your mpd dir>:/var/lib/mpd
    restart: unless-stopped
    command: "100"  # This arg specifies the UID that will be given to the MPD user. Set to the owner of /music.
```
e.g.:
```
cd /path/to/mpd-docker
docker compose up -d
```

or do `docker run` like so:
```
docker run -d \
--name mpd \
-p 6600:6600 \
-p 8000:8000 \
-v <your music>:/music \
-v <your mpd dir>:/var/lib/mpd \
blaxpot/mpd 100 # Last arg specifies the UID that will be given to the MPD user. Set to the owner of /music.
```

