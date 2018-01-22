#!/bin/bash

function ts {
  echo "[`date '+%Y-%m-%d %T'`] `basename "$(test -L "$0" && readlink "$0" || echo "$0")"`:"
}

echo "$(ts) Creating group and user "
# Create User and make Premissions on Folders
addgroup -g ${USER_ID} ${USER_NAME}
adduser  -H -D -S -u ${USER_ID} -G ${USER_NAME} ${USER_NAME}

chown -R ${USER_NAME}:${USER_NAME} $CONFIG_DIR $RECORD_DIR
chmod -R 755 $CONFIG_DIR $RECORD_DIR

echo "$(ts) Starting Tvheadend"
/usr/bin/tvheadend --firstrun -u $USER_NAME -g $USER_NAME -c /config --http_root /tvheadend/
