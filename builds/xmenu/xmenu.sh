#!/bin/sh

cat <<EOF | xmenu | sh &
Applications
	brave		brave-browser
	pcmanfm		pcmanfm
	qutebrowser	qutebrowser
	Steam		__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam
	Nitrogen	nitrogen
Configs
	Xmonad		st -e nvim ~/.xmonad/xmonad.hs
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Xmenu		st -e nvim ~/.config/xmobar/xmenu.sh
	ST		st -e nvim ~/builds/st/config.def.h
	Nvim		st -e nvim ~/.config/nvim/init.vim
	Xinitrc		st -e nvim ~/.xinitrc
Network
	Scan		st -e nmcli dev wifi
	Nmtui		st -e nmtui
	Connect		st -e nmcli --ask device wifi connect
Screenshot
	Full		maim ~/hdd/screenshots/$(date =%s).png
	Select		maim -s ~/hdd/screenshots/$(date =%s).png
	copy		maim -s | xclip -selection clipboard -t image/png
System76
	Hybrid		st -e system76-power graphics hybrid
	Intel		st -e system76-power graphics integrated
	compute		st -e system76-power graphics compute
	Nvidia		st -e system76-power graphics nvidia
	Power		
		Battery		system76-power profile battery
		Balanced	system76-power profile balanced
		Performance	system76-power profile performance
Terminal (st)		st

Shutdown		poweroff
Reboot			reboot
Suspend			systemctl suspend
EOF
