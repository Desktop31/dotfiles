export ZSH="$HOME/.config/zsh"

ZSH_THEME="zsh31"

plugins=(git git-prompt zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

path+=("$HOME/.cargo/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/go/bin")
export PATH

# Import private aliases (ssh, bluetooth devices, ...)
PRIVATE_PATH="$HOME/.zsh-alias-private"
if [ -f $PRIVATE_PATH ]; then
    source $PRIVATE_PATH
fi

# -- My Aliases --
export EDITOR="nvim"
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

alias lg='lazygit'
alias ls='ls -1 --color=auto'

# -- LF config - last dir --
source "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf-shellcd/lf-shellcd"


# -- PulseAudio Tunnel Connection --
alias rpicon="~/Scripts/connectRpiTunnel.sh";

rpidis() {
    MODULE=$(cat ~/Logs/tunnel-logs.txt | grep "Tunnel successfully loaded as module" | cut -f 7 -d " " | tail -n 1)
    pactl unload-module $MODULE
}


# -- FFMPEG aliases --

# $1 - filename with extension
# $2 - (optional) new filename with extension
# $3 - (optional) compression level
ffcompress() {
    if [ -z $1 ]; then echo "No file specified" ; return 1 ; fi
    local filename=${1%.*}
    local extension=${1##*\.}
    local crfval=${3:-20}
    local tempExtension=${2##*\.}
    local newExtension=${tempExtension:-$extension}
    local newFilename="$filename-compressed.$newExtension"

    echo $newExtension

    if [[ $newExtension == "mp4" ]]; then
        ffmpeg -i "$filename.$extension" -vcodec libx264 -crf $crfval ${2:-$newFilename}
    # elif [[ $extension == "mp4" && $newExtension == "webm" ]]; then
    #     ffmpeg -i "$filename.$extension" -vcodec libvpx -acodec libvorbis -cpu-used 5 -threads 8 -crf $crfval ${2:-$newFilename}
    else
        ffmpeg -i "$filename.$extension" -crf $crfval ${2:-$newFilename}
    fi

    if [ $? -eq 0 ]; then 
        notify-send -u LOW -a "FFCOMPRESS" "Successfully compressed:" "File: '$filename.$extension'\nNew file: '${2:-$newFilename}'"
    fi
}

