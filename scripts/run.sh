#!/bin/sh

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 3

# Copy files to MINIX.
scp src/* minix:~/
scp install.sh minix:~/install.sh

# Execute injector.
ssh minix << "ENDSSH"
sh install.sh
ENDSSH
