#!/bin/sh
# script to stop auto suspending mouse in powertop
sleep 5;
MOUSE='/sys/bus/usb/devices/1-4/power/control'
[ -f "$MOUSE" ] && echo 'on' > $MOUSE;

