#!/usr/bin/env sh
xrdb ~/.config/.Xresources

sxhkd -c ~/.config/sxhkd/sxhkdrc_bspwm &
dunst &
picom &
redshift &
sh ~/.fehbg &
devmon --mount-options "exec,nosuid,nodev,noatime" &
[ -z "$(pgrep scrond)" ] && scrond -f ~/.config/crontab &
[ -z "$(pgrep transmission)" ] && sh ~/.local/scripts/trans-init &
exec bspwm 
