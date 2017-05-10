#!/bin/bash

# Copy scheduler source files.
cp sched/* /usr/src/minix/servers/sched/

# Build scheduler
cd /usr/src/minix/servers/sched
make
make install

# Create new kernel image
cd /usr/src/releasetools
make do-hdboot

reboot
