#!/usr/bin/env bash

mkdir -p /tmp/kernel

tar -C ${KBUILD_OUTPUT}/modules/lib/modules -czf ${KBUILD_OUTPUT}/modules-${KVERSION}.tar.gz ${KVERSION}
echo "Compressed modules."

cp ${KBUILD_OUTPUT}/arch/arm64/boot/Image.gz \
    ${KBUILD_OUTPUT}/arch/arm64/boot/Image \
    uImage-${KVERSION} \
    apc395x/initrd.img-${KVERSION} \
    ${KBUILD_OUTPUT}/arch/arm64/boot/dts/amlogic/gxl_p212_2g_buildroot.dtb \
    ${KBUILD_OUTPUT}/boot.img \
    ${KBUILD_OUTPUT}/modules-${KVERSION}.tar.gz \
    /tmp/kernel/
echo "Packaged binaries."

tar -C /tmp -czf /tmp/kernel.tar.gz kernel
echo "Created archive."

# docker cp 5b2eaf294edc:/tmp/kernel.tar.gz .