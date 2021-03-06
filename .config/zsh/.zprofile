[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$HOME/.config/X11/Xinitrc"
