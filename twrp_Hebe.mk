#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 TeamWin Recovery Project
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

# Inherit some common TWRP/Omni stuff.
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)
$(call inherit-product-if-exists, vendor/omni/config/common.mk)

# Device identifier
PRODUCT_DEVICE := Hebe
PRODUCT_NAME := twrp_Hebe
PRODUCT_BRAND := Hinova
PRODUCT_MODEL := Hebe-BD00
PRODUCT_MANUFACTURER := Hinova
PRODUCT_RELEASE_NAME := Hi Nova 9 Pro
