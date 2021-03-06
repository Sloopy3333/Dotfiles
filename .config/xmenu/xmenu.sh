#!/bin/sh

cat <<EOF | xmenu | sh &
All applications
	    Browsers
		    Qutebrowser		qutebrowser
		    LibreWolf		librewolf
		    Vimb		vimb
	    Utilities
		    vifm		st -e vifm
		    pcmanfm		pcmanfm
		    walli 		$HOME/scripts/walli
		    Manpage 		$HOME/scripts/dman
		    Volume		pavucontrol
	    Games
		    Steam		prime-run steam
	    Graphics
		    Gimp		gimp
Configs
	Xmonad		st -e nvim ~/.config/xmonad/xmonad.hs
	Xinitrc		st -e nvim ~/.config/X11/Xinitrc
	Xmobar		st -e nvim ~/.config/xmobar/xmobar.config
	Qtile		st -e nvim ~/.config/qtile/config.py
	Neovim		st -e nvim ~/.config/nvim/init.vim
	ST		st -e nvim ~/builds/st/config.h
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

Lock			$HOME/scripts/lock
Shutdown		poweroff
Reboot			reboot
Suspend			systemctl suspend
EOF
