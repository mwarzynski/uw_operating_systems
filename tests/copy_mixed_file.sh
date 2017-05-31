#!/bin/sh

dd if=/dev/urandom of=file bs=4096 count=330 2> /dev/null
dd if=/dev/zero of=file bs=4096 seek=330 count=330 2> /dev/null
dd if=/dev/urandom of=file bs=4096 seek=660 count=340 2> /dev/null
sync

for i in `seq 1 $1`
do
	cp file copy_file
	rm copy_file
done
