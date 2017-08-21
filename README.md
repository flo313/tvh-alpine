# About
![Tvheadend](https://github.com/flo313/tvh-alpine/blob/master/logoTvheadend.png)

Tvheadend (stable-master branch) based on Alpine Linux with libav for transcoding.

# Volumes
```
/config
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
    -v /path/to/recordings:/recordings \
    -p 9981:9981 \
    -p 9982:9982 \
    --device /dev/dvb/adapter0 \
    flo313/tvh-alpine
```
# Hdhomerun or IPTV specific cases
```
To be able to use Hdhomerun or IPTV features,
--net="host" argument must be use instead of standard port binding.
(unavailable with a Docker4Windows installation)

To acces to the container service then,
simply access to the exposed port: http://DOCKERHOSTIP:9981/tvheadend

docker run -d --name="tvheadend" \
    -v /path/to/config:/config \
    -v /path/to/recordings:/recordings \
    --net="host" \
    --device /dev/dvb/adapter0 \
    flo313/tvh-alpine
```
