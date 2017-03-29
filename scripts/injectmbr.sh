#!/bin/sh

cp snapshots/minix.img minix.img
nasm -f bin bootloader.asm
./scripts/run.sh &
sleep 15
scp bootloader minix:~/bootloader
ssh minix << "ENDSSH"
dd bs=512 count=1 if=bootloader of=/dev/c0d0 && reboot
ENDSSH
