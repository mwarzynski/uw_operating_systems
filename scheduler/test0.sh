if [ $1 ]
then
  echo Without load: > $1

  for k in `seq 3`
  do
    (time grep size_t /usr/src/minix/servers/*/*c > /dev/null) 2>> $1
  done

  grep -Rs size_t /usr/ > /dev/null &
  PID1=$!

  grep -Rs size_t /usr/ > /dev/null &
  PID2=$!

  grep -Rs size_t /usr/ > /dev/null &
  PID3=$!

  grep -Rs size_t /usr/ > /dev/null &
  PID4=$!

  echo Wait 20s for greps to use up their startup tokens
  sleep 20
  echo Go

  echo With load: >> $1

  for k in `seq 3`
  do
   (time grep size_t /usr/src/minix/servers/*/*c > /dev/null) 2>> $1
  done

  cat $1

  kill $PID1
  kill $PID2
  kill $PID3
  kill $PID4
else
  echo USAGE: $0 logfilename
fi
