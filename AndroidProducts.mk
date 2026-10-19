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

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_Hebe.mk \
    $(LOCAL_DIR)/twrp_Hebe.mk \
    $(LOCAL_DIR)/fox_Hebe.mk

COMMON_LUNCH_CHOICES := \
    omni_Hebe-userdebug \
    omni_Hebe-eng \
    twrp_Hebe-userdebug \
    twrp_Hebe-eng \
    fox_Hebe-userdebug \
    fox_Hebe-eng
