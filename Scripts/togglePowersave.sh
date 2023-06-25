#!/bin/bash


# Wallpaper on/off
wallOff() {
	killall hyprpaper
}

wallOn() {
	hyprpaper &
}


# Turn media module in waybar (WayBarMedia) on/off 
# and refresh waybar
wbRefresh() {
	killall waybar
	waybar &
}

wbmOff() {
	# comment line with media module
	sed -Ei "s/^\s*.*\/\/REGULAR/\/\/ &/" "$HOME/.config/waybar/config"
	# uncomment line without media module
	sed -Ei "/^\s*\/\/\s*.*\/\/POWERSAVE/"'s/\/\/\s//' "$HOME/.config/waybar/config"
	wbRefresh
}

wbmOn() {
	# comment line without media module
	sed -Ei "s/^\s*.*\/\/POWERSAVE/\/\/ &/" "$HOME/.config/waybar/config"
	# uncomment line with media module 
	sed -Ei "/^\s*\/\/\s*.*\/\/REGULAR/"'s/\/\/\s//' "$HOME/.config/waybar/config"

	wbRefresh
}


# Turn hyprland animations on/off
animOff() {
	hyprctl keyword animations:enabled 0
}

animOn() {
	hyprctl keyword animations:enabled 1
}


# Turn hyprland blur on/off
blurOff() {
	hyprctl keyword decoration:blur 0
}

blurOn() {
	hyprctl keyword decoration:blur 1
}


# Turn transparency on/off
transOff() {
	sed -Ei "s/^windowrule\s*=\s*opacity.*/# &/g" "$HOME/.config/hypr/hyprland.conf"
}

transOn() {
	sed -Ei "/^# windowrule\s*=\s*opacity.*/"'s/^#\s?//' "$HOME/.config/hypr/hyprland.conf"
}



#----------------------------

# Turn on powersave
powersaveOn() {
	wallOff
	wbmOff
	transOff
	sleep 1
	animOff
	blurOff
}

# Turn off powersave
powersaveOff() {
	wallOn
	wbmOn
	transOn
	sleep 1
	animOn
	blurOn
}

#----------------------------

# Toggle
if [[ -n $(pidof hyprpaper) ]]; then
	powersaveOn
else
	powersaveOff
fi
