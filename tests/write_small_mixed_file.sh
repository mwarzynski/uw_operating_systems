#!/bin/sh

for i in `seq 1 $1`
do
    dd if=/dev/urandom of=file bs=4096 count=3 2> /dev/null
	dd if=/dev/zero bs=4096 count=3 2> /dev/null >> file
	dd if=/dev/urandom bs=4096 count=4 2> /dev/null >> file
	sync
	rm file
done
