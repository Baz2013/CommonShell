#!/bin/bash
# $1 根据程序,通道号生成tb_service_channel表中的参数
# 程序如pp,rr,split
# 依赖service.txt 和 channel.cfg两个文件
# check with shellcheck
#usage: gern_channel_param.sh "send" "2" "13 31 36 87 97"

if [ $# -ne 3 ];then
  echo "need three parameter"
  echo "usage: gern_channel_param.sh \"send\" \"2\" \"13 31 36 87 97\""
  exit 1
fi

app=${1}
domain=${2}
provinces=${3}
line=$(grep -w "${app}" service.txt)
service=$(echo "${line}"|awk -F: '{print $2}')
if [ "x${service}" = "x" ];then
  exit 0
fi

# double quoted this, it will not word split, and the loop will only run once
for prov in ${provinces}
do
records=$(grep "^${domain},${prov},${app}," channel.cfg|grep -v '^#'|awk -F, '{print $4}'|xargs |sed 's/\./\n/g'|sed 's/ /\n/g'|sort|grep -v "^$")
echo "${records}"|while read -r channel
do
  echo "insert into tb_service_channel (PROVINCE, TYPE, CHANNELNO, VALID, ARGS, SCHEDULER) values ('${prov}', '${service}', '${channel}', '0', '-c${channel} -k', 'marathon');"
done

done

