#!/bin/bash
work_path=`pwd`
if [ $# -ne "3" ];then
    echo "need three argument "
    echo "example:$0 config_name dsn_str operate_type"
    exit 1
fi
cfg_name="${1}"
str=$(echo ${cfg_name}|awk -F"." '{print $1}')
data_path="${work_path}/data_${str}"
dsn_str="${2}"
echo "BEGIN:`date +%Y%m%d%H%M%S`" >> ./exec.log
while read line;do
    user=`echo $line|awk -F, '{print $1}'`
    pass=`echo $line|awk -F, '{print $2}'`
    tab=`echo $line|awk -F, '{print $3}'`
    connsql="gsql $user $pass --dsn=${dsn_str}"
    if [ "$3" == "TRUNCATE" ];then
        echo "TRUNCATE TABLE $tab;"|$connsql
    elif [ "$3" == "CHECK" ];then
        count=`echo "select 'CNT' || count(0) from $tab;"|$connsql|grep CNT|grep -v COUNT|tr -cd [0-9]`
        #echo "±í:$tab ÌõÊı:$count"
        fcount=`wc -l ${data_path}/${tab}.dat|awk '{print $1}'|tr -cd [0-9]`
        if [ "${fcount}" -eq "${count}" ]; then 
            echo  "${tab}:  [FILECOUNT]=${fcount}  [${dsn_str}]=${count}----------------------Right------------------------"
        else
            echo  "${tab}:  [FILECOUNT]=${fcount}  [${dsn_str}]=${count}######################Wrong########################"
        fi 
    elif [ "$3" == "GLOADER" ];then
        if [ ! -d "${work_path}/ctl" ];then
            mkdir -p "${work_path}/ctl" 
        fi
        echo -e  "TABLE $tab\nFIELDS TERMINATED BY ','" > $work_path/ctl/${tab}.ctl
        nohup gloader $user $pass --dsn=${dsn_str} -p 8 -i -c $work_path/ctl/${tab}.ctl -d ${data_path}/${tab}.dat &
        #nohup gloader $user $pass --dsn=${dsn_str} -p 4 -i -c $work_path/ctl/${tab}.ctl -d ${data_path}/${tab}.dat &
    elif [ "$3" == "EXPORT" ];then
        if [ ! -d "${work_path}/ctl" ];then
            mkdir -p "${work_path}/ctl" 
        fi
        if [ ! -d "${data_path}" ];then
            mkdir -p "${data_path}"
        fi
        echo -e  "TABLE $tab\nFIELDS TERMINATED BY ','" > $work_path/ctl/${tab}.ctl
        nohup gloader $user $pass --dsn=${dsn_str} -e -c $work_path/ctl/${tab}.ctl -d ${data_path}/${tab}.dat &
    fi
done < ./"${cfg_name}"
echo "END:`date +%Y%m%d%H%M%S`" >> ./exec.log
