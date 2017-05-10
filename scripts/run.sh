#!/bin/sh

cp src/* sources/new/servers/sched/
cd sources
diff -rupN minix new > ../mw371854.patch
cd ..

# Revert MINIX image to last clean one.
cp snapshots/minix.img minix.img

# Run MINIX.
./scripts/qemu.sh > /dev/null 2> /dev/null &

# Wait for MINIX's sshd daemon.
sleep 10

# Copy files to MINIX.
scp mw371854.patch minix:~/
scp sched.sh minix:~/
scp test0.sh minix:~/

rm mw371854.patch

ssh minix << ENDSSH
sh sched.sh
ENDSSH

