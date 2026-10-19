# TWRP / OrangeFox Device Tree for Hi Nova 9 Pro (Hebe-BD00 / TINA-AN00)

## Device Specifications

| Feature | Specification |
|:---:|:---:|
| SoC | Qualcomm SM7325 Snapdragon 778G 5G (6 nm) |
| CPU | Octa-core (4x2.4 GHz Kryo 670 & 4x1.8 GHz Kryo 670) |
| GPU | Adreno 642L |
| Architecture | ARM64 (`arm64-v8a`) |
| Memory (RAM) | 8 GB |
| Display | 6.72" OLED, 1236 x 2676 pixels (~520 ppi), 120Hz |
| OS Version | Android 11 (HarmonyOS / EMUI 12) |
| Storage | 128 GB / 256 GB UFS 2.2 (`soc/1d84000.ufshc`) |
| Partition Scheme | Dynamic Partitions (Super 8GB), Non-A/B |
| Boot Image Type | Android Boot Image v3 (`boot.img`, `recovery.img`, `recovery_ramdisk.bin`) |

---

## Important Huawei / Hi Nova Recovery Architecture

On Huawei / Hi Nova devices with Qualcomm processors:
- **`recovery`** partition (96 MB): Contains the recovery kernel image.
- **`recovery_ramdisk`** partition (36 MB / 37,748,736 bytes): Contains the **actual recovery ramdisk payload** executed by the bootloader when booting recovery.
- Flashing a full boot image containing a kernel to `recovery_ramdisk` will fail with `error: volume full` because full images exceed the 36 MB partition size.
- The `recovery_ramdisk` image must be packed with `kernel_size = 0` and size strictly under 37,748,736 bytes.

---

## Partition Table Overview

- `boot`: 96 MB (`/dev/block/bootdevice/by-name/boot`)
- `recovery`: 96 MB (`/dev/block/bootdevice/by-name/recovery`)
- `recovery_ramdisk`: 36 MB (`/dev/block/bootdevice/by-name/recovery_ramdisk`)
- `vendor_boot`: 96 MB (`/dev/block/bootdevice/by-name/vendor_boot`)
- `dtbo`: 24 MB (`/dev/block/bootdevice/by-name/dtbo`)
- `super`: 8 GB (`/dev/block/bootdevice/by-name/super`)
  - `system` (dm-0)
  - `vendor` (dm-3)
  - `hw_product` (dm-1)
  - `odm` (dm-4)
  - `cust` (dm-2)
- `userdata`: `/dev/block/bootdevice/by-name/userdata` (F2FS)
- `metadata`: 16 MB (`/dev/block/bootdevice/by-name/metadata`)

---

## Flashing Instructions

### 1. Boot to Fastboot Mode
```bash
adb reboot bootloader
```

### 2. Flash Custom Recovery Ramdisk
To flash **OrangeFox**:
```bash
fastboot flash recovery_ramdisk recovery_ramdisk_hebe_ofox.img
```

To flash **TWRP**:
```bash
fastboot flash recovery_ramdisk recovery_ramdisk_hebe_twrp.img
```

### 3. Reboot to Recovery
```bash
fastboot reboot recovery
```

*(Or hold Volume Up + Power while disconnecting USB cable)*

### Restoring Stock Recovery
```bash
fastboot flash recovery_ramdisk extracted/recovery_ramdisk.bin
```
