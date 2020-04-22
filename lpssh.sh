#!/bin/bash
# lpssh.sh

# asumes wrapper is in same dir
DIR=$(dirname $0)
ID=$1
PW=$($DIR/lpass-wrapper.sh show -p $ID)
USR=$($DIR/lpass-wrapper.sh show -u $ID)
HN=$($DIR/lpass-wrapper.sh show --field=Hostname $ID)
echo Connecting: $USR@$HN
sshpass -p"$PW" ssh $USR@$HN
