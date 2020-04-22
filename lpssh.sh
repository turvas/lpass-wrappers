#!/bin/bash
# lpssh.sh
# SSH with LastPass inegration

# asumes wrapper is in same dir
DIR=$(dirname $0)
ID=$1
USR=$($DIR/lpass-wrapper.sh show -u $ID)
if [ $? -ne 0 ]; then # if not found, then no point to continue
        exit 1
fi
PW=$($DIR/lpass-wrapper.sh show -p $ID)
HN=$($DIR/lpass-wrapper.sh show --field=Hostname $ID)
if [ -z "$HN" ]; then # if empty, lets tru URL and extract hostname
        echo Hostname field not found, trying extract hostname from URL
        HN=$($DIR/lpass-wrapper.sh show --url $ID | awk -F "/" '{print $3}')
fi
echo Connecting: $USR@$HN
shift
sshpass -p"$PW" ssh $USR@$HN $@
