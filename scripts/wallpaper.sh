#!/bin/sh
devour sxiv -o -q -r -t ~/hdd/walls > ~/.config/wallpaper &&  cat ~/.config/wallpaper | xargs xwallpaper --stretch
