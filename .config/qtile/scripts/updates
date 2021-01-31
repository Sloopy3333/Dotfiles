#!/bin/sh
UPDATES="$(sudo pacman -Qu | grep -Fcv '[ignored]')"
[ "$UPDATES" -eq 0 ] && exit 0

echo " 📦 $UPDATES "

