#
# Copyright (C) 2022-2024 The OrangeFox Recovery Project
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

# Inherit the common sdm845 BoardConfig
include device/xiaomi/sdm845-common/BoardConfigCommon.mk

# Decrypt
ifeq ($(FOX_KERNEL),4.19)
    BOARD_USES_QCOM_FBE_DECRYPTION := true
    BOARD_USES_QCOM_ICE := true
    TW_INCLUDE_CRYPTO := true
    TW_INCLUDE_FBE_METADATA_DECRYPT := true
    BOARD_USES_METADATA_PARTITION := true
endif

# Enjoy
ifeq ($(FOX_VARIANT),Enjoy)
    TW_NO_SCREEN_BLANK := true
    TW_INPUT_BLACKLIST := "hbtp_vm"
endif
