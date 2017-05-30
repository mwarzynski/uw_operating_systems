#!/bin/bash

# Check if creating empty file works (and file has empty size)

touch file
size=$(du file | awk '{print $1}')
rm file

if [ "$size" == "0" ]; then
    exit 0
else
    exit 1
fi

