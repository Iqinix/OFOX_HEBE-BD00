#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 OrangeFox Recovery Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from Hebe device
$(call inherit-product, device/hinova/Hebe/device.mk)

# Inherit common recovery configs if available
$(call inherit-product-if-exists, vendor/recovery/config/common.mk)
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)
$(call inherit-product-if-exists, vendor/omni/config/common.mk)

# Device identifier
PRODUCT_DEVICE := Hebe
PRODUCT_NAME := fox_Hebe
PRODUCT_BRAND := Hinova
PRODUCT_MODEL := Hebe-BD00
PRODUCT_MANUFACTURER := Hinova
PRODUCT_RELEASE_NAME := Hi Nova 9 Pro

# OrangeFox Configuration
FOX_VERSION := "R12.1"
FOX_BUILD_TYPE := "Unofficial"
OF_MAINTAINER := "Antigravity"
OF_TARGET_DEVICES := Hebe,Hebe-BD00,TINA-AN00,TS-TINA-Q

# Display / Notch / Status bar
OF_SCREEN_H := 2676
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_STATUS_H := 100
OF_ALLOW_DISABLE_NAVBAR := 0
OF_CLOCK_POS := 1

# Recovery builder
FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER := 1

# Tools & Shell
FOX_USE_BASH_SHELL := 1
FOX_ASH_IS_BASH := 1
FOX_USE_NANO_EDITOR := 1
FOX_USE_TAR_BINARY := 1
FOX_USE_SED_BINARY := 1
FOX_USE_XZ_UTILS := 1
FOX_REPLACE_BUSYBOX_PATH := 1

# Backup & Storage
OF_QUICK_BACKUP_LIST := "/boot;/data;/super;"
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := 1

# Security & Features
FOX_ADVANCED_SECURITY := 1
OF_FLASHLIGHT_ENABLE := 0
OF_USE_GREEN_LED := 0
