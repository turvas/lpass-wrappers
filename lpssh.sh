#!/bin/bash
# lpssh.sh
# SSH with LastPass inegration

# asumes wrapper is in same dir
DIR=$(dirname $0)
ID=$1
PW=$($DIR/lpass-wrapper.sh show -p $ID)
USR=$($DIR/lpass-wrapper.sh show -u $ID)
HN=$($DIR/lpass-wrapper.sh show --field=Hostname $ID)
echo Connecting: $USR@$HN
shift
sshpass -p"$PW" ssh $USR@$HN $@
