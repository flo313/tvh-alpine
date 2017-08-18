# About
![Tvheadend](https://github.com/flo313/tvh-alpine/blob/master/logoTvheadend.png)

Tvheadend (stable-master branch) based on Alpine Linux with libav for transcoding.

# Volumes
```
/config
/data
/recordings
 ```
# Ports
```
9981: Web interface port
9982: Streaming port
 ```
 
# Usage
```
docker run -d --name="tvheadend" \
    -v /path/to/config:/config \
    -v /path/to/data:/data \
    -v /path/to/recordings:/recordings \
    -p 9981:9981 \
    -p 9982:9982 \
    --device /dev/dvb \
    flo313/tvh-alpine
```
