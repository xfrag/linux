#!/usr/bin/env bash

mkdir -p ${KMOD_OUTPUT}

cp apc395x/${KCONF} ${KBUILD_OUTPUT}/.config
echo "Copied .config"

make ${MAKE_ARGS} LOADADDR=${LOAD_ADDRESS} -j${JOBS} Image.gz
echo "Built kernel."

make ${MAKE_ARGS} LOADADDR=${LOAD_ADDRESS} ${BOARD_NAME}.dtb
echo "Built DTB."

make ${MAKE_ARGS} -j${JOBS} modules
echo "Built modules."

make ${MAKE_ARGS} INSTALL_MOD_PATH=${KMOD_OUTPUT} \
     INSTALL_MOD_STRIP=1 modules_install
echo "Installed modules."

mkimage -A arm64 -O linux -T kernel -C none \
        -a ${LOAD_ADDRESS} -e ${LOAD_ADDRESS} -n linux-next \
        -d ${KBUILD_OUTPUT}/arch/arm64/boot/Image uImage-${KVERSION}
echo "Created kernel image."

# This is a 32-bit binary, make sure your environment is able to run it.
./apc395x/mkbootimg --kernel ${KBUILD_OUTPUT}/arch/arm64/boot/Image.gz \
    --base 0x0 --kernel_offset 0x1080000 \
    --cmdline "root=/dev/system rw rootfstype=ext4 rootwait init=/sbin/init" \
    --ramdisk apc395x/initrd.img-4.9.113 \
    --second ${KBUILD_OUTPUT}/arch/arm64/boot/dts/amlogic/gxl_p212_2g_buildroot.dtb \
    --output ${KBUILD_OUTPUT}/boot.img
echo "Created boot.img"