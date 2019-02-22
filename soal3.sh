#!/bin/bash
tc=1
ptr=1
temp="password$ptr.txt"
while [ -e $temp ]
do
  let ptr++
  temp="password$ptr.txt"
done

randomgen=$(</dev/urandom tr -dc a-z0-9A-Z | head -c12)
echo $randomgen > $temp
