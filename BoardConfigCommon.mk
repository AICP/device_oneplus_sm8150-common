#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true

COMMON_PATH := device/oneplus/sm8150-common

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    system \
    vendor \
    vbmeta

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-hidl"

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_USES_64_BIT_BINDER := true

# Audio
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msmnile
TARGET_NO_BOOTLOADER := true

# Properties
TARGET_ODM_PROP += $(COMMON_PATH)/odm.prop
TARGET_PRODUCT_PROP += $(COMMON_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(COMMON_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# Bluetooth
TARGET_USE_QTI_BT_STACK := true

# Camera
TARGET_CAMERA_NEEDS_CLIENT_INFO := true

# Charger
BOARD_GLOBAL_CFLAGS += -DBATTERY_REAL_INFO

# Fingerprintsensor
TARGET_USES_FOD_ZPOS := true
TARGET_FOD_ZPOS := 0x20000000u
SOONG_CONFIG_UDFPS_ZPOS := $(TARGET_FOD_ZPOS)

# Dexpreopt (to speed boot)
WITH_DEXPREOPT := true

# Display
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_DRM_PP := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
TARGET_USES_ION := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(COMMON_PATH)/config.fs

# Fingerprint
TARGET_SURFACEFLINGER_UDFPS_LIB := //hardware/oplus:libudfps_extension.oplus

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(COMMON_PATH)/device_framework_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml
DEVICE_MATRIX_FILE := $(COMMON_PATH)/compatibility_matrix.xml
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/manifest.xml

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := \
    androidboot.console=ttyMSM0 \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.vbmeta.avb_version=1.0 \
    loop.max_part=7 \
    lpm_levels.sleep_disabled=1 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=2048 \
    video=vfb:640x400,bpp=32,memsize=3072000
BOARD_KERNEL_IMAGE_NAME := Image-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_KERNEL_ADDITIONAL_FLAGS := BRAND_SHOW_FLAG=oneplus TARGET_PRODUCT=msmnile
TARGET_KERNEL_CONFIG := vendor/sm8150-perf_defconfig
TARGET_KERNEL_SOURCE := kernel/oneplus/sm8150

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := msmnile

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR := vendor

# Power
TARGET_RPM_MASTER_STAT := "/d/rpmh/master_stats"
TARGET_RPM_STAT := "/d/rpmh/stats"
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/double_tap_enable"
TARGET_WLAN_POWER_STAT := "/sys/kernel/wlan/power_stats"

# Recovery
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch level
VENDOR_SECURITY_PATCH := 2022-08-05

# Sensors
SOONG_CONFIG_NAMESPACES += ONEPLUS_MSMNILE_SENSORS
SOONG_CONFIG_ONEPLUS_MSMNILE_SENSORS := ALS_POS_X ALS_POS_Y

# SEPolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk
include hardware/oplus/sepolicy/qti/SEPolicy.mk

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_EVENT := "ON"
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
