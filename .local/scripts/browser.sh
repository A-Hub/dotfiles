#!/usr/bin/env sh
SEL="$(echo "site\nvideo\nyt\nfile" | dmenu)"

[ "$SEL" = "site" ] && surf "$1" && exit

[ "$SEL" = "video" ] && mpv "$1" && exit

[ "$SEL" = "yt" ] && mpv --ytdl-format=18 "$1" && exit

[ "$SEL" = "file" ] && wget -P ~/dl/ "$1" && exit


