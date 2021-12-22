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

DEVICE_PATH := device/realme/RMX1941
ALLOW_MISSING_DEPENDENCIES := true

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Call proprietary blob setup
$(call inherit-product, vendor/realme/RMX1941/RMX1941-vendor.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# IMS
$(call inherit-product, vendor/mtk-ims/ims.mk)

# RealmeDirac
$(call inherit-product-if-exists, packages/apps/RealmeDirac/dirac.mk)

# Parts
$(call inherit-product-if-exists, packages/apps/RealmeParts/parts.mk)

# Disable APEX compression
# Keep this after including updatable_apex.mk
PRODUCT_COMPRESSED_APEX := false

PRODUCT_SHIPPING_API_LEVEL := 28

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 29

# Boot animation
TARGET_SCREEN_HEIGHT := 1560
TARGET_SCREEN_WIDTH := 720

# Always preopt extracted APKs to prevent extracting out of the APK for gms modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
	libvisualizer \
	libaudioprepocessing 
	
PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_ODM)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_effects.conf:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_effects.conf \
  $(DEVICE_PATH)/audio/audio_effects.conf:$(TARGET_COPY_OUT_ODM)/etc/audio_effects.conf \
  $(DEVICE_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_effects.xml \
  $(DEVICE_PATH)/audio/diracmobile.config:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/diracmobile.config \
  $(DEVICE_PATH)/audio/libDiracAPI_SHARED.so:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/lib/libDiracAPI_SHARED.so \
  $(DEVICE_PATH)/audio/libdirac.so:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/lib/soundfx/libdirac.so
  
# Bluetooth
PRODUCT_PACKAGES += \
    bt_did \
	bt_mtk_iot_list \
	bt_stack \
	mtk_bt_fw \
	mtk_bt_stack
	
PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/bluetooth/bt_did.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_did.conf \
  $(DEVICE_PATH)/bluetooth/bt_mtk_iot_list.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_mtk_iot_list.conf \
  $(DEVICE_PATH)/bluetooth/bt_stack.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_stack.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_fw.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_fw.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_stack.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_stack.conf
  
# PrebuiltPackages
PRODUCT_PACKAGES += \
    GoogleCameraGo \
	Gboard
	
# Apns
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/apns-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/apns-conf.xml
	
# fastbootd
PRODUCT_PACKAGES += \
    fastbootd
	
# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.2-service.clearkey \
    android.hardware.drm@1.2-service.widevine

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
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM)/system_ext/etc/permissions/privapp-permissions-whitelist-system_ext.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-whitelist-product.xml \
    $(DEVICE_PATH)/permissions/platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/platform.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml
	
# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor \
	vendor.lineage.trust@1.0-service

# IMS
PRODUCT_PACKAGES += \
    mtk-ims \
    mtk-ims-telephony

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6765.rc \
    init.safailnet.rc \
    fstab.mt6765 \
    perf_profile.sh \
    set_zram.sh

# Keylayouts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl \
    $(DEVICE_PATH)/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl

# KPOC
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mediatek

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

PRODUCT_PACKAGES += \
    NotchBarKiller \
    BatteryHealthOverlay 

# Power
PRODUCT_PACKAGES += \
    power.mt6765

# Properties
-include $(DEVICE_PATH)/system.prop
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# NusantaraPapers
PRODUCT_PACKAGES += \
    NusantaraPapers

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService
	
# Recovery
PRODUCT_PACKAGES += \
    init.recovery.mt6765.rc
	
# Reduce system image size by limiting java debug info.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
	
# Screen density
PRODUCT_AAPT_CONFIG := xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_PREBUILT_DPI := xhdpi xxhdpi 

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Symbols
PRODUCT_PACKAGES += \
    libshim_showlogo
	
# USB
PRODUCT_PACKAGES += \
	android.hardware.usb@1.1-service-mediatek \
    android.hardware.usb@1.0 \
    android.hardware.usb@1.1

# Wi-Fi
PRODUCT_PACKAGES += \
    android.hardware.wifi.hostapd@1.0 \
    android.hardware.wifi.hostapd@1.1 \
    TetheringConfigOverlay \
    WifiOverlay
