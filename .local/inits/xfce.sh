#!/usr/bin/env sh
xrdb ~/.config/.Xresources

sxhkd &
#dunst &
#picom &
redshift &
#sh ~/.fehbg &
devmon --mount-options "exec,nosuid,nodev,noatime" &
#sh ~/.local/scripts/dwm-bar.sh -l &
#scrond -f ~/.config/crontab &
#sh ~/.local/scripts/trans-init &
exec startxfce4
