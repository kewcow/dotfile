export ZSH="$HOME/.oh-my-zsh"

# Theme Config
ZSH_THEME="spaceship"

SPACESHIP_NODE_SYMBOL=(" ")

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Alias
alias ls="exa --icons"
