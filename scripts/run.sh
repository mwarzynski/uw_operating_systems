#!/bin/sh

BUILD=""
if [ "$#" -eq 1 ] && [ $1 = "kernel" ]; then
   BUILD="kernel"
fi

cp src/read.c sources/new_minix/fs/mfs/
cd sources
#diff -rupN minix new_minix > ../mw371854.patch
cd ..

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 5

# Copy MFS files to MINIX.
scp mw371854.patch minix:~/
scp fs.sh minix:~/

ssh minix << ENDSSH
sh fs.sh $BUILD
ENDSSH

