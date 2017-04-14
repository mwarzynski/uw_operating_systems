#!/bin/sh

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 5

# Copy files to MINIX.
#scp bootloader minix:~/bootloader

# Execute injector.
ssh minix << "ENDSSH"
poweroff
ENDSSH

