#!/bin/bash

if [ $# -ne 3 ];then
  echo "usage: $0 start_day end_day redis_host"
  exit 1
fi

start_day="${1}"
end_day="${2}"
redis_host="${3}"

tmp_day=$(date -d "+15 day ${end_day}" +%Y%m%d)
curr_day=$(date +%Y%m%d)
if [ ${tmp_day} -ge ${curr_day} ];then
  echo "禁止删除最近15天内的数据"
  exit 2
fi

echo "#!/bin/bash"> tmp_del_key.sh
while [ ${start_day} -le ${end_day} ]
do
   #echo "${start_day}"
   echo "keys *${start_day}*" |redis-cli -h ${redis_host}|sed 's/^.*)//g'|xargs -i printf "echo \"del {}\"|redis-cli -h ${redis_host};sleep 0.01 \n" >>./tmp_del_key.sh
   start_day=$(date -d "+1 day ${start_day}" +%Y%m%d)
done


chmod +x tmp_del_key.sh
./tmp_del_key.sh
cat ./tmp_del_key.sh >>his_del_key.txt
rm tmp_del_key.sh

