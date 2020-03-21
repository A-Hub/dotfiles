#!/usr/bin/env sh
UPDATE="$(curl --connect-timeout 30 "wttr.in/?format=2")" # > ~/.cache/wttr

echo $UPDATE | wc -m

if [ $(echo $UPDATE | wc -m) -le 30 ]; then
	echo "$UPDATE" > ~/.cache/wttr

else
	echo "❗ wttr.in error" > ~/.cache/wttr 

fi
