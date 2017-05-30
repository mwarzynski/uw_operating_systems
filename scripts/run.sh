#!/bin/sh

BUILD=""
if [ "$#" -eq 1 ] && [ $1 = "kernel" ]; then
   BUILD="kernel"
fi

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 5

# Copy files to MINIX.
scp src/read.c minix:/usr/src/minix/fs/mfs/
scp fs.sh minix:~/

ssh minix << ENDSSH
sh fs.sh $BUILD
ENDSSH

