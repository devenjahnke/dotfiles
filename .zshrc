##
# ZSH Configuration
##

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

zstyle ':omz:update' mode auto

ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

##
# User configuration
##

export DEFAULT_USER=$USER

prompt_dir() {
  prompt_segment blue white '%B%~%b'
}

