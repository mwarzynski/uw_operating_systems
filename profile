dd bs=512 skip=3 count=1 if=/dev/c0d0 of=username
USERNAME=$(head -c 13 username)
useradd -G users -m $USERNAME
login -f $USERNAME
