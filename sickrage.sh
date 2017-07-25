#!/bin/bash
umask 000

userName=sickrage
groupName=sickrage

# Modify user ID by env USER_ID
if [ -z "$USER_ID" ]; then
  echo "User modification not requested"
else
  deluser sickrage
  adduser -D -u $USER_ID -s /bin/bash sickrage
fi

# Modify group ID by env GROUP_ID
if [ -z "$GROUP_ID" ] || [ "$GROUP_ID" = "$USER_ID" ]; then
  echo "Group modification not needed"
else
    addgroup -g $GROUP_ID sickrage_group
    addgroup sickrage sickrage_group
    groupName=sickrage_group
fi

chown -R ${userName}:${groupName} /config
chown -R ${userName}:${groupName} /library
chown -R ${userName}:${groupName} /downloads

if [ -f /config/config-base.ini ] && [ ! -f /config/config-real.ini ]
then
    echo "Copying config-base.ini to config-real.ini"
    cp /config/config-base.ini /config/config-real.ini
fi

rm -rf /opt/sickrage
#sleep 4 && git clone --depth 1 https://github.com/SickRage/SickRage.git /opt/sickrage
#sleep 4 && git clone --depth 1 https://bitbucket.org/bigspringsgroup/sickrage.git /opt/sickrage
sleep 4 && git clone --depth 1 https://donna.devices.wvvw.me/sickrage/sickrage.git /opt/sickrage
chown -R sickrage:sickrage /opt/sickrage
#pip install -r /opt/sickrage/requirements.txt

echo "Running sickrage"
exec su -l sickrage -s /bin/bash -c "exec run.sh"
