#!/usr/bin/env sh
#=========================================================================
# This script is used to set the status bar for dwm, or 
# other wms that use xsetroot for a status bar. 
#
# by default this script will only run once, to run in 
# a loop give it the -l flag: ./dwm-bar.sh -l
#
# Requires: pulsemixer 
# 
# ddate -> creates a date string
# audio -> creates a string representing the state of pulseaudio
# netup -> creates a string for the current network interface and status
# weather -> reads file written by ~/scripts/update-weather.sh to set the weather 
#
# update -> calls all the above functions into xsetroot to set status bar
#
# https://gitlab.com/ahub/dotfiles
#========================================================================

SEP="  ][  "

ddate () {
	printf "%s\n" "$(date "+%B %d, %Y (%a)  ( %I:%M )")"
}


audio () {
    icon="🔊 $(pulsemixer --get-volume | awk '{print $1}')"
    if [ $(pulsemixer --get-mute) -eq 1 ]; then
        icon="🔇"
    fi
   #volstat="$(amixer get Master)"
   # if [ ! -z "$(echo $volstat | grep "\[off\]")" ]; then
   #     icon="🔇"
    #else
	#	icon="🔊 $(echo $volstat | grep -o "\[[0-9]\+%\]" | sed 's/[^0-9]*//g')"
    #fi

    printf "%s\n" "$icon"
}


netup() {
	icon="❗ no network devices detected"
	for iface in $(ls -1 /sys/class/net | sed '/^lo/d')
	do
    	if [ $(cat /sys/class/net/$iface/operstate | grep up) ] ; then
        	if [ $(echo $iface | grep w) ]; then
            	icon="📡 $iface"
        	else
            	icon="🌐 $iface"
        	fi
    	elif [ -z "$icon" ]; then
        	icon="❗ no internet"
    	fi
	done

	printf "%s\n" "$icon"
}

weather() {
	if ! [ -f ~/.cache/wttr ]; then
		sh ~/scripts/update-weather.sh
	fi
	icon="$(cat ~/.cache/wttr)"

	printf "%s\n" "$icon"
}

sysupdates() {
	upcnt=$(xbps-install -un | wc -l)
	icon=""

	if [ $upcnt -eq 0 ]; then
		icon="xbps ✔"
	else
		icon="xbps $upcnt"
	fi

	printf "%s\n" "$icon"
}


cputemp() {
	icon="CPU: $(cat /sys/class/thermal/thermal_zone0/temp | sed 's/\(.\)..$/.\1°C/')"

	printf "%s\n" "$icon"
}

battery() {
	status="$(cat /sys/class/power_supply/BAT0/status)"
	charge="$(cat /sys/class/power_supply/BAT0/capacity)"
	icon=""
	if [ "$status" = "Discharging" ]; then
		icon="🔋 ${charge}%"	
    elif [ -z "$status" ]; then
        icon="🔌"
	else 
		icon="🔌 ${charge}%"	
	fi

	printf "%s\n" "$icon"
}
#transmission() {
#}

update() {
    xsetroot -name " $(sysupdates)$SEP$(weather)$SEP$(cputemp)$SEP$(battery)$SEP$(netup)$SEP$(audio)$SEP$(ddate) "
}

if [ $1 ] && [ $1 = "-l" ]; then    
	sh ~/scripts/update-weather.sh
	sudo -n xbps-install -S
    while true
    do
        update    
        sleep 60 
    done
else 
    update
fi
