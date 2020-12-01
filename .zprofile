if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx "$HOME/.config/X11/.xinitrc"
fi
