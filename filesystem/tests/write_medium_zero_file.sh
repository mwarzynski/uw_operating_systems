#!/bin/sh

for i in `seq 1 $1`
do
    dd if=/dev/zero of=file bs=4096 count=100 2> /dev/null
    sync
    rm file
done

