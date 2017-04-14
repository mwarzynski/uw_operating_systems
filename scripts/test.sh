#!/bin/sh

# Execute simple test.
ssh minix << ENDSSH
mkdir test
ENDSSH

scp test/test.c minix:~/test/test.c

ssh minix << ENDSSH
cd test
make test
ENDSSH

ssh minix
