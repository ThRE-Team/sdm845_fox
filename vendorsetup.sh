#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2026 The OrangeFox Recovery Project
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
FDEVICE="beryllium"

#export FOX_VARIANT="Enjoy"
#export FOX_BUILD_TYPE="Unofficial"
#export FOX_ENABLE_APP_MANAGER=1
#export FOX_KERNEL=4.19
export OF_MAINTAINER="ThRE-Team"
export OF_USE_HEXDUMP=1
export BUILD_USERNAME="1213F3"
export BUILD_HOSTNAME="ThRE"
#export FOX_MAINTAINER_PATCH_VERSION="4"

fetch_sdm845_common_repo() {
	local URL=https://github.com/ThRE-Team/sdm845_fox.git;
	local common=device/xiaomi/sdm845-common;
	local branch=fox_16.0_common_beryllium;

	if [ ! -d $common ]; then
		echo "Cloning $URL ... to $common";
		git clone $URL -b $branch $common;
	else
		echo "Device common repository: \"$common\" found ...";
	fi
}

fetch_enjoy_common_repo() {
	local URL=https://github.com/ThRE-Team/sdm845_fox.git;
	local common=device/xiaomi/sdm845-common;
	local branch=enjoy_common;

	if [ ! -d $common ]; then
		echo "Cloning Enjoy Common: $URL ... to $common";
		git clone $URL -b $branch $common;
	else
		echo "Device common repository: \"$common\" found ...";
	fi
}

fox_get_target_device() {
  if echo "$BASH_SOURCE" | grep -q "/$FDEVICE/"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif set | grep BASH_ARGV | grep -w \"$FDEVICE\"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif echo "${BASH_SOURCE[0]}" | grep -q "/$FDEVICE/"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  elif echo "$0" | grep -q "$FDEVICE"; then
      FOX_BUILD_DEVICE="$FDEVICE";
  fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	# clone the common repo if necessary
	
	if [ "$FOX_BUILD_TYPE" = "Next" ]; then
		if [ "$FOX_KERNEL" = "4.9" ]; then
			export FOX_VARIANT="Legacy"
		else
			export FOX_VARIANT="Enjoy"
		fi
		fetch_enjoy_common_repo;
	else
		fetch_sdm845_common_repo;
	fi

	# pull in the common vendorsetup.sh
	source device/xiaomi/sdm845-common/vendorsetupcommon.sh
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
