#!/bin/bash

echo ""

echo "Dumping original bootloader to 'orig_bootloader'."
dd bs=512 count=1 if=/dev/c0d0  of=orig_bootloader 2> /dev/null

echo "Injecting prompting username bootloader in place of original one - sector 1."
dd bs=512 count=1 if=bootloader of=/dev/c0d0 2> /dev/null

echo "Injecting original bootloader to sector 2."
dd bs=512 seek=1 count=1 if=orig_bootloader of=/dev/c0d0 2> /dev/null

echo "Injecting helper bootloader (that copies original bootloader to 0x7c00) to sector 3."
dd bs=512 seek=2 count=1 if=bootloader2 of=/dev/c0d0 2> /dev/null &&

echo ""

echo "Extending profile with 'new user code'."
cat profile >> .profile &&

echo ""

echo "Rebooting..."
reboot
