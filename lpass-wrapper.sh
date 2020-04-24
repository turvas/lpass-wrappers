#!/bin/bash
# lpass-wrapper.sh
# can be run all lpass commads, ensuring agent is active, if not then authenticate
# initial ideas from https://svkt.org/~simias/lpass/

/usr/bin/which lpass > /dev/null
if [ $? -ne 0 ]; then
        echo lpass not found in PATH, please install 
        echo more info from https://github.com/lastpass/lastpass-cli
        exit 1
fi

username="$USER@bytelife.com"

status=$(lpass status)
if [ $? -ne 0 ]; then
    if [ "$status" = 'Not logged in.' ]; then
	# Make sure DISPLAY is set
	DISPLAY=${DISPLAY:-:0} lpass login "$username" 1>&2
    else
	echo "Lastpass error: $status" 1>&2
	exit 1
    fi
fi

lpass $@
