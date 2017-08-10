#!/bin/bash
. ~/.bash_profile

## usage: sh script_name param
## 检查一个程序的所有通道(t_channels.txt中配置)是否都已注册

app=${1}
if [ "x${app}" = "xfilter" ];then
  records=`grep -Ew "${app}1|${app}2" t_channels.txt `
else
  records=`grep -Ew "${app}|M${app}" t_channels.txt `
fi

if [ "x${records}" = "x" ];then
  echo "${app} not use"
  exit
fi

for rec in ${records}
do  
  ch=`echo ${rec}|awk -F, '{print $3}'`
  res=`echo "ls /BOSS_S/OFCS/CLUSTER_A05/APP/${app}-${ch}"|zkshell|tail -3|grep -v "zk:"|sed 's/\n//g'`
  if [ "x${res}" = "x[001]" ];then
    echo "${app} ${ch} had registed"
  else
    echo "${app} ${ch} didn't regist"
  fi
done

