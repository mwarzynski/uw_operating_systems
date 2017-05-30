#!/bin/bash

# Check if writing a simple file works.

in="minixfilesystemisawesome"
echo $in > file
out=$(cat file)
rm file

if [ "$in" == "$out" ]; then
    exit 0
else
    exit 1
fi

