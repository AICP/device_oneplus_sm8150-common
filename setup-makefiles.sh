#!/bin/bash
#
# Copyright (C) 2018-2019 The LineageOS Project
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

DEVICE_COMMON=sm8150-common
VENDOR=oneplus
INITIAL_COPYRIGHT_YEAR=2019

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

AICP_ROOT="${MY_DIR}/../../.."

HELPER="${AICP_ROOT}/vendor/aicp/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper for common
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${AICP_ROOT}" true

# Copyright headers and guards
write_headers "guacamole guacamoleb guacamoleg"

# The standard common blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Qualcomm BSP blobs - we put a conditional around here
# in case the BSP is actually being built
printf '\n%s\n' "ifeq (\$(QCPATH),)" >> "${PRODUCTMK}"
printf '\n%s\n' "ifeq (\$(QCPATH),)" >> "${ANDROIDMK}"

write_makefiles "${MY_DIR}"/proprietary-files-qc.txt true

# Qualcomm performance blobs - conditional as well
# in order to support Cyanogen OS builds
cat << EOF >> "${PRODUCTMK}"
endif

-include vendor/extra/devices.mk
ifneq (\$(call is-qc-perf-target),true)
EOF

cat << EOF >> "${ANDROIDMK}"
endif

ifneq (\$(TARGET_HAVE_QC_PERF),true)
EOF

write_makefiles "${MY_DIR}"/proprietary-files-qc-perf.txt true

echo "endif" >> "${PRODUCTMK}"

cat << EOF >> "${ANDROIDMK}"

endif

# Finish
write_footers

if [ -s "${MY_DIR}"/../${DEVICE}/proprietary-files.txt ]; then
    # Reinitialize the helper for device
    INITIAL_COPYRIGHT_YEAR="${DEVICE_BRINGUP_YEAR}"
    setup_vendor "${DEVICE}" "${VENDOR}" "${AICP_ROOT}" false

    # Copyright headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}"/../${DEVICE}/proprietary-files.txt true

    # Finish
    write_footers
fi
