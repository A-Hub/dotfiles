#!/usr/bin/env sh

FN="$HOME/.config/colors/pywal"

[ ! -f "$1" ] && echo "no file given. give file as first argument" && exit

rm "$FN"

wal -s -t -e -i "$1"

echo "/* PYWAL generated theme */" >> $FN
echo "" >> $FN
echo "generated from: $1" >> $FN
echo "" >> $FN
echo "!terminal colors" >> $FN
COUNT=0
while read line; do
	echo "#define COLOR$COUNT  $line" >> $FN
	COUNT=`expr $COUNT + 1`
done < ~/.cache/wal/colors

echo "#define BACKGROUND COLOR0" >> $FN
echo "#define FOREGROUND COLOR15" >> $FN


echo "" >> $FN
echo "!dwm colors" >> $FN
echo "#define DWM_NBDR   COLOR8" >> $FN
echo "#define DWM_NBG    COLOR0" >> $FN
echo "#define DWM_NFG    COLOR15" >> $FN
echo "#define DWM_SBDR   COLOR15" >> $FN
echo "#define DWM_SBG    COLOR2" >> $FN
echo "#define DWM_SFG    COLOR15" >> $FN

echo "" >> $FN
echo "!dmenu colors" >> $FN
echo "#define DMENU_NBG  COLOR0" >> $FN
echo "#define DMENU_NFG  COLOR15" >> $FN
echo "#define DMENU_SBG  COLOR1" >> $FN
echo "#define DMENU_SFG  COLOR15" >> $FN
