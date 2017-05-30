#!/bin/bash

# Check if writing even more zeroes works

# Generally, there is a problem with comparing strings with null values, because bash
#   thinks it is the end of variable.
# As suggested here, we may use hexdump to check if binary data matches.
# https://stackoverflow.com/questions/9487037/passing-binary-data-as-arguments-in-bash

in=$(dd if=/dev/zero bs=4096 count=100 2> /dev/null | tee file | hexdump -C )
out=$(cat file | hexdump -C)
rm file

if [ "$in" == "$out" ]; then
    exit 0
else
    exit 1
fi

