ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[gray]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}*%{$fg[gray]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT="%K{yellow}%B%F{008} %n%b %F{yellow}%K{black} %F{yellow}%B%~ \$(git_prompt_info)%b%F{black}%k"$'\n'"%k%B%F{yellow} %b%f%k"

LS_COLORS="di=1;33"
export LS_COLORS
alias ls='ls --color=auto'

# Stolen execution timer - source: https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0
function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    export RPROMPT="%F{yellow}${elapsed}ms %{$reset_color%}"
    unset timer
  fi
}
