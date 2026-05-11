#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2024 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#

# factory reset for beryllium
scriptname=$0;

#set -o xtrace
LOGMSG() {
	echo "I: $@";
	echo "I: $@" >> /tmp/recovery.log;
}

format_standard() {
	LOGMSG "Formatting for standard partitions (ext4) ...";
	mke2fs -t ext4 -b 4096 /dev/block/bootdevice/by-name/userdata;
	mke2fs -t ext4 -b 4096 /dev/block/bootdevice/by-name/cache;
}

format_dynamic() {
	LOGMSG "Formatting for dynamic partitions (f2fs) ...";
	make_f2fs -g android -f /dev/block/bootdevice/by-name/userdata;
	make_f2fs -g android -f /dev/block/bootdevice/by-name/cache;
	# /metadata, mounted on "logdump"
	mke2fs -t ext4 -b 4096 /dev/block/bootdevice/by-name/logdump;
	[ "$?" = "0" ] && e2fsdroid -e -S /file_contexts -a /metadata /dev/block/bootdevice/by-name/logdump;
}

process_partitions() {
local dyna=0;
	if [ "$1" = "standard" -o "$1" = "dynamic" ]; then
		LOGMSG "Unmounting partitions before formatting...";
	else
		echo "Syntax = $scriptname <standard/dynamic>";
		exit 0;	
	fi

	umount /sdcard > /dev/null 2>&1;
	sleep 0.5s;

	umount /data > /dev/null 2>&1;
	sleep 0.5s;

	umount /data > /dev/null 2>&1;
	sleep 0.5s;

	umount /sdcard > /dev/null 2>&1;
	sleep 0.5s;

	umount /cache > /dev/null 2>&1;
	sleep 0.5s;

	umount /metadata > /dev/null 2>&1;
	sleep 0.5s;

	umount /system_ext > /dev/null 2>&1;
	sleep 0.5s;

	if [ "$1" = "standard" ]; then
		format_standard;
	elif [ "$1" = "dynamic" ]; then
		format_dynamic;
	fi
}

process_partitions "$@";
exit 0;
