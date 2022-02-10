#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch bar

external_monitor=$(autorandr | grep detected | cut -f1 -d' ' | tr -d ' ')
case $external_monitor in
    dock) polybar external & polybar main &;;
    external) polybar external -r &;;
    main) polybar main -r &;;
esac
