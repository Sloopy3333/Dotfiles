#!/bin/sh

cat <<EOF | xmenu | sh &
Applications
	Firefox		firefox -p
	Pcmanfm		pcmanfm
	nitrogen	nitrogen
	Steam		__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam
	Virt-manager	virt-manager
Configs
	Xmonad		st -e nvim ~/.xmonad/xmonad.hs
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Xmenu		st -e nvim ~/.config/xmobar/xmenu.sh
	ST		st -e nvim ~/builds/st/config.def.h
	Nvim		st -e nvim ~/.config/nvim/init.vim
	Xinitrc		st -e nvim ~/.xinitrc
Network
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
