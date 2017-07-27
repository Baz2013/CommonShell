#!/bin/bash
# $1 ³ÌÐòÃû, Èç: pp,rr,split

#!/bin/bash

app=${1}
line=`grep -w ${1} service.txt`
service=$(echo ${line}|awk -F: '{print $2}')
if [ "x${service}" = "x" ];then
  exit 0
fi

for prov in 76 10 85 88
do
>tmp_channels.txt
grep "^5,${prov},${app}" channel.cfg|grep -v '^#'|awk -F, '{print $4}'|xargs |sed 's/\./\n/g'|sed 's/ /\n/g'|sort|grep -v "^$" >tmp_channels.txt
while read channel
do
  echo "insert into tb_service_channel (PROVINCE, TYPE, CHANNELNO, VALID, ARGS, SCHEDULER) values ('${prov}', '${service}', '${channel}', '0', '-c${channel} -k', 'marathon');"
done<tmp_channels.txt

done

