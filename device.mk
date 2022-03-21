#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX2185
ALLOW_MISSING_DEPENDENCIES := true

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Call proprietary blob setup
$(call inherit-product, vendor/realme/RMX2185/RMX2185-vendor.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

PRODUCT_SHIPPING_API_LEVEL := 29

# VNDK
PRODUCT_TARGET_VNDK_VERSIONS := 29

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
	libvisualizer \
	libaudioprepocessing

PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_effects.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/audio_effects.conf \
  $(DEVICE_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/audio_effects.xml  
  
# A/B
AB_OTA_UPDATER := false
  
# Bluetooth
PRODUCT_PACKAGES += \
	bt_mtk_iot_list \
	mtk_bt_fw \
	mtk_bt_stack
	
PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/bluetooth/bt_mtk_iot_list.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_mtk_iot_list.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_fw.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_fw.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_stack.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_stack.conf
  
# PrebuiltPackages
PRODUCT_PACKAGES += \
    GoogleCameraGo
	
# Symbols 
PRODUCT_PACKAGES += \
    libshim_showlogo \
    libshim_vtservice
	
# Apns
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/apns-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/apns-conf.xml \
	
# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6765:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6765
	
# Extras
PRODUCT_PACKAGES += \
    $(DEVICE_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries.txt \
    $(DEVICE_PATH)/configs/public.libraries-trustonic.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/public.libraries-trustonic.txt \
    $(DEVICE_PATH)/configs/sys_gps_lbs_config.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sys_gps_lbs_config.xml 

# gps
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/gps_debug.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/gps_debug.conf \
    $(DEVICE_PATH)/configs/gps_debug.conf:$(TARGET_COPY_OUT_SYSTEM)/system_ext/etc/gps_debug.conf \
    $(DEVICE_PATH)/configs/gps_debug.conf:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/gps_debug.conf

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/com.mediatek.op.ims.common.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.op.ims.common.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-whitelist-system.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-whitelist-product.xml \
    $(DEVICE_PATH)/permissions/platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/platform.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_SYSTEM)etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml
	
# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system
	
# IORap
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

# Init
PRODUCT_PACKAGES += \
    init.mt6765.rc \
    init.safailnet.rc \
    fstab.mt6765 \
    perf_profile.sh \
    set_zram.sh 

# Input/DT2W
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl \
    $(DEVICE_PATH)/configs/keylayout/ACCDET.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ACCDET.kl \
    $(DEVICE_PATH)/configs/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl \
    $(DEVICE_PATH)/configs/keylayout/mtk-tpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-tpd.kl

# KPOC
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.RMX2185

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Power
PRODUCT_PACKAGES += \
    power.mt6765

# Properties
-include $(DEVICE_PATH)/system.prop
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)   

# Reduce system image size by limiting java debug info.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    wpa_supplicant.conf 
