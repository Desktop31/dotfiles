# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="zsh31"

plugins=(git git-prompt zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# -- My Aliases --
alias config-polybar='sudo micro $HOME/.config/polybar/config'
alias config-dwm='cd $HOME/.config/dwm31/ && sudo micro config.h'
alias config-picom='sudo micro $HOME/.config/picom/picom.conf'
alias ed="micro"
alias sued="sudo micro"

# --
