# mpd-docker
MPD intended to run on my music fileserver so I can stream from it.

I also have a webserver serving up my music library, which works together with this MPD instance.

On my client machines I have another instance of MPD, using the proxy database plugin to find stuff on the webserver.
The clients can then stream the files over HTTP/S. The client machine MPD configuration looks like this:
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

