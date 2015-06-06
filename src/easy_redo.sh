#1.�Զ�ͣ��������
#2.ɾ��10����ǰ���ļ�

. $HOME/user/gucb/common/gucb.common.func.sh

#$1 pro_code $2 message
writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
printf "${cur_time}|$1|$2 \n" >> ${log_name}
}

#ɾ��ʮ����ǰ�ı����ļ�

#$1 Ҫɾ���ļ���Ŀ¼
deleteOldFile(){
  path=$(eval echo "$1")
  #echo "$path"
  find ${path} -name "*"  -mtime +15 -exec rm {} \;
}

#ɾ��������������Ŀ¼�µ�REDO�ļ�,��ͨ������Խ�Ŀ¼д�������ļ���,ͨ��ʡ�ݱ����ȡĿ¼
#$1 ����ͨ����
deleteRedoFile(){
  no2=$(echo $1|cut -c2)
  eval path=\$BOSS_DATA${no}/smsremind/it${no2}00/
  echo "$path"
  find ${path} -name "*REDO*" -exec rm {} \;
  writeLog " " "$path �µ� REDO�ļ���ɾ��"
}

#getSQL(){
#     "insert into TD_REDO_FLAG (BIZ_TYPE, BILLING_CYCLE, CHANNEL_NO, STATUS, AUTO_FLAG, SQL, UPDATE_PERSON, UPDATE_DATETIME, CHECK_PERSON, CHECK_DAT
#ETIME, FLAG)values ('BIZ_TYPE_AAA', '201405', '624', 'REDO', '0', 'SQL_WHERE', '', '', '', '', '');"
#}

#$1 ҵ������ $2 where����  $3 ���� $4 connection $5ʡ�ֱ���
executeSQL(){
echo "$1 \n$2 \n$3 \n$4"
if [ "$1" -eq "1" ];then
  biz=""
elif [ "$1" -eq "3" ];then
  biz="_GS"
elif [ "$1" -eq "2" ];then
  biz="_SM"
elif [ "$1" -eq "8" ];then
  biz="_SP"
fi
echo "biz = ${biz}"

sqlplus -s $4 << EOF
set heading off wrap on numwidth 30  feedback off
delete  from TD_REDO_FLAG;
insert into TD_REDO_FLAG (BIZ_TYPE, BILLING_CYCLE, CHANNEL_NO, STATUS, AUTO_FLAG, SQL, UPDATE_PERSON, UPDATE_DATETIME, CHECK_PERSON, CHECK_DATETIME,
FLAG)values ('$1', '$3', '624', 'REDO', '0', '$2', '', '', '', '', '');
commit
delete from TG_CDRREDO${biz};
commit
disconnect
exit
EOF
writeLog "$5" " ��TD_REDO_FLAG���в������ݳɹ� "
writeLog "$5" "�����м��TG_CDRREDO${biz}�ɹ�"

}

##�Զ��жϻ������� 1 �Ż������µ�

##ͣ���� $1 ������ $2ͨ���� $ʡ�ֱ���
killProc(){
echo "1: $1 2:$2 3:$3"
channel_pid=$(ps -ef|grep $1|grep `whoami`|grep $2|awk '{print $2}')
echo "pid is : $channel_pid"
if [ "${channel_pid}" = "" ];then
   writeLog "$3" "����${1} -c${2}δ����"
   return 0
elif [ "${channel_pid}" != "" ];then
kill ${channel_pid}
sleep 1
count=$(ps -ef|grep $1|grep `whoami`|grep $2|wc -l)
echo "count $count"
i=1
while [ "${count}" -eq "1" ] && [ i -lt 4 ];
do
        s_time=`expr $i \* 2`
        sleep ${s_time}
        kill ${channel_pid} 2>/dev/null #���ܻᱨ��
        count=$(grep ${channel_pid}|grep -v grep |wc -l)
        echo "while count $count|sleep time :$s_time"
        i=`expr $i + 1`
done
if [ ${count} -eq 0 ];then

        writeLog $3 "����${1} -c${2}��ֹͣ"
fi
if [ ${i} -eq 4 ];then
        writeLog "$1 -c$2 �ý��̿��ܽ�ʬ����,����!"
        printf "$1 -c$2 �ý��̿��ܽ�ʬ����,����!"
fi
fi
}
#$1 ������ $2 ����ͨ���� $ʡ�ֱ���
startProc(){
  count=$(ps -ef|grep redo|grep "$2"|wc -l)
i=1
while [ "${count}" -eq "1" ] && [ i -lt 11 ];
do
sleep `expr $i \* 4`
i=`expr $i + 1`
done
if [ "$1" = "filter" ];then
  cd ~/bin
  ./filter -c$2 1>/dev/null
  cd -
elif [ "$1" = "rate" ];then
  cd ~/bin
  ./rate -c$2 1>/dev/null
  cd -
fi
writeLog $3 "���� $1 -c$2������"
}

