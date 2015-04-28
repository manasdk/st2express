#!/usr/bin/env bash

TEST_ACCOUNT_USERNAME="testu"
TEST_ACCOUNT_PASSWORD="testp"

function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -V | tail -n 1)" == "$1"; }

service ssh start
service rabbitmq-server start
service mongodb start
service mysql start
st2ctl start

echo "Sleep for 10 seconds while services start..."
sleep 10

# Validate installation

VER=`st2 --version 2>&1 | cut -c 5-`
if version_ge $VER "0.9"; then
    TOKEN="-t `st2 auth ${TEST_ACCOUNT_USERNAME} -p ${TEST_ACCOUNT_PASSWORD} | grep token | awk '{print $4}'`"
fi
output=$((st2 --debug run ${TOKEN} core.local date -a) 2>&1)
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
