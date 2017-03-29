#!/bin/bash

qemu-system-x86_64 -curses -enable-kvm -drive file=minix.img -localtime -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 1024M
