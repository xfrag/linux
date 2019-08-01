#!/usr/bin/env bash

# Make sure you have ran Kernel's setenv.sh.
make ${MAKE_ARGS} -j${JOBS} -C ${KBUILD_OUTPUT} M=`pwd` CONFIG_MALI400=m modules

cp mali.ko ${KBUILD_OUTPUT}/modules/lib/modules/${KVERSION}/kernel/drivers
