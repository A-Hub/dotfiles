#!/usr/bin/env sh

FN="$HOME/.config/colors/color"
FILENAME="$1"

[ ! -f "$1" ] && echo "no file given. give file as first argument, or pywal's ~/.cache/wal/colors will be used" 

[ -f "$HOME/.cache/wal/colors" ] || exit

[ -z "$1" ] && FILENAME="$HOME/.cache/wal/colors"


rm "$FN"
ENDCOLS="FALSE"
#wal -s -t -e -i "$1"

echo "/* color theme set by scripts/set_colors.sh */" >> $FN
echo "" >> $FN
echo "generated from: $1" >> $FN
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

#echo "#define BACKGROUND COLOR0" >> $FN
#echo "#define FOREGROUND COLOR15" >> $FN




#echo "" >> $FN
#echo "!dwm colors" >> $FN
#echo "#define DWM_NBDR   COLOR8" >> $FN
#echo "#define DWM_NBG    COLOR0" >> $FN
#echo "#define DWM_NFG    COLOR15" >> $FN
#echo "#define DWM_SBDR   COLOR15" >> $FN
#echo "#define DWM_SBG    COLOR2" >> $FN
#echo "#define DWM_SFG    COLOR15" >> $FN

#echo "" >> $FN
#echo "!dmenu colors" >> $FN
#echo "#define DMENU_NBG  COLOR0" >> $FN
#echo "#define DMENU_NFG  COLOR15" >> $FN
#echo "#define DMENU_SBG  COLOR1" >> $FN
#echo "#define DMENU_SFG  COLOR15" >> $FN
