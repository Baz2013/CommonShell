#�ýű�ʵ�ִ����ݿ�ͳ�Ƹ�ʡ��ÿ�յĻ�����
#Author gucb
#Version 1.0.0 
#LAST UPDATE 2015.01.13

. ./common/gucb.common.func.sh

set -A day 01 02 03 04 05 06 07 08 09 10 11 

set -A user 01 02 03 04 05 06 07 08 09 10

set -A biz _gs _sm _sp

set -A multi_dbuser bj hb hub hen hun gd  ##���ڴ����嵥����û���ʡ��,�������Ļ�ֱ���ڴ����

#set -A area1 bj js fj yn
set -A area1 js fj yn

month="01" #��ѯ���·�

area_no="1"

conn="ubak/ubak_123@39ngact"

#�����ݿ��û���
count(){
for u in ${user[*]}
do
#echo $u
  for d in ${day[*]}
  do
    sql="select count(1) from ucr_${2}${u}.${1}@tobildb${3} WHERE Partition_id = '${d}';"
    c1=`executesql_1 "$conn" "$sql"`
    c1=$(echo ${c1}|awk '{print $NF}')
    #echo "$u $d"
    echo "$2,$u,$1,$d,${c1}" >>${2}_count.data
  done
done
}

##δ�����ݿ��û������ 
count_1(){
#echo $u
  for d in ${day[*]}
  do
    sql="select count(1) from ucr_${2}01.${1}@tobildb${3} WHERE Partition_id = '${d}';"
    c1=`executesql_1 "$conn" "$sql"`
    #echo "$u $d"
    c1=$(echo ${c1}|awk '{print $NF}')
    echo "$2,01,$1,$d,${c1}" >>${2}_count.data
  done
}

check(){
  #echo "${1}"
  m="0"
  for u in ${multi_dbuser[*]}
  do
   if [ "${1}" = "${u}" ];then
     m="1"
   fi
  done
 echo "${m}"
}

#count "tg_cdr01" "bj"
#count "tg_cdr01_gs" "bj"
#count "tg_cdr01_sm" "bj"
#count "tg_cdr01_sp" "bj"

###�ű���ʼ
for a in ${area1[*]}
do 
  ismultiuser=$(check "${a}")
  if [ ${ismultiuser} -eq "1" ];then
  count "tg_cdr${month}" "${a}" "${area_no}"
  count "tg_cdr${month}_gs" "${a}" "${area_no}"
  count "tg_cdr${month}_sm" "${a}" "${area_no}"
  count "tg_cdr${month}_sp" "${a}" "${area_no}"
  #echo "is multiuser "
  else
  count_1 "tg_cdr${month}" "${a}" "${area_no}"
  count_1 "tg_cdr${month}_gs" "${a}" "${area_no}"
  count_1 "tg_cdr${month}_sm" "${a}" "${area_no}"
  count_1 "tg_cdr${month}_sp" "${a}" "${area_no}"
  #echo "is not multiuser"
 fi
done
