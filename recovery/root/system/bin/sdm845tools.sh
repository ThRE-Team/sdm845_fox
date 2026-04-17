#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2023-2026 The OrangeFox Recovery Project
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
#

# set to 1 during testing, else set to 0
debug_mode=1;

# DEBUG mode?
[ "$debug_mode" = "1" ] && set -o xtrace;

# write a message to the log file
LOGMSG() {
	echo "I:$@" >> /tmp/recovery.log;
}

# test-phase log messages
TESTING_LOG() {
	[ "$debug_mode" = "1" ] && LOGMSG "$@";
}

# report whether the installed ROM has dynamic partitions
rom_has_dynamic_partitions() {
  local BUILD_DEVICE="xiaomi845"; # the device that we are building for
  local markers="qti_dynamic_partitions "$BUILD_DEVICE"_dynamic_partitions "$BUILD_DEVICE"_dynpart xiaomi_dynamic_partitions xiaomi_dynpart qti_dynpart";
  local F=/tmp/blck_tmp;
  dd if=/dev/block/by-name/system bs=256k count=1 of=$F;
  strings $F | grep dyn > "$F.txt";
  for i in $markers
  do
	TESTING_LOG "Checking for $i in $F.txt";
	if grep $i "$F.txt" > /dev/null; then
		echo "1";
		[ "$debug_mode" != "1" ] && rm -f $F*;
		return;
     	fi
  done
  [ "$debug_mode" != "1" ] && rm -f $F*;
  echo "0";
}
#
