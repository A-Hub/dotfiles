#!/usr/bin/env sh

monitor() {
xrandr --output VGA1 --mode 1600x1200 --output LVDS1 --off
xrandr --output VGA1 --mode 1920x1080 --output LVDS1 --off
sh ~/.fehbg

}

laptop() {
xrandr --output LVDS1 --mode 1600x900 --output VGA1 --off
sh ~/.fehbg
}

if [ "$1" = "-m" ]; then
	monitor	
elif [ "$1" = "-l" ]; then
	laptop
else
	echo "Fix screen resolution settings."
	echo "-m -> set to monitor (1920x1080) and disable laptop"
	echo "-l -> set to laptop and disable VGA monitor"
fi
