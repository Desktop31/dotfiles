#!/usr/bin/env bash

theme="powermenu31"
dir="$HOME/.config/rofi/themes/powermenu"


uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/$theme"

# Options
# shutdown=""
# reboot=""
# lock=""
# suspend=""
# hibernate=""
# logout=""

shutdown=""
reboot=""
lock=""
suspend=""
hibernate=""
logout=""

#     

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$hibernate\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
        if systemctl status lightdm.service; then
            dm-tool lock
		elif [[ -f /usr/bin/swaylock ]]; then
			swaylock \
				--screenshots \
				--clock \
				--indicator \
				--indicator-radius 100 \
				--indicator-thickness 7 \
				--effect-blur 10x9 \
				--effect-vignette 0.5:0.5 \
				--ring-color 9e891b \
				--key-hl-color C0431C \
				--line-color 00000000 \
				--inside-color 2C2C2C \
				--separator-color 00000000 \
				--grace 2 \
				--fade-in 0.2
		fi
        ;;
    $suspend)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			# mpc -q pause
			# amixer set Master mute
			playerctl pause
			systemctl suspend
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $hibernate)
   		ans=$(confirm_exit &)
   		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
   			# mpc -q pause
   			# amixer set Master mute
   			playerctl pause
   			systemctl hibernate
   		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
   			exit 0
           else
   			msg
           fi
           ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == "dwm" ]]; then
				pkill dwm
			elif [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
				hyprctl dispatch exit none
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
