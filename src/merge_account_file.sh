#!/bin/bash

filepath="/cbss/billing/user/public/bill_account_bak/"
cd "${filepath}" && rm ./*.dat

nohup ./new_bill_account_x86.sh "qcubic5" "5" &
nohup ./new_bill_account_x86.sh "qcubic7" "7" &

despath="/cbss/billing/data5/bill_account/"
year=$(date +%Y)
day=$(date +%d)
monthName=$(date +%m)
if [ "${day}" -eq "01" ] && [ "${monthName}" -eq "01" ];then #1月1日取上一年12月账期表
        monthName=12
        year=$(expr "${year}" - 1)
elif [ "${day}" -eq "01" ]; then #其余月1日取上个月账期表
        monthName=$(expr "${monthName}" - 1)
        if [ "${monthName}" -le 9 ];then  #小于等于9月的月份，前面补0
                monthName="0${monthName}"
        fi
fi

filepath="/cbss/billing/user/public/bill_account_bak/"
dest_file_name="${day}_BILL_ACCOUNT_${year}${monthName}.dat"
i=$(echo "${monthName}%2"|bc)

################# public function##################
writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "${cur_time}|${1}|" >>"./jf${monthName}.log"
}

merge_file(){
  cd ${filepath}
  files=$(ls ./*.dat)
  for file in ${files}
  do
    writeLog "merge file ${file}"
    cat "${file}" >> "${dest_file_name}"
  done
  cd -
}

while true;do
pidnum=$(ps -ef|grep new_bill_account_x86|grep -v grep|wc -l)
if [ "${pidnum}" -eq "0" ];then
  writeLog "start merge data file"
  merge_file
  mv "${filepath}${dest_file_name}" "${despath}${dest_file_name}"
  writeLog "=====end====="
  exit 0
fi
sleep 5
done