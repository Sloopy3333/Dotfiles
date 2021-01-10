#!/bin/sh

cat <<EOF | xmenu | sh &
All applications
	    Browsers
		    Vimb		vimb
		    Firefox		firefox
		    Brave		brave
	    Utilities
		    vifm		st -e vifm
		    pcmanfm		pcmanfm
		    walli 		$HOME/scripts/walli
		    Volume		pavucontrol
	    Games
		    Steam		prime-run steam
	    Graphics
		    Gimp		gimp
Configs
	Qtile		st -e nvim ~/.config/qtile/config.py
	Neovim		st -e nvim ~/.config/nvim/init.vim
	Xinitrc		st -e nvim ~/.config/X11/Xinitrc
	ST		st -e nvim ~/builds/st/config.h
	Xmonad		st -e nvim ~/.config/xmonad/xmonad.hs
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Xmenu		st -e nvim ~/.config/xmenu/xmenu.sh
wifi
	on		st -e nmcli radio wifi on
	off		st -e nmcli radio wifi off
	Nmtui		st -e nmtui
Screenshot
	Full		$HOME/scripts/sc	
	Select		$HOME/scripts/sc -s	
	copy		$HOME/scripts/sc -cs	
Terminal (st)		st

Shutdown		poweroff
Reboot			reboot
Suspend			systemctl suspend
EOF
