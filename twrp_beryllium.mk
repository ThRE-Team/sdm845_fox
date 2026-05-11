#
# Copyright (C) 2022 The OrangeFox Recovery Project
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

PRODUCT_RELEASE_NAME := beryllium

# These two paths must be set here
DEVICE_PATH := device/xiaomi/$(PRODUCT_RELEASE_NAME)
SDM845_COMMON_PATH := device/xiaomi/sdm845-common

# Inherit from sdm845-common, which ultimately adds the local device.mk (if it exists) to the chain
$(call inherit-product, $(SDM845_COMMON_PATH)/sdm845.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := twrp_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_MODEL := POCO F1
#
