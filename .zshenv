typeset -U PATH path

# XDG 
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_BIN_HOME=${XDG_BIN_HOME:="$HOME/.local/bin"}
export XDG_RUNTIME_DIR=/run/user/$(id -u)


export LESSHISTFILE='-'

# other applications

ZDOTDIR=$HOME/.config/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export XMONAD_CONFIG_DIR="$XDG_CONFIG_HOME"/xmonad
export XMONAD_DATA_DIR="$XDG_DATA_HOME"/xmonad
export XMONAD_CACHE_DIR="$XDG_CACHE_HOME"/xmonad

