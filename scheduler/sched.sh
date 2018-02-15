#!/bin/bash

# Patch sched
cd /usr/src
patch -p0 < ~/mw371854.patch

# Build scheduler
cd /usr/src/minix/servers/sched
make
make install

# Create new kernel image
cd /usr/src/releasetools
make do-hdboot

reboot
