#!/usr/bin/env sh

FN="$HOME/.config/color"
COLORSDIR="$HOME/.config/colors"

if [ -z "$1" ]; then 
	SEL="$(echo "$(ls ~/.config/colors)\nPYWAL" | dmenu)"
	[ -z "$SEL" ] && notify-send "set_colors.sh" "Colors not set" && exit
	[ "$SEL" = "PYWAL" ] && FILENAME="$HOME/.cache/wal/colors" || FILENAME="$COLORSDIR/$SEL"
else
	[ -f "$1" ] && FILENAME="$1" 
fi

mv "$FN" "$FN.bak"
ENDCOLS="FALSE"
#wal -s -t -e -i "$1"

echo "/* color theme set by scripts/set_colors.sh */" >> $FN
echo "" >> $FN
echo "generated from: $FILENAME" >> $FN
echo "" >> $FN
echo "!terminal colors" >> $FN
COUNT=0
while read line; do
	[ -z "$line" ] && echo "broke while loop" && ENDCOLS="TRUE" 

	if [ "$ENDCOLS" = "TRUE" ]; then
		echo "$line" >> $FN
	else
		echo "#define COLOR$COUNT  $line" >> $FN
		COUNT=`expr $COUNT + 1`
	fi
done < $FILENAME 

notify-send "set_colors.sh" "Colors set to $FILENAME"
