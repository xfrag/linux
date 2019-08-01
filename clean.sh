#!/usr/bin/env bash

make ${MAKE_ARGS} -j${JOBS} distclean
rm -r ${KBUILD_OUTPUT}

unset KNAME
unset KVERSION
unset KCONF
unset JOBS
unset BOARD_NAME
unset MAKE_ARGS
unset LOAD_ADDRESS
unset KBUILD_OUTPUT
unset KMOD_OUTPUT