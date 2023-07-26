#!/bin/sh

# Connects to the specified pulse audio tunnel
# 
# TODO: currently does not check if the tunnel actually exists on the device

LOG_FOLDER="$HOME/.logs"
LOG_DEST="$LOG_FOLDER/tunnel-logs.txt"
DFORMAT="+[%d.%m.%Y|%H:%M:%S]"

HOST="10.0.0.70"
TIMEOUT=10
ATTEMPTS=10


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

MODULE=$(pactl load-module module-tunnel-sink server=tcp:$HOST rate=48000 channels=2 sink_name=GooberTunnel sink_properties=device.description=GooberTunnel)

echo "$(date $DFORMAT) Tunnel successfully loaded as module $MODULE" >>$LOG_DEST
