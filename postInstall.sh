#!/bin/bash

# Usage: ./postInstall.sh "username"

# --- VARS ---
DOTSDIR="$(realpath "$(dirname -- "$0")")"
USERNAME=$1

# --- FUNCTIONS ---
configFromTemplates() {
    # Waybar
    cp "$DOTSDIR/config/waybar/config.template" "$DOTSDIR/config/waybar/config"

    # xfce thunar layout
    cp "$DOTSDIR/config/xfconf/xfce-perchannel-xml/thunar.xml.template" "$DOTSDIR/config/xfconf/xfce-perchannel-xml/thunar.xml"
    sed -Ei "s/username/$USERNAME/" "$DOTSDIR/config/xfconf/xfce-perchannel-xml/thunar.xml"
}


# --- EXECUTION ---
if [[ -z "$USERNAME" ]]; then
    exit 1
fi

configFromTemplates
