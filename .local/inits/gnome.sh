#!/usr/bin/env sh
xrdb ~/.config/.Xresources

sxhkd &
#dunst &
#compton &
#redshift &
#sh ~/.fehbg &
devmon --mount-options "exec,nosuid,nodev,noatime" &
#sh ~/.local/scripts/dwm-bar.sh -l &
scrond -f ~/.config/crontab &
exec gnome-session 
