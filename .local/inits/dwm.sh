#!/usr/bin/env sh
xrdb ~/.config/Xresources

sxhkd &
dunst &
picom &
redshift &
#sh ~/.fehbg &
feh --no-fehbg --bg-scale ~/.config/wall &
devmon --mount-options "exec,nosuid,nodev,noatime" &
sh ~/.local/scripts/dwm-bar.sh -l &
[ -z "$(pgrep scrond)" ] && scrond -f ~/.config/crontab &
[ -z "$(pgrep transmission)" ] && sh ~/.local/scripts/trans-init &
exec dwm
