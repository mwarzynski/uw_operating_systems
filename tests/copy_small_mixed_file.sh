#!/bin/sh

dd if=/dev/urandom of=file bs=4096 count=1 2> /dev/null
dd if=/dev/zero of=file bs=4096 count=1 2> /dev/null >> file
dd if=/dev/urandom of=file bs=4096 count=1 2> /dev/null >> file
sync

for i in `seq 1 $1`
do
	cp file copy_file
	rm copy_file
done
