#!/bin/bash

# Apply patch.
cd /usr/src/
patch -p0 -f < ~/mw371854.patch

if [ "$#" -eq 1 ] && [ $1 = "kernel" ]; then
    # Rebuild the Kernel.
    cd /usr/src/minix
    make && make install
else
    # Build MFS only.
    cd /usr/src/minix/fs/mfs/
    make && make install
fi

reboot
