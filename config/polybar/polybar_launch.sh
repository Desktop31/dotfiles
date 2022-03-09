#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch bar

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar main -r &
done


#external_monitor=$(autorandr | grep detected | cut -f1 -d' ' | tr -d ' ')
#case $external_monitor in
#    single-monitor) polybar main -r &;;
#    dual-monitor) MONITOR=DP-3 polybar main & MONITOR=DP-1 polybar main -r &;;
#esac
