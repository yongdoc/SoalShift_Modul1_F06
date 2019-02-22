#!/bin/bash
namafile=`echo $1 $2 | awk -F. '{print $1}'`
temp=`echo $1 | awk -F: '{print $1}'`
temp=${temp#0}
temp=$((26-$temp))
temp2=$(($temp-1))
temp_up=$(($temp+65))
temp2_up=$(($temp_up-1))
if [ $temp2_up -lt 65 ]
then
  temp2_up=90
fi
temp_low=$(($temp+97))
temp2_low=$(($temp_low-1))
if [ $temp2_low -lt 97 ]
then
  temp2_low=122
fi
temp_up=$(printf '%b' $(printf '\\%03o' $temp_up))
temp2_up=$(printf '%b' $(printf '\\%03o' $temp2_up))
temp_low=$(printf '%b' $(printf '\\%03o' $temp_low))
temp2_low=$(printf '%b' $(printf '\\%03o' $temp2_low))

cat "$namafile.txt" | tr [a-z] [$temp_low-za-$temp2_low] | tr [A-Z] [$temp_up-ZA-$temp2_up] > "$namafile decrypted.txt"
