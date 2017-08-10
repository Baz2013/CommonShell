#!/bin/bash

echo "BEGIN#############################" >>pull.log
while read line
do
   path=`grep -20 "<${line}>" ~/etc/pp.cfg|tail -10|grep 'src_backup_path'|awk -F= '{print $2}'|awk -F# '{print $1}'|sed 's/ //g'`
   eval bak_path=${path}
   mkdir -p "cdr/${line}"
   cptl ${bak_path}/*2017072608* ./cdr/${line}
   cur_time=$(date +"%Y-%m-%d %H:%M:%S")
   echo "${cur_time}|${line}|${bak_path}" >>pull.log
done<pp_channels.txt
echo "END#############################" >>pull.log

