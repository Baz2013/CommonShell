#!/bin/bash
#usage: $1:qcubic dsn, $2:domain

DSN="${1}"
DOMAIN="${2}"
QCUBICLOAD197="gloadernet billing${DOMAIN} billing --dsn=${DSN} -e -c"
filepath="/cbss/billing/user/public/bill_account_bak/"
despath="/cbss/billing/data${DOMAIN}/bill_account/"
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

i=$(echo "${monthName}%2"|bc)
#output_data_file="${day}_BILL_ACCOUNT_${year}${monthName}.dat"
output_data_file="${day}_${DSN}_BILL_ACCOUNT_${year}${monthName}.dat"

######public function#####
writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "${cur_time}|${1}|" >>"./jf${monthName}.log"
}

echo -e "TABLE BILL_ACCOUNT_${i}\nFIELDS TERMINATED BY ','" >"${filepath}BILL_ACCOUNT_${i}.ctl"
writeLog "QCUBIC START"
${QCUBICLOAD197} "${filepath}BILL_ACCOUNT_${i}.ctl" -d "${filepath}${output_data_file}" -l  "${filepath}${year}${monthName}.log" -B
filenum=$(< "${filepath}${output_data_file}" wc -l|tr -cd '[0-9]')
dbnum=$(< "${filepath}${year}${monthName}.log" awk -F ' ' '{print $6}')
writeLog "total:${dbnum},filenum:${filenum}"
if [ "${filenum}" -eq "${dbnum}" ] ;then
	writeLog "success"
	mv "${filepath}${output_data_file}" "${despath}${output_data_file}" # if domain 5 then comment
	rm "${filepath}BILL_ACCOUNT_${i}.ctl"
else 
	writeLog "failed ,QCUBIC NUMBER: ${dbnum}, DATE FILE NUMBER:${filenum}"
fi
exit 0