#!/bin/sh

ssh minix << ENDSSH
mkdir tests
ENDSSH

scp tests/* minix:~/tests/
scp test.sh minix:~/

ssh minix << ENDSSH
sh test.sh
ENDSSH
