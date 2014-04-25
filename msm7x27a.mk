# Copyright (C) 2013 The CyanogenMod Project
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

DEVICE_PACKAGE_OVERLAYS += device/samsung/msm7x27a-common/overlay

## Video
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libmm-omxcore \
    libOmxCore

## Graphics
PRODUCT_PACKAGES += \
    copybit.msm7x27a \
    gralloc.msm7x27a \
    hwcomposer.msm7x27a \
    libtilerenderer

## Misc.
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs \
    com.android.future.usb.accessory

## Audio
PRODUCT_PACKAGES += \
    audio.primary.msm7x27a \
    audio_policy.msm7x27a \
    audio.a2dp.default \
    audio.usb.default \
    audio_policy.conf \
    libaudioutils

## Other HALs
PRODUCT_PACKAGES += \
	libbt-vendor \
    camera.msm7x27a \
    lights.msm7x27a \
    gps.msm7x27a \
    power.msm7x27a

## FM radio
PRODUCT_PACKAGES += \
    qcom.fmradio \
    libqcomfm_jni \
    FM2

## Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

## Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

## Media
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/samsung/msm7x27a-common/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

## Rootdir
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/rootdir/init.qcom.rc:root/init.qcom.rc \
    device/samsung/msm7x27a-common/rootdir/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/samsung/msm7x27a-common/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc \
    device/samsung/msm7x27a-common/rootdir/lpm.rc:root/lpm.rc \
    device/samsung/msm7x27a-common/rootdir/fstab.qcom:root/fstab.qcom

## Recovery
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/recovery/sbin/rmt_storage_recovery:recovery/root/sbin/rmt_storage_recovery \
    device/samsung/msm7x27a-common/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    device/samsung/msm7x27a-common/recovery/postrecoveryboot.sh:recovery/system/bin/postrecoveryboot.sh

## FM
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/etc/init.qcom.fm.sh:/system/etc/init.qcom.fm.sh

## Network
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/msm7x27a-common/prebuilt/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/samsung/msm7x27a-common/prebuilt/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/samsung/msm7x27a-common/prebuilt/bin/get_macaddrs:system/bin/get_macaddrs

## Audio
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
    device/samsung/msm7x27a-common/prebuilt/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    device/samsung/msm7x27a-common/prebuilt/etc/AudioFilter.csv:system/etc/AudioFilter.csv

## Keychar
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/usr/keychars/7x27a_kp.kcm.bin:system/usr/keychars/7x27a_kp.kcm.bin \
    device/samsung/msm7x27a-common/prebuilt/usr/keychars/surf_keypad.kcm.bin:system/usr/keychars/surf_keypad.kcm.bin \

## Keylayout
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/7x27a_kp.kl:system/usr/keylayout/7x27a_kp.kl \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/sec_key.kl:system/usr/keylayout/sec_key.kl \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/sec_powerkey.kl:system/usr/keylayout/sec_powerkey.kl \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/surf_keypad.kl:system/usr/keylayout/surf_keypad.kl \
    device/samsung/msm7x27a-common/prebuilt/usr/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl

## Sensor calibration files
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/etc/calib.dat:system/etc/calib.dat \
    device/samsung/msm7x27a-common/prebuilt/etc/param.dat:system/etc/param.dat \
    device/samsung/msm7x27a-common/prebuilt/etc/sensors.dat:system/etc/sensors.dat

## Touchscreen configuration
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc
    
## Kernel modules
PRODUCT_COPY_FILES += \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_stresstest.ko:system/lib/modules/mtd_stresstest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mt2131.ko:system/lib/modules/mt2131.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/diagchar.ko:system/lib/modules/diagchar.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda18218.ko:system/lib/modules/tda18218.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mxl5007t.ko:system/lib/modules/mxl5007t.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tuner-types.ko:system/lib/modules/tuner-types.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/evbug.ko:system/lib/modules/evbug.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_readtest.ko:system/lib/modules/mtd_readtest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/librasdioif.ko:system/lib/modules/librasdioif.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_erasepart.ko:system/lib/modules/mtd_erasepart.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda827x.ko:system/lib/modules/tda827x.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_oobtest.ko:system/lib/modules/mtd_oobtest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mt2266.ko:system/lib/modules/mt2266.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mc44s803.ko:system/lib/modules/mc44s803.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/qt1010.ko:system/lib/modules/qt1010.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/compat.ko:system/lib/modules/compat.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_pagetest.ko:system/lib/modules/mtd_pagetest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mt2060.ko:system/lib/modules/mt2060.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/xc5000.ko:system/lib/modules/xc5000.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda18212.ko:system/lib/modules/tda18212.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda18271.ko:system/lib/modules/tda18271.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_speedtest.ko:system/lib/modules/mtd_speedtest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_torturetest.ko:system/lib/modules/mtd_torturetest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tea5767.ko:system/lib/modules/tea5767.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda8290.ko:system/lib/modules/tda8290.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tuner-xc2028.ko:system/lib/modules/tuner-xc2028.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tda9887.ko:system/lib/modules/tda9887.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/ath6kl.ko:system/lib/modules/ath6kl.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mxl5005s.ko:system/lib/modules/mxl5005s.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_subpagetest.ko:system/lib/modules/mtd_subpagetest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tuner-simple.ko:system/lib/modules/tuner-simple.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/max2165.ko:system/lib/modules/max2165.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mmc_test.ko:system/lib/modules/mmc_test.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tun.ko:system/lib/modules/tun.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mt20xx.ko:system/lib/modules/mt20xx.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/mtd_nandecctest.ko:system/lib/modules/mtd_nandecctest.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/cfg80211.ko:system/lib/modules/cfg80211.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/gspca_main.ko:system/lib/modules/gspca_main.ko \
    device/samsung/msm7x27a-common/prebuilt/lib/modules/tea5761.ko:system/lib/modules/tea5761.ko


## Other
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=2
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_AAPT_CONFIG := normal mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

$(call inherit-product, build/target/product/full.mk)
$(call inherit-product, vendor/samsung/msm7x27a-common/blobs.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)
