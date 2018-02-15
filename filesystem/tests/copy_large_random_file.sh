#!/bin/sh

dd if=/dev/urandom of=file bs=4096 count=1000 2> /dev/null
sync

for i in `seq 1 $1`
do
    cp file file2
    rm file2
done

rm file
