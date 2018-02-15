#!/usr/bin/expect -f

spawn ssh-copy-id -i /home/lnxmen/.ssh/minix_rsa -p 10022 root@localhost

expect "root@localhost's password:"
send "root\r"

interact

