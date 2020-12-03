#!/bin/sh

cat <<EOF | xmenu | sh &
Applications
	Brave		brave
	Firefox		firefox
	pcmanfm		pcmanfm
	Steam		prime-run steam
	Nitrogen	nitrogen
Configs
	Qtile		st -e nvim ~/.config/qtile/config.py
	Xmonad		st -e nvim ~/.xmonad/xmonad.hs
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Xmenu		st -e nvim ~/.config/qtile/xmenu.sh
	ST		st -e nvim ~/builds/st/config.def.h
	Nvim		st -e nvim ~/.config/nvim/init.vim
	Xinitrc		st -e nvim ~/.config/X11/.xinitrc
Network
	Scan		st -e nmcli dev wifi
	Nmtui		st -e nmtui
	Connect		st -e nmcli --ask device wifi connect
Screenshot
	Full		maim ~/hdd/screenshots/$(date +%s).png
	Select		maim -s ~/hdd/screenshots/$(date +%s).png
	copy		maim -s | xclip -selection clipboard -t image/png
Terminal (st)		st

Shutdown		poweroff
Reboot			reboot
Suspend			systemctl suspend
EOF
