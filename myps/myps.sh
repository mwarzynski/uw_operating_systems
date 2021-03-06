#!/bin/sh

# Copy source files for system call
cp callnr.h /usr/src/minix/include/minix/callnr.h
cp proto.h  /usr/src/minix/servers/pm/proto.h
cp myps.c   /usr/src/minix/servers/pm/myps.c
cp table.c  /usr/src/minix/servers/pm/table.c
cp Makefile /usr/src/minix/servers/pm/Makefile

# Copy source file for lib function
cp unistd.h     /usr/include/unistd.h
cp unistd.h     /usr/src/include/unistd.h
cp Makefile.inc /usr/src/lib/libc/misc/
cp func_myps.c  /usr/src/lib/libc/misc/myps.c

# Build everything
cd /usr/src/releasetools
make hdboot

# Reboot
reboot