#altibase bakup
#$1 ip $2 user  $3 ��ż��  $4 �·�
bakupAltibase(){
if [ "$bak_flag" -eq "0" ];then
echo "$1 \n$2 \n$3 \n$4"
mkdir -p $5
cd $5
#iloader -s ${1} -u ${2} -p billing -port 20300 formout -T BILL_ACCOUNT_${3} -f BILL_ACCOUNT_${3}.fmt 1>/dev/null
iloader -s ${1}  -u ${2} -p billing -port 20300 formout -T BILL_USER_SUM1_${4} -f BILL_USER_SUM1_${4}.fmt 1>/dev/null
iloader -s ${1}  -u ${2} -p billing -port 20300 formout -T BILL_USER_${4} -f BILL_USER_${4}.fmt 1>/dev/null
iloader -s ${1}  -u ${2} -p billing -port 20300 formout -T BILL_USER_SUM4_${4} -f BILL_USER_SUM4_${4}.fmt 1>/dev/null
iloader -s ${1}  -u ${2} -p billing -port 20300 formout -T BILL_USER_MONFEE_${3} -f BILL_USER_MONFEE_${3}.fmt 1>/dev/null

#iloader -s ${1} -u ${2} -p billing -port 20300 out -T BILL_ACCOUNT_${3} -f BILL_ACCOUNT_${3}.fmt -d BILL_ACCOUNT_${3}.dat -t ","  1>/dev/null
iloader -s ${1}  -u ${2} -p billing -port 20300 out -T BILL_USER_SUM1_${4} -f BILL_USER_SUM1_${4}.fmt -d BILL_USER_SUM1_${4}.dat -t ","
iloader -s ${1}  -u ${2} -p billing -port 20300 out -T BILL_USER_${4} -f BILL_USER_${4}.fmt -d BILL_USER_${4}.dat -t ","
iloader -s ${1}  -u ${2} -p billing -port 20300 out -T BILL_USER_SUM4_${4} -f BILL_USER_SUM4_${4}.fmt -d BILL_USER_SUM4_${4}.dat -t ","
iloader -s ${1}  -u ${2} -p billing -port 20300 out -T BILL_USER_MONFEE_${3} -f BILL_USER_MONFEE_${3}.fmt -d BILL_USER_MONFEE_${3}.dat -t ","
cd -
bak_flag=1
fi
}

start_redo(){
  redo_flag=0
  redo -c${1} 1>/dev/null
  sleep 2
  w=$(ps -ef|grep redo|grep "${1}"|wc -l)
  if [ "${w}" -eq 0 ];then
    writeLog "$2" "����ͨ������ʧ�� ��鿴���ջ�����־�ļ��Խ���ȷ��!"
  elif [ "${w}" -eq 1 ];then
    writeLog "$2" "����ͨ������ "
  fi
}
getChannelNo(){
  no1=$(echo "$1"|cut -c2)
if [ "$2" = "filter" ];then
  if [ $3 -eq "1" ];then
  _no=${no}${no1}00
elif [ $3 -eq "3" ];then
  _no=${no}${no1}10
elif [ $3 -eq "2" ];then
  _no=${no}${no1}20
elif [ $3 -eq "8" ];then
  _no=${no}${no1}30
fi
elif [ "$2" = "rate" ] || [ "$2" = "smsremind" ];then
  _no=${no}${no1}00
fi
echo "${_no}"

}
##ȷ����������
day=$(date +"%d")
if [ ${day} -eq "01" ];then
        tmp=$(date +"%Y%m")
        redoCycle=$(expr ${tmp} - 1)
else
        redoCycle=$(date +"%Y%m")
fi
no=$(whoami|cut -c8)
mon2=$(date +%m)
mon1=$(expr $mon2 % 2)
bak_date=$(date +%m%d%H)
bak_flag=0

eval ORACONN=\$ORACONN_UCR_${prov_code}
eval ALTI_IP=\$ALT_IP_${no}

while read line;
do
        channel_no=$(echo "${line}"|awk -F"#" '{print $1}')
        prov_code=$(echo "${line}"|awk -F"#" '{print $2}')
        biz_type=$(echo "${line}"|awk -F"#" '{print $3}')
        sql_wh=$(echo "${line}"|awk -F"#" '{print $4}')
        isKillFilter=$(echo "${line}"|awk -F"#" '{print $5}')
        isKillRate=$(echo "${line}"|awk -F"#" '{print $6}')
        filter_no=$(getChannelNo "$channel_no" "filter" "$biz_type")
        rate_no=$(getChannelNo "$channel_no" "rate" "$biz_tyype")
        smsremind_no=$(getChannelNo "$channel_no" "smsremind" "$biz_type")
        #echo "filter_no :$filter_no"
        #echo "rate_no :$rate_no"
        #echo "smsremind_no :$smsremind_no"
        if [ "$isKillFilter" = "yes" ];then
        #ֹͣ�ּ����۳���
           #killProc "filter" "$filter_no" "$prov_code"
        #elif [ "$isKillFilter" = "no" ];then
        #  continue
        fi
        echo "here "
        #if [ "$isKillRate" = "yes" ] || [ "$isKillRate" = "y" ];then
           #killProc "rate" "$rate_no" "$proc_code"
        #elif [ "$isKillRate" = "no" ] || [ "$isKillRate" = "n" ];then
        #   continue
        #fi
        killProc "smsremind" "$smsremind_no" "$prov_code"
        #executeSQL "$biz_type" "$sql_wh" "$redoCycle" "$ORACONN@cbss_bildb_i${no}" "$prov_code"
       # bakupAltibase "${ALTI_IP}" "billing${no}" "${mon1}" "${mon2}" "$bak_date"
        #start_redo "$channel_no" "$prov_code"
        #startProc "filter" "$filter_no" "$prov_code"
        startProc "rate" "$rate_no" "$prov_code"
        #deleteOldFile "~/user/gucb/bak_altibase_0428"
        #deleteRedoFile "$channel_no"
        #������������
        #startProc "smsremind" "$smsremind_no" "$prov_code"
        echo "continue to here"

done<redo.s
