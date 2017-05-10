#!/bin/sh

cp src/* sources/new/servers/sched/
diff -rupN sources/old sources/new > mw371854.patch

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 10

# Copy files to MINIX.
scp sources/mw371854.patch minix:~/
scp sched.sh minix:~/
scp test0.sh minix:~/

rm mw371854.patch

ssh minix << ENDSSH
sh sched.sh
ENDSSH

