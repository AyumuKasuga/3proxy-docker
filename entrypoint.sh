#!/bin/bash

if [ -z "$LOGIN" ] || [ -z "$PASSWORD" ]; then
			echo >&2 'Please specify LOGIN and PASSWORD variables `--env LOGIN=login --env PASSWORD=pasword`'
			exit 1
fi

echo "
log /dev/stdout
users $LOGIN:CL:$PASSWORD
auth strong
socks -p3128
flush
" > ./3proxy.cfg
./3proxy 3proxy.cfg
