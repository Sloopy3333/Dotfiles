# comand completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
setopt COMPLETE_ALIASES
setopt autocd
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always


