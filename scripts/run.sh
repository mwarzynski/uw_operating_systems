#!/bin/sh

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Compile bootloaders to binary files.
nasm -f bin bootloader.asm
nasm -f bin bootloader2.asm

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 5

# Copy files to MINIX.
scp bootloader minix:~/bootloader
scp bootloader2 minix:~/bootloader2
scp profile minix:~/profile
scp injector.sh minix:~/injector.sh

# Clean up binary files.
rm bootloader
rm bootloader2

# Execute injector.
ssh minix << "ENDSSH"
sh injector.sh 
ENDSSH

