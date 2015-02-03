#!/usr/bin/env bash

service ssh start
service rabbitmq-server start
service mongodb start
service mysql start
st2ctl start

echo "Sleep for 10 seconds while services start..."
sleep 10

# Validate installation
output=$((st2 --debug run core.local date -a) 2>&1)
ACTIONEXIT=$?

echo "=============================="
echo ""

if [ "${ACTIONEXIT}" != 0 ]
then
  echo "ERROR!"
  echo "Something went wrong, st2 failed to start"
  echo "Command output:"
  echo "${output}"
  echo "Logs are available at /var/log/st2/"
  exit 2
else
  echo "      _   ___     ____  _  __ "
  echo "     | | |__ \   / __ \| |/ / "
  echo "  ___| |_   ) | | |  | | ' /  "
  echo " / __| __| / /  | |  | |  <   "
  echo " \__ \ |_ / /_  | |__| | . \  "
  echo " |___/\__|____|  \____/|_|\_\ "
  echo ""
  echo "  st2 is installed and ready  "
fi
