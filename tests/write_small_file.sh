#!/bin/sh

in="minixfilesystemisawesome"

for i in `seq 1 $1`
do
    echo $in > file
    sync
    rm file
done
