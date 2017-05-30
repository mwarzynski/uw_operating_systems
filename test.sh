#!/bin/bash

for file in tests/*
do
    bash "$file"

    if [ $? -ne 0 ]; then
        echo "$file error"
    fi
done

