#!/bin/sh
case "$1" in
        *.tar*) tar tf "$1";;
        *.zip) unzip -l "$1";;
        *.rar) unrar l "$1";;
        *.7z) 7z l "$1";;
        *.jpg | *.JPG | *.jpeg) jp2a "$1" -b --width=$(($(tput cols)/2 - 10));;
        *.png | *.svg | *.gif) convert "$1" jpg:- | jp2a - -b --width=$(($(tput cols)/2 - 10));;
        *.mp4 | *.mkv | *.webm | *.avi | *.mpg | *.mpeg | *.ogv | *.flv | *.wmv | *.WMV) ffmpegthumbnailer -i "$1" -c jpeg -o - | jp2a - -b --width=$(($(tput cols)/2 - 10));; 
        #*.pdf) pdftotext "$1" -;;
        *) highlight -O ansi "$1" || cat "$1";;
esac

