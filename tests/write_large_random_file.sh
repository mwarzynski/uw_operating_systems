#!/bin/sh

for i in `seq 1 $1`
do
    dd if=/dev/urandom of=file bs=4096 count=1000 2> /dev/null
    sync
    rm file
done
