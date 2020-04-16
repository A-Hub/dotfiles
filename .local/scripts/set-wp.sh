#!/usr/bin/env sh
#sets a random wallpaper using feh from the ~/wallpapers directory
[ "$1" = "-r" ] && WALLP=`find -L ~/wallpapers/ -iname "*.*" -print | shuf -n 1` && feh --bg-scale $WALLP && exit

[ -f "$1" ] || exit
wal -n -s -t -e -i "$1"
rm ~/.config/wall 
ln -s "$1" $HOME/.config/wall  
feh --no-fehbg --bg-scale ~/.config/wall
