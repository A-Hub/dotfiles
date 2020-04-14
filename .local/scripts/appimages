#!/usr/bin/env sh

AIDIR="$HOME/.appimages"

if [ $1 ]; then
	AIDIR="$1"
fi

sel=$(ls "$AIDIR" | dmenu -p "select AppImage")

if [ $sel ]; then
	sh -c $AIDIR/$sel
fi

