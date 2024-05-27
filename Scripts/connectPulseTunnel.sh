#!/bin/sh

# Connects to the specified pulse audio tunnel
# 
# TODO: currently does not check if the tunnel actually exists on the device

HOST="192.168.51.70"
TunnelName="GooberTunnel"
TIMEOUT=10
ATTEMPTS=10

if [ -n "$1" ]; then
    HOST=$1
fi

if [ -n "$2" ]; then
    TunnelName=$2
fi

LOG_FOLDER="$HOME/.logs"
LOG_DEST="$LOG_FOLDER/tunnel-$TunnelName.log"
DFORMAT="+[%d.%m.%Y|%H:%M:%S]"

if [ ! -e LOG_FOLDER ]
then
	mkdir -p $LOG_FOLDER
fi

# Check if it already exists
NAME=$(pactl list | grep -B 1 "server=tcp:$HOST" | head -n 1 | cut -f 2 -d ":")
[ -z $NAME ] && NAME="None"

echo "--------------------------------------------------" >>$LOG_DEST

if [ $NAME == "module-tunnel-sink" ]
then
	echo "$(date $DFORMAT) Connection already exists" >>$LOG_DEST
	exit 1
fi

# Check for host availability
ping -c 1 $HOST &>/dev/null
RES=$?
COUNT=0

while [ $RES != "0" ]
do
	if [ $COUNT -ge $ATTEMPTS ]
	then
		echo "$(date $DFORMAT) Maximum number of attempts reached, aborting" >>$LOG_DEST
		exit 1
	fi
	
	echo "$(date $DFORMAT) Destination $HOST unreachable, retrying in $TIMEOUT seconds" >>$LOG_DEST
	sleep $TIMEOUT
	RES=ping -c 1 $HOST &>/dev/null
	((COUNT++))
done

echo "$(date $DFORMAT) Host $HOST found, loading module" >>$LOG_DEST

MODULE=$(pactl load-module module-tunnel-sink server=tcp:"$HOST" rate=44100 channels=1 sink_name="$TunnelName" sink_properties=device.description="$TunnelName")

echo "$(date $DFORMAT) Tunnel successfully loaded as module $MODULE" >>$LOG_DEST
