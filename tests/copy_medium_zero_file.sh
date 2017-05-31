#!/bin/sh

dd if=/dev/zero of=file bs=4096 count=100 2> /dev/null
sync

for i in `seq 1 $1`
do
    cp file a
    rm a
done

rm file
