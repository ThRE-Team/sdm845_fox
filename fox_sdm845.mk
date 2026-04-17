#
# Copyright (C) 2022-2026 The OrangeFox Recovery Project
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

# screen settings
OF_STATUS_H := 80
OF_STATUS_INDENT_RIGHT := 48

ifeq ($(PRODUCT_RELEASE_NAME),polaris)
  OF_SCREEN_H := 2160
  OF_STATUS_INDENT_LEFT := 48
  OF_OPTIONS_LIST_NUM := 6
else
  OF_SCREEN_H := 2244
  OF_STATUS_INDENT_LEFT := 56
  OF_OPTIONS_LIST_NUM := 8
endif

# other stuff
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1
OF_CLASSIC_LEDS_FUNCTION := 1
#OF_USE_LZMA_COMPRESSION := 1
OF_USE_GREEN_LED := 0

# patch avb20 - some ROM recoveries try to overwrite custom recoveries
OF_PATCH_AVB20 := 1

# MIUI OTA
OF_DISABLE_MIUI_OTA_BY_DEFAULT := 1

# delta OTA for custom ROMs
OF_SUPPORT_ALL_BLOCK_OTA_UPDATES := 1
OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR := 1

# try to deal with MTP issues
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# ensure that /sdcard is bind-unmounted before f2fs data repair or format (required for FBE v1)
OF_UNBIND_SDCARD_F2FS := 1

# don't save historic logs
ifeq ($(FOX_BUILD_TYPE),Stable)
   OF_DONT_KEEP_LOG_HISTORY := 1
endif

# FRP
OF_ENABLE_FRP_ADDON := 1

# dynamic partitions?
   # build all the partition tools
   OF_ENABLE_ALL_PARTITION_TOOLS := 1
   #
   OF_QUICK_BACKUP_LIST := /boot;/data;
   OF_DISABLE_OTA_MENU := 1
   OF_NO_ADDITIONAL_MIUI_PROPS_CHECK := 1
   OF_SUPPORT_ALL_BLOCK_OTA_UPDATES :=
   OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR :=
#
