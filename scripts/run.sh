#!/bin/sh

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 10

# Copy files to MINIX.
scp src/* minix:/usr/src/minix/servers/sched/
scp sched.sh minix:~/
scp test0.sh minix:~/

