#!/bin/bash

# Build scheduler
cd /usr/src/minix/servers/sched
make
make install

# Create new kernel image
cd /usr/src/releasetools
make do-hdboot

reboot
