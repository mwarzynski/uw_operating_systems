#!/bin/bash

i=0

while [ $i -lt $1 ]
do
    dd if=/dev/zero of=file bs=4096 count=$2 2> /dev/null
    rm file
    i=$[$i+1]
done

