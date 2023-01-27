export ZSH="$HOME/.config/zsh"

ZSH_THEME="zsh31"

plugins=(git git-prompt zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

path+=("$HOME/.cargo/bin")
path+=("$HOME/go/bin")
export PATH

# Import private aliases (ssh, bluetooth devices, ...)
PRIVATE_PATH="$HOME/.zsh-alias-private"
if [ -f $PRIVATE_PATH ]; then
    source $PRIVATE_PATH
fi

# -- My Aliases --
export EDITOR="micro"
alias ed="$EDITOR"
alias sued="sudo $EDITOR"

alias conf-polybar='ed $HOME/.config/polybar/config'
alias conf-dwm='cd $HOME/.local/src/dwm31/ && sued config.h'
alias conf-picom='ed $HOME/.config/picom/picom.conf'

alias conf-waybar='ed $HOME/.config/waybar/config'
alias conf-hyprland='ed $HOME/.config/hypr/hyprland.conf'
alias conf-keys='ed $HOME/.config/hypr/keybinds.conf'
alias conf-monitors='ed $HOME/.config/hypr/monitors.conf'
alias conf-autostart='ed $HOME/.config/hypr/autostart.conf'


# -- LF config - last dir --
source "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf-shellcd/lf-shellcd"


# -- PulseAudio Tunnel Connection --
alias rpicon="~/Scripts/connectRpiTunnel.sh";

rpidis() {
    MODULE=$(cat ~/Logs/tunnel-logs.txt | grep "Tunnel successfully loaded as module" | cut -f 7 -d " " | tail -n 1)
    pactl unload-module $MODULE
}
