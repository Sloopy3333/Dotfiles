#!/bin/sh

cat <<EOF | xmenu | sh &
Applications
	Firefox		firefox
	Pcmanfm		pcmanfm
	nitrogen	nitrogen
	Steam		prime-run steam
	Virt-manager	virt-manager
Configs
	Xmonad		st -e nvim ~/.xmonad/xmonad.hs
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Xmenu		st -e nvim ~/.config/xmobar/xmenu.sh
	ST		st -e nvim ~/builds/st/config.def.h
	Stalonetray	st -e nvim ~/.config/stalonetrayrc/.stalonetrayrc
	Nvim		st -e nvim ~/.config/nvim/init.vim
	Xinitrc		st -e nvim ~/.xinitrc
Network
	WIFI ON		nmcli radio wifi on
	WIFI OFF	nmcli radio wifi off
	Nmtui		st -e nmtui
	Connect		st -e nmcli --ask device wifi connect
Screenshot
	Full		maim ~/hdd/screenshots/$(date +%s).png
	Select		maim -s ~/hdd/screenshots/$(date +%s).png
	copy		maim -s | xclip -selection clipboard -t image/png
Terminal (st)		st
Power
	Suspend			systemctl suspend
	Shutdown		systemctl poweroff
	Reboot			systemctl reboot
EOF
