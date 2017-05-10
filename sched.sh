#!/bin/bash

# Patch sched
cd /usr/src/minix
patch -p1 < ~/mw371854.patch

# Build scheduler
cd /usr/src/minix/servers/sched
make
make install

# Create new kernel image
cd /usr/src/releasetools
make do-hdboot

reboot
