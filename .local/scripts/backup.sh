#!/usr/bin/env sh
BACKUP_LOC="/media/Seagate_HDD/HOME_DIR_BACKUP/"
EXCLUDE_CONF="/home/alex/.config/rsync-exclude.conf"
notify-send "rsync" "performing backup"
if [ -d $BACKUP_LOC ]; then 
	rsync -arP --delete  --exclude-from=$EXCLUDE_CONF ~/ $BACKUP_LOC
else
	notify-send "backup.sh" "backup location not found"
fi
