#!/bin/bash

# Check if writing more random characters works

in=$(dd if=/dev/urandom bs=4096 count=100 2> /dev/null | tee file | tr -dc '0-9a-zA-Z!@#$%^&*_+-')
echo $in > file
out=$(cat file | tr -dc '0-9a-zA-Z!@#$%^&*_+-')
rm file

if [ "$in" == "$out" ]; then
    exit 0
else
    exit 1
fi

