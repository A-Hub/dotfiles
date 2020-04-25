#!/usr/bin/env bash

[ -z "$1" ] && URL="$( xclip -o | sed 's/$//g')"  && browser.sh "$URL" && exit 

OPTS=(site video yt file)

SEL="$( echo "${OPTS[@]}" | sed 's/ /\n/g' | dmenu)"

[ "$SEL" = "${OPTS[0]}" ] && surf "$1" && exit

[ "$SEL" = "${OPTS[1]}" ] && mpv "$1" && exit

[ "$SEL" = "${OPTS[2]}" ] && mpv --ytdl-format=18 "$1" && exit

[ "$SEL" = "${OPTS[3]}" ] && wget -P ~/dl/ "$1" && exit

surf "$1"
