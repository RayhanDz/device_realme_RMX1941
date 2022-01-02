#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2018 The LineageOS Project
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

set -e

export DEVICE=RMX1941
export VENDOR=realme

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}"/../../..

HELPER="${ANDROID_ROOT}/vendor/nusantara/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup {
    case "$1" in
        lib/libshowlogo.so)
            "$PATCHELF" --add-needed "libshim_showlogo.so" "$2"
            ;;
        vendor/lib/libladder.so|vendor/lib64/libladder.so)
            "${PATCHELF}" --replace-needed "libunwindstack.so" "libunwindstack-v29.so" "${2}"
            ;;
        vendor/lib/hw/audio.primary.mt6765.so)
            "${PATCHELF}" --replace-needed "libmedia_helper.so" "libmedia_helper-v29.so" "${2}"
            ;;
        vendor/bin/hw/android.hardware.wifi@1.0-service-lazy-mediatek|vendor/bin/hw/hostapd|vendor/bin/hw/wpa_supplicant)
            "${PATCHELF}" --add-needed "libcompiler_rt.so" "${2}"
            ;;
        vendor/bin/hw/camerasloganserver|vendor/lib/libmtkcam_stdutils.so|vendor/lib64/libmtkcam_stdutils.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v29.so" "${2}"
            ;;
        vendor/bin/hw/camerahalserver)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v30.so" "${2}"
            ;;
    esac
}

# Initialize the helper for device
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"

"${MY_DIR}/setup-makefiles.sh"
