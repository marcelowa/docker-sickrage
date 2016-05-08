#!/bin/bash
umask 000

chown -R sickrage:sickrage /config
chown -R sickrage:sickrage /library
chown -R sickrage:sickrage /downloads

# Modify user ID by env USER_ID
if [ -z "$USER_ID" ]; then
  echo "User ID modification not requested"
else
  usermod -u $USER_ID sickrage
fi

# Modify group ID by env GROUP_ID
if [ -z "$GROUP_ID" ]; then
  echo "Group ID modification not requested"
else
    groupmod -g $GROUP_ID sickrage
fi

if [ -f /config/config-base.ini ] && [ ! -f /config/config-real.ini ]
then
    echo "Copying config-base.ini to config-real.ini"
    cp /config/config-base.ini /config/config-real.ini
fi

rm -rf /opt/sickrage
git clone --depth 1 http://github.com/SickRage/SickRage.git /opt/sickrage
chown -R sickrage:sickrage /opt/sickrage

echo "Running sickrage"
exec su -l sickrage -s /bin/bash -c "exec run.sh"
