#!/usr/bin/env bash


theme="launcher31"
dir="$HOME/.config/rofi/themes/launcher"

# comment these lines to disable random style
#themes=($(ls -p --hide="launcher.sh" $dir))
#theme="${themes[$(( $RANDOM % 16 ))]}"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
