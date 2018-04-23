FROM alpine:edge

ENV USER_NAME="tvheadend" \
	USER_ID="1000" \
	CONFIG_DIR="/config" \
	RECORD_DIR="/recordings"

# Install core packages
RUN apk add --no-cache \
	ca-certificates \
	coreutils \
	bash \
	sudo \
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
# Install build packages
apk add --no-cache --virtual=build-dependencies \
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
git clone -b release/4.2 https://github.com/tvheadend/tvheadend.git /tmp/tvheadend && \
	cd /tmp/tvheadend && \
	./configure --disable-avahi --disable-ffmpeg_static --disable-libfdkaac_static --disable-libmfx_static --disable-libtheora_static --disable-libvorbis_static --disable-libvpx_static --disable-libx264_static --disable-libx265_static --enable-libav --infodir=/usr/share/info --localstatedir=/var --mandir=/usr/share/man --prefix=/usr --sysconfdir=/config && \
	make && \
	make install && \
# Cleanup
	apk del --purge build-dependencies ffmpeg-dev && \
	rm -rf /var/cache/apk/* /tmp/*

ADD start_tvh.sh /start_tvh.sh
RUN chmod +x /start_tvh.sh

# Expose 'config' and 'recordings' directory for persistence
VOLUME ["$CONFIG_DIR","$RECORD_DIR"]

# Expose ports for 'web interface' and 'streaming'
EXPOSE 9981 9982

ENTRYPOINT ["/start_tvh.sh"]
