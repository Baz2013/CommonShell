##脚本功能,统计每个域下边各个省的用户数量
#Author gucb
#Version 1.0.0 
#LAST UPDATE 2015.01.14

. ./common/gucb.common.func.sh

conn="ubak/ubak_123@39ngact"
OFS=","

count(){
year=$(date "+%Y")
month=$(date "+%m")
day=$(date "+%d")

i=1
n=1

fileName="${year}${month}${day}.data"

while [  "${i}" -lt "${#arr_area[@]}" ]
do
  #echo "${i} ${arr_area[i]}"
  j=1
  while [ "${j}" -le "${arr_area[i]}" ]
  do
    #echo "${i} ${j} ${arr_prov[n]}"
    sql="SELECT COUNT(*) from ucr_act${i}.tf_f_user@toact${i} WHERE province_code = '${arr_prov[n]}' AND net_type_code = '50';"
    sql1="SELECT COUNT(*) from ucr_act${i}.tf_f_user@toact${i} WHERE province_code = '${arr_prov[n]}' AND (net_type_code = '30' OR net_type_code = '40');"
    count=$(executesql_1 "${conn}" "${sql}")
    count1=$(executesql_1 "${conn}" "${sql1}")
    count=$(echo "${count}"|awk '{print $NF}')
    count1=$(echo "${count1}"|awk '{print $NF}')
    echo "${year}${month}${day}${OFS}${i}${OFS}${arr_prov[n]}${OFS}0${OFS}${count}" >>${fileName}
    echo "${year}${month}${day}${OFS}${i}${OFS}${arr_prov[n]}${OFS}1${OFS}${count1}" >>${fileName}

    let j=j+1
    let n=n+1
  done 
  ((i+=1))
done
}

###start
count
