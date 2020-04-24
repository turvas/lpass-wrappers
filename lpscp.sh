#!/bin/bash
# lpssh.sh
# SCP with LastPass inegration

# asumes wrapper is in same dir
DIR=$(dirname $0)
ID=$(echo $1 | awk -F ":" '{print $1}')
#echo ID=$ID
FPATH=$(echo $1 | awk -F ":" '{print $2}')
USR=$($DIR/lpass-wrapper.sh show -u $ID)
if [ $? -ne 0 ]; then # if not found, then no point to continue
        echo Username not found, exiting..
        exit 1
fi
PW=$($DIR/lpass-wrapper.sh show -p $ID)
HN=$($DIR/lpass-wrapper.sh show --field=Hostname $ID)
if [ -z "$HN" ]; then # if empty, lets tru URL and extract hostname
        echo Hostname field not found, trying extract hostname from URL
        HN=$($DIR/lpass-wrapper.sh show --url $ID | awk -F "/" '{print $3}')
fi
echo Copy from: $USR@$HN:$FPATH to $2
sshpass -p"$PW" scp $USR@$HN:$FPATH $2
