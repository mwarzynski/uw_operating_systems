#!/bin/bash

# Check if writing zeroes work

in=$(dd if=/dev/zero bs=4096 count=5 2> /dev/null)
echo $in > zero_file
out=$(cat zero_file)

result=$(diff <(echo "$in") <(echo "$out"))
if [ "$result" = "" ]; then
    echo "-- OK --"
else
    echo "-- ERR -- saved filed with zeros is not the same"
fi
rm zero_file


# Check if writing random characters work

in=$(dd if=/dev/urandom bs=4096 count=5 2> /dev/null | tr -dc '0-9a-zA-Z!@#$%^&*_+-')
echo $in > random_file
out=$(cat random_file)

result=$(diff <(echo "$in") <(echo "$out"))
if [ "$result" = "" ]; then
    echo "-- OK --"
else
    echo "-- ERR -- saved filed with random values is not the same"
fi
rm random_file

