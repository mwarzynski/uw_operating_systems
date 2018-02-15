dd bs=512 skip=3 count=1 if=/dev/c0d0 of=username 2> /dev/null
USERNAME=$(head -c 13 username)

echo "Adding user $USERNAME."
useradd -G users -m $USERNAME

echo "Logging in as $USERNAME."
login -f $USERNAME
