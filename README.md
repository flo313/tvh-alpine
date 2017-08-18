# Image
[![](https://images.microbadger.com/badges/image/tunip/tvheadend.svg)](https://microbadger.com/images/tunip/tvheadend "Get your own image badge on microbadger.com")

# About
![Tvheadend](https://github.com/tunip/docker-tvheadend/raw/master/tvheadend.png)

Tvheadend (stable) based on Alpine Linux with libav for transcoding.

# Volumes
```
/config
/data
/recordings
 ```
 
# Usage
```
docker run -d --name="tvheadend" \
    -v /mnt/cache/appdata/tvheadend/config:/config \
    -v /mnt/cache/appdata/tvheadend/data:/data \
    -v /mnt/cache/recordings:/recordings \
    -p 9981:9981 \
    -p 9982:9982 \
    --device /dev/dvb \
    tunip/tvheadend
```
