import struct
import os
import sys

PAGE_SIZE = 4096
MAX_PARTITION_SIZE = 37748736  # Exactly 36 MB (9216 sectors * 4096)

STOCK_CMDLINE = (
    "androidboot.hardware=qcom "
    "msm_rtb.filter=0x237 "
    "ehci-hcd.park=3 "
    "lpm_levels.sleep_disabled=1 "
    "androidboot.bootdevice=7824900.sdhci "
    "slub_min_objects=12 "
    "unmovable_isolate1=2:192M,3:224M,4:256M "
    "androidboot.selinux=permissive "
    "buildvariant=user"
)

def pack_recovery_ramdisk(ramdisk_cpio_gz_path, out_img_path, cmdline=STOCK_CMDLINE, os_version=0x1600014b):
    if not os.path.exists(ramdisk_cpio_gz_path):
        raise FileNotFoundError(f"Ramdisk file not found: {ramdisk_cpio_gz_path}")
        
    with open(ramdisk_cpio_gz_path, 'rb') as f:
        ramdisk_data = f.read()
    ramdisk_size = len(ramdisk_data)
    
    header_size = PAGE_SIZE
    header_version = 3
    kernel_size = 0  # In Huawei recovery_ramdisk, kernel_size is 0!
    
    cmdline_bytes = cmdline.encode('latin1')[:1536].ljust(1536, b'\x00')
    
    # Android Boot Image v3 header struct
    hdr_prefix = struct.pack('<8sIIII4II1536s',
        b'ANDROID!',
        kernel_size,      # 0
        ramdisk_size,     # size of cpio.gz
        os_version,
        PAGE_SIZE,
        0, 0, 0, 0,       # reserved[4]
        header_version,   # 3
        cmdline_bytes
    )
    
    hdr_padded = hdr_prefix.ljust(PAGE_SIZE, b'\x00')
    
    # Pad ramdisk to 4096 bytes
    rd_pad_len = (PAGE_SIZE - (ramdisk_size % PAGE_SIZE)) % PAGE_SIZE
    ramdisk_padded = ramdisk_data + (b'\x00' * rd_pad_len)
    
    total_data = hdr_padded + ramdisk_padded
    total_size = len(total_data)
    
    print(f"Packing Huawei recovery_ramdisk image:")
    print(f"  Header size:  {len(hdr_padded)} bytes")
    print(f"  Kernel size:  0 bytes")
    print(f"  Ramdisk size: {ramdisk_size} bytes (padded: {len(ramdisk_padded)} bytes)")
    print(f"  Total size:   {total_size} bytes ({total_size / (1024*1024):.2f} MB)")
    print(f"  Max allowed:  {MAX_PARTITION_SIZE} bytes ({MAX_PARTITION_SIZE / (1024*1024):.2f} MB)")
    
    if total_size > MAX_PARTITION_SIZE:
        raise ValueError(
            f"ERROR: Image size {total_size} exceeds partition limit {MAX_PARTITION_SIZE} "
            f"by {total_size - MAX_PARTITION_SIZE} bytes!"
        )
        
    with open(out_img_path, 'wb') as out_f:
        out_f.write(total_data)
        
    print(f"[+] Successfully generated: {out_img_path}")
    print(f"[+] Fits within partition with {MAX_PARTITION_SIZE - total_size} bytes remaining!")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python3 pack_recovery_ramdisk.py <ramdisk.cpio.gz> <output_recovery_ramdisk.img>")
        sys.exit(1)
    pack_recovery_ramdisk(sys.argv[1], sys.argv[2])
