#!/bin/sh

for test in tests/*
do
    echo -e "\033[0;33mTEST: $test\033[0m"
    (time ./$test $1) 2>&1 | grep real
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32mOK\033[0m"
    else
        echo "ERR"
    fi
    echo ""
done

