#!/bin/bash

if [[ "$#" -ne 0 ]]; then
	echo
	echo 'usage: $0 '
	echo
	exit 0
fi

# Get default microphone source (unnecessary I guess?)
# source=$(pactl get-default-source)
# stream=$(pactl list sources | awk "/$source/" RS= | awk '/api.alsa.pcm.stream = .*/{print $3}' | sed "s/\"//g")
# position=()
# IFS=, read -r -a position <<< $(pactl list sources | awk "/$source/" RS= | awk '/audio.position = .*/{print $3}' | sed "s/\"//g")
# 
# sep="_"
# frontLeft="$source:$stream$sep${position[0]}"
# frontRight="$source:$stream$sep${position[1]}"

# Denoised filter
denoisedInLeft="capture.rnnoise_source:input_FL"
denoisedInRight="capture.rnnoise_source:input_FR"

denoisedOutLeft="rnnoise_source:capture_1"
denoisedOutRight="rnnoise_source:capture_1"

# Virtual mic (the one to be actually used)
virtInLeft="VirtualMic:input_FL"
virtInRight="VirtualMic:input_FR"


# Link microphone to denoise filter (unnecessary I guess?)
# echo "linking: '"$frontLeft"' -> '"$denoisedInLeft"'"
# pw-link $frontLeft $denoisedInLeft >>/dev/null
# echo "linking: '"$frontRight"' -> '"$denoisedInRight"'"
# pw-link $frontRight $denoisedInRight >>/dev/null

# Link denoised filter to virtual microphone
echo "linking: '"$denoisedOutLeft"' -> '"$virtInLeft"'"
pw-link $denoisedOutLeft $virtInLeft >>/dev/null
echo "linking: '"$denoisedOutRight"' -> '"$virtInRight"'"
pw-link $denoisedOutRight $virtInRight >>/dev/null
