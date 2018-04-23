#!/bin/bash

function ts {
  echo "[`date '+%Y-%m-%d %T'`] `basename "$(test -L "$0" && readlink "$0" || echo "$0")"`:"
}

echo "$(ts) Creating group and user ${USER_NAME} (id ${USER_ID})..."
# Create User and make Premissions on Folders
addgroup -g ${USER_ID} ${USER_NAME}
adduser  -H -D -S -u ${USER_ID} -G ${USER_NAME} ${USER_NAME}

echo "$(ts) Check user write access on folders (user: ${USER_NAME} id ${USER_ID})"
echo "$(ts)    Check $CONFIG_DIR..."
if sudo su - $USER_NAME -c "[[ -w $CONFIG_DIR ]]" ; then 
  echo "$(ts)    Write access to $CONFIG_DIR -> OK"
  echo "$(ts)    Check $RECORD_DIR..."
  if sudo su - $USER_NAME -c "[[ -w $RECORD_DIR ]]" ; then 
    echo "$(ts)    Write access to $RECORD_DIR -> OK"
    echo "$(ts) Starting Tvheadend with $USER_NAME"
    /usr/bin/tvheadend --firstrun -u $USER_NAME -g $USER_NAME -c /config --http_root /tvheadend/
  else
    echo "$(ts)    /!\ Write access to $RECORD_DIR /!\ -> KO"
    echo "$(ts)    Exiting script..."
  fi
else
  echo "$(ts)    /!\ Write access to $CONFIG_DIR /!\ -> KO"
  echo "$(ts)    Exiting script..."
fi

#echo "$(ts) Set user ${USER_NAME} (id ${USER_ID}) owner of $CONFIG_DIR and $RECORD_DIR..."
#chown -R ${USER_NAME}:${USER_NAME} $CONFIG_DIR $RECORD_DIR
#echo "$(ts) Set permissions of $CONFIG_DIR and $RECORD_DIR to 755..."
#chmod -R u+rwx $CONFIG_DIR $RECORD_DIR
