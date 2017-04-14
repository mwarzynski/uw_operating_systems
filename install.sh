#!/bin/sh

# Copy all source files.
cp callnr.h /usr/src/minix/include/minix/callnr.h
cp proto.h  /usr/src/minix/servers/pm/proto.h
cp myps.c   /usr/src/minix/servers/pm/myps.c
cp table.c  /usr/src/minix/servers/pm/table.c
cp Makefile /usr/src/minix/servers/pm/Makefile

# Build kernel
cd /usr/src/releasetools
make hdboot

# Build PM
cd /usr/src/minix/servers/pm
make
make install

# Reboot
reboot

