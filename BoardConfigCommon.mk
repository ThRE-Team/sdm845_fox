#
# Copyright 2017 The Android Open Source Project
#
# Copyright (C) 2019-2026 OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# default to R12.x build, for the pixel format
#FOX_R11.x := true

# common paths
SDM845_COMMON_PATH := device/xiaomi/sdm845-common
TARGET_RECOVERY_DEVICE_DIRS += $(SDM845_COMMON_PATH)
QCOM_CRYPTFS_PATH := device/xiaomi/qcom/cryptfs_hw

# device path
DEVICE_PATH := device/xiaomi/$(TARGET_DEVICE)

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT:= kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := kryo385
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo385

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
TARGET_NO_BOOTLOADER := true

# Kernel
NEED_KERNEL_MODULE_SYSTEM := true
TARGET_KERNEL_ARCH := arm64

BOARD_KERNEL_CMDLINE := \
	console=ttyMSM0,115200n8 \
	earlycon=msm_geni_serial,0xA84000 \
	androidboot.hardware=qcom \
	androidboot.console=ttyMSM0 \
	androidboot.usbcontroller=a600000.dwc3 \
	ehci-hcd.park=3 \
	lpm_levels.sleep_disabled=1 \
	msm_rtb.filter=0x237 \
	service_locator.enable=1 \
	swiotlb=2048 \
	loop.max_part=7 \
	androidboot.configfs=true \
	androidboot.boot_devices=soc/1d84000.ufshc \
	androidboot.selinux=permissive

BOARD_KERNEL_CMDLINE += androidboot.super_partition=system
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_BOOT_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# kernel paths
ifeq ($(FOX_KERNEL),4.19)
    KERNEL_PATH := $(DEVICE_PATH)/prebuilt/419
    KERNEL_STUFF_LOCATION := kernel_419
else
    KERNEL_PATH := $(DEVICE_PATH)/prebuilt
    KERNEL_STUFF_LOCATION := kernel_49
endif

# variants
VARIANT_SRC_DIR := $(SDM845_COMMON_PATH)/recovery/$(KERNEL_STUFF_LOCATION)

# whether to do an inline build of the kernel sources
#FOX_BUILD_FULL_KERNEL_SOURCES := 1
ifeq ($(FOX_BUILD_FULL_KERNEL_SOURCES),1)
    TARGET_KERNEL_SOURCE := kernel/xiaomi/$(TARGET_DEVICE)
    TARGET_KERNEL_CONFIG := $(TARGET_DEVICE)-fox_defconfig
    TARGET_KERNEL_CLANG_COMPILE := true
    KERNEL_SUPPORTS_LLVM_TOOLS := true
    TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-gnu-
    # clang-r383902 = 11.0.1; clang-r416183b = 12.0.5; clang-r416183b1 = 12.0.7;
    # clang_13.0.0 (proton-clang 13.0.0, symlinked into prebuilts/clang/host/linux-x86/clang_13.0.0)
    TARGET_KERNEL_CLANG_VERSION := 13.0.0
    TARGET_KERNEL_CLANG_PATH := $(shell pwd)/prebuilts/clang/host/linux-x86/clang-$(TARGET_KERNEL_CLANG_VERSION)
else
    TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image.gz-dtb
endif

# languages
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en

# OTA
TARGET_OTA_ASSERT_DEVICE := $(TARGET_DEVICE)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67092480
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm

BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# RGBX is needed for R12.0 SVG
ifeq ($(FOX_R11.x),true)
    TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
else
    TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
endif

# Broken Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# frame rate
TW_FRAMERATE := 120

# Python
# TW_INCLUDE_PYTHON := true

# FDE
ifeq ($(FOX_ENABLE_SDM845_FDE),true)
  TARGET_HW_DISK_ENCRYPTION := true
  BOARD_USES_QCOM_DECRYPTION := true
  TARGET_CRYPTFS_HW_PATH := $(QCOM_CRYPTFS_PATH)
  TARGET_RECOVERY_DEVICE_DIRS += $(QCOM_CRYPTFS_PATH)
  TARGET_RECOVERY_DEVICE_MODULES += libcryptfs_hw
  RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfs_hw.so
endif

# dynamic build? (now default)
  BOARD_SUPER_PARTITION_SIZE := 4294967296
  BOARD_SUPER_PARTITION_SIZE := 5167382528
  BOARD_SUPER_PARTITION_METADATA_DEVICE := system
  BOARD_SUPER_PARTITION_BLOCK_DEVICES := system vendor
  BOARD_SUPER_PARTITION_BLOCK_DEVICES := system vendor cust
  BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 3221225472
  BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 1073741824
  BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE := 872415232

  BOARD_SUPER_PARTITION_GROUPS := xiaomi845_dynamic_partitions
  BOARD_XIAOMI845_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
  BOARD_XIAOMI845_DYNAMIC_PARTITIONS_SIZE := 5163188224 ## (BOARD_SUPER_PARTITION_SIZE - 4194304) 4MiB overhead

  ifneq ($(FOX_OVERRIDE_DEFAULT_FSTAB),true)
  	TARGET_RECOVERY_FSTAB := $(VARIANT_SRC_DIR)/fstab_files/recovery-dynamic.fstab
  	PRODUCT_COPY_FILES += $(VARIANT_SRC_DIR)/fstab_files/twrp-dynamic.flags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/twrp.flags
  endif

  # keymaster 4.0
  ifeq ($(FOX_USE_KEYMASTER_4),1)
  	PRODUCT_COPY_FILES += $(SDM845_COMMON_PATH)/recovery/keymaster4/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest.xml
  else
  	PRODUCT_COPY_FILES += $(SDM845_COMMON_PATH)/recovery/keymaster3/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest.xml
  endif

#  # copy recovery/fstab_files/ from the common  directory (if it exists)
#  ifneq ($(wildcard $(SDM845_COMMON_PATH)/recovery/fstab_files/.),)
#    PRODUCT_COPY_FILES += \
#        $(call find-copy-subdir-files,*,$(SDM845_COMMON_PATH)/recovery/fstab_files/*,$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/)
#  endif

#  # copy recovery/fstab_files/ from the device directory (if it exists)
#  ifneq ($(wildcard $(DEVICE_PATH)/recovery/fstab_files/.),)
#    PRODUCT_COPY_FILES += \
#        $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/fstab_files/*,$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/)
#  endif

# --------------------------------------------------
# copy recovery/fstab_files/ from the common  directory (if it exists)
ifneq ($(wildcard $(VARIANT_SRC_DIR)/fstab_files/.),)
    PRODUCT_COPY_FILES += \
        $(call find-copy-subdir-files,*,$(VARIANT_SRC_DIR)/fstab_files/*,$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/)
endif

# copy recovery/fstab_files/ from the device directory (if it exists)
ifneq ($(wildcard $(DEVICE_PATH)/recovery/fstab_files/.),)
    PRODUCT_COPY_FILES += \
        $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/fstab_files/*,$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/)
endif
# --------------------------------------------------

TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_VENDOR_PROP += $(SDM845_COMMON_PATH)/vendor.prop

# override what is stupidly causing "AB_OTA_UPDATER := true" (build/core/board_config.mk:946 (AB_OTA_UPDATER := true))
AB_OTA_UPDATER := false
#
