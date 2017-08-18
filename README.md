# tvh-alpine

Tvheadend (stable) based on Alpine Linux with libav for transcoding.

Volumes
/config
/data
/recordings

Usage
docker run -d --name="tvheadend" \
    -v /mnt/cache/appdata/tvheadend/config:/config \
    -v /mnt/cache/appdata/tvheadend/data:/data \
    -v /mnt/cache/recordings:/recordings \
    -p 9981:9981 \
    -p 9982:9982 \
    --device /dev/dvb \
    tunip/tvheadend
