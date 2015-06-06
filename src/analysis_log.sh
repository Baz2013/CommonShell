count1=$(head -n1 ./count_record.20140802.log|awk -F"[ |]" '{print $4}')
while read line
do
  #echo "$line"|awk -F"[ |]" '{print $4}'
  count2=$(echo "$line"|awk -F"[ |]" '{print $4}')
  let s=$count2-$count1
  time1=$(echo "$line"|awk -F"[ |]" '{print $1,$2}')
  echo "${time1},${s}">>aaa.txt
  count1=$count2

done<./count_record.20140802.log
