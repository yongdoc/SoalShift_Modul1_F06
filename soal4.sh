#!/bin/bash

#pengganti huruf merupakan waktu saat ini + urutan huruf (ex. pukul 9 -> huruf c = 9+3 = 12)
timer=`date "+%X" | awk 'BEGIN{FS=":"}END{print $1}'`
#echo $timer
timer=${timer#0}

#pada ASCII, huruf kecil a sama dengan 97, dan z sama dengan 122
lc=$((timer+97))
temp=$((lc))
#mengubah lc menjadi sebuah karakter
lc=$(printf '%b' $(printf '\\%03o' $lc))
#batas atas untuk huruf kecil
lc_atas=$((temp))
let lc_atas--
if [ $lc_atas -lt 97 ]
then
  lc_atas=122
fi
lc_atas=$(printf '%b' $(printf '\\%03o' $lc_atas))

#Huruf besar pada ASCII dimulai dari 65 s/d 90
uc=$((timer+65))
temp2=$((uc))
uc=$(printf '%b' $(printf '\\%03o' $uc))
#batas atas untuk huruf besar
uc_atas=$((temp2))
let uc_atas--
if [ $uc_atas -lt 65 ]
then
  uc_atas=90
fi
uc_atas=$(printf '%b' $(printf '\\%03o' $uc_atas))
#untuk nama file
jam="`date +\"%H\"`"
mnt="`date +\"%M\"`"
tgl="`date +\"%d\"`"
bln="`date +\"%m\"`"
thn="`date +\"%Y\"`"

cat /var/log/syslog | tr -d [a-z] ["$lc"-za-"$lc_atas"] | tr -d [A-Z] ["$uc"-ZA-"$uc_atas"] > "$jam:$mnt $tgl-$bln-$thn".txt
