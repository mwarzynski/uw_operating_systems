#!/bin/sh
cp snapshots/minix.img minix.img
nasm -f bin bootloader.asm
nasm -f bin bootloader2.asm

./scripts/run.sh &

sleep 5

scp bootloader minix:~/bootloader
scp bootloader2 minix:~/bootloader2

rm bootloader
rm bootloader2

ssh minix << "ENDSSH"
dd bs=512 count=1 if=/dev/c0d0  of=orig_bootloader &&
dd bs=512 count=1 if=bootloader of=/dev/c0d0 &&
dd bs=512 seek=1 count=1 if=orig_bootloader of=/dev/c0d0 &&
dd bs=512 seek=2 count=1 if=bootloader2 of=/dev/c0d0 &&
reboot
ENDSSH

