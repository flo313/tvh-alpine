#!/bin/bash

function ts {
  echo "[`date '+%Y-%m-%d %T'`] `basename "$(test -L "$0" && readlink "$0" || echo "$0")"`:"
}

echo "$(ts) Creating group and user '${USER_NAME}' (id '${USER_ID}')..."
# Create User and make Premissions on Folders
addgroup -g ${USER_ID} ${USER_NAME}
adduser -D -S -s /bin/bash -u ${USER_ID} -G ${USER_NAME} ${USER_NAME}

echo "$(ts) Check user write access on folders (user: '${USER_NAME}' id '${USER_ID}')"
echo "$(ts)    Check '$CONFIG_DIR'..."
if sudo su - $USER_NAME -c "[[ -w $CONFIG_DIR ]]" ; then 
  echo "$(ts)    Write access to '$CONFIG_DIR' -> OK"
  echo "$(ts)    Check '$RECORD_DIR'..."
  if sudo su - $USER_NAME -c "[[ -w $RECORD_DIR ]]" ; then 
    echo "$(ts)    Write access to '$RECORD_DIR' -> OK"
    for ADAPTER_PATH in /dev/dvb /dev/sundtek
	do
		echo "$(ts)    Check if '${ADAPTER_PATH}' dir exists..."
		if [ -d ${ADAPTER_PATH} ] ; then
		  echo "$(ts)    '${ADAPTER_PATH}' exists, changing his owner ('chown -R ${USER_NAME} ${ADAPTER_PATH}')..."
		  chown -R ${USER_NAME} ${ADAPTER_PATH}
		else
		  echo "$(ts)    '${ADAPTER_PATH}' doesn't exists, skip dvb adapter configuration."
		fi
	done
    echo "$(ts) Starting Tvheadend with '$USER_NAME' user"
    /usr/bin/tvheadend --firstrun -u $USER_NAME -g $USER_NAME -c /config --http_root /tvheadend/
  else
    echo "$(ts)    /!\ Write access to '$RECORD_DIR' /!\ -> KO"
    echo "$(ts)    Exiting script..."
  fi
else
  echo "$(ts)    /!\ Write access to '$CONFIG_DIR' /!\ -> KO"
  echo "$(ts)    Exiting script..."
fi
