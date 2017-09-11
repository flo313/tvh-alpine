FROM alpine:edge

# Install core packages
RUN apk add --no-cache \
	ca-certificates \
	coreutils \
	libhdhomerun \
	tzdata \
# Install runtime packages
	bzip2 \
	curl \
	ffmpeg-libs \
	ffmpeg \
	gettext \
	gzip \
	python \
	socat \
	tar \
	uriparser \
	zlib && \

# Create user
adduser -H -D -S -u 99 -G users -s /sbin/nologin duser && \
adduser duser video && \

# Install build packages
apk add --no-cache --virtual=build-dependencies \
	bash \
	bsd-compat-headers \
	cmake \
	curl \
	curl-dev \
	findutils \
	ffmpeg-dev \
	gettext-dev \
	gcc \
	git \
	g++ \
	libressl-dev \
	libvpx-dev \
	linux-headers \
	make \
	opus-dev \
	tar \
	uriparser-dev \
	wget \
	x264-dev \
	x265-dev \
	zlib-dev && \

# Build tvheadend
git clone -b master https://github.com/tvheadend/tvheadend.git /tmp/tvheadend && \
	cd /tmp/tvheadend && \
	./configure --disable-avahi --disable-ffmpeg_static --disable-libfdkaac_static --disable-libmfx_static --disable-libtheora_static --disable-libvorbis_static --disable-libvpx_static --disable-libx264_static --disable-libx265_static --enable-libav --infodir=/usr/share/info --localstatedir=/var --mandir=/usr/share/man --prefix=/usr --sysconfdir=/config && \
	make && \
	make install && \

# Cleanup
apk del --purge build-dependencies ffmpeg-dev && \
rm -rf /var/cache/apk/* /tmp/*

# Expose 'config' and 'recordings' directory for persistence
VOLUME /config /recordings

# Expose ports for 'web interface' and 'streaming'
EXPOSE 9981 9982

ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["--firstrun", "-u", "root", "-g", "root", "-c", "/config","--http_root","/tvheadend/"]
