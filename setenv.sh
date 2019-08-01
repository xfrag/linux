#!/usr/bin/env bash

export KNAME=linux-stable
export KVERSION=4.9.113
export KCONF=meson64_gxl_defconfig

export JOBS=8

#export BOARD_NAME=gxl_p281_2g
export BOARD_NAME=gxl_p212_2g_buildroot

export MAKE_ARGS="ARCH=arm64 \
           CROSS_COMPILE=aarch64-linux-gnu-"

export LOAD_ADDRESS="0x1080000"

export KBUILD_OUTPUT=`pwd`/target/${KNAME}
export KMOD_OUTPUT=$KBUILD_OUTPUT/modules