#!/bin/bash
x=1
unzip nature.zip
for name in nature/*.jpg
do
 base64 -d $name | xxd -r > nature/pictures"$x".jpg
 rm $name
 let x++
done
