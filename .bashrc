#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
PS1="\\[\e[1;43;30m\\] \u \\[\e[0;47;33m\\] \\[\e[47;1;3;33m\\]\w\a \\[\e[0;37m\\]\n\\[\e[1;33m\\]\\[\e[0;39m\\] "

alias config-polybar='sudo micro $HOME/.config/polybar/config'
alias config-dwm='cd $HOME/.config/dwm31/ && sudo micro config.h'
alias config-picom='sudo micro $HOME/.config/picom/picom.conf'

[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
