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

#if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export FOX_ENABLE_APP_MANAGER=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_DATE_BINARY=1
	export FOX_USE_BUSYBOX_BINARY=1
	export FOX_DELETE_AROMAFM=1
	export OF_PATCH_AVB20=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v30.7.zip
	export OF_MAINTAINER="ThRE-Team"
	export FOX_MAINTAINER_PATCH_VERSION="5"
	curl -Lo ~/Magisk/Magisk-v30.7.zip --create-dirs https://github.com/topjohnwu/Magisk/releases/download/v30.7/Magisk-v30.7.apk

    	# dynamic partitions ?
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_VANILLA_BUILD=1

	##export FOX_USE_KEYMASTER_4=1; # only used by PE
	if [ "$FOX_USE_KEYMASTER_4" = "1" ]; then
		export FOX_VANILLA_BUILD=1
		export FOX_VARIANT="keymaster4"
	fi

	if [ "$FOX_KERNEL" = "4.19" ]; then
		echo "Building for kernel v4.19 ..."
		#export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1
		export FOX_SETTINGS_ROOT_DIRECTORY=/data/recovery
		export FOX_MISCELLANEOUS_ROOT_DIRECTORY=/sdcard
	else
		echo "Building for kernel v4.9 ..."
		export FOX_SETTINGS_ROOT_DIRECTORY=/data/recovery
		export FOX_MISCELLANEOUS_ROOT_DIRECTORY=/sdcard
	fi
	
	echo "FOX_KERNEL: k$FOX_KERNEL"
	echo "FOX_VARIANT: $FOX_VARIANT"
	echo "FOX_BUILD_TYPE: $FOX_BUILD_TYPE"
#fi
#
