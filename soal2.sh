#!/bin/bash
echo "2 a." > answer.txt
awk 'BEGIN {FS = ","};{if($7==2012)qty[$1]+=$10}END{for(x in qty)print qty[x]","x}' WA_Sales_Products_2012-14.csv | sort -rg | awk -F , 'NR==1 {print $2}' >> answer.txt
echo "2 b." >> answer.txt
awk 'BEGIN {FS = ","};{if($7==2012&&$1=="United States")qty[$4]+=$10}END{for(x in qty)print qty[x]","x}' WA_Sales_Products_2012-14.csv | sort -rg | awk -F , 'NR>=1&&NR<=3 {print $2}' >> answer.txt
echo "2 c." >> answer.txt
awk 'BEGIN {FS = ","};{if($7==2012&&$1=="United States"&&($4=="Personal Accessories"||$4=="Camping Equipment"||$4=="Outdoor Protection"))qty[$6]+=$10}END{for(x in qty)print qty[x]","x}' WA_Sales_Products_2012-14.csv | sort -rg | awk -F , 'NR>=1&&NR<=3 {print $2}' >> answer.txt
