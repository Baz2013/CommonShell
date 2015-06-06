flag1=1
flag2=1
get_rule(){
  called_count=$(echo $2|awk 'BEGIN{FS="/"; i=0;} {i=i+NF} END{print i;}')
  file_count=$(echo $3|awk 'BEGIN{FS="/"; i=0;} {i=i+NF} END{print i;}')
  echo "$called_count $file_count"
  i=1
  str1=""
  if [ $called_count -eq 1 ];then
    len=$(expr length ${2})
    str1="term_nbr${len}=${2}"
  elif [ $called_count -gt 1 ];then
  while [ $i -le $called_count ]
  do
    num1=$(echo $2|awk -F"/" '{print $v}' v="$i")
    len=$(expr length $num1)
    str1="(term_nbr${len}=${num1})OR${str1}"
    let i=i+1
  done
  fi

  j=1
  str2=""
  if [ $file_count -eq 1 ];then
    str2="fileno_pre21=${3}"
  elif [ $file_count -gt 1 ];then
  while [ $j -le $file_count ]
  do
    num2=$(echo $3|awk -F"/" '{print $v}' v="$j")
    str2="(fileno_pre21=${num2})OR${str2}"
    let j=j+1
  done
  fi

  #echo "$str1"
  #echo "$str2"
  echo "
IF(${str1})
THEN
    RULE_2:tmp_bj05_flag${flag1}=1
ENDIF
IF(${str2})
THEN
    RULE_2:tmp_file_flag${flag2}=1
ENDIF
IF((tmp_bj_flag${flag1}=1)AND(home_area_code=${1})AND(tmp_file_flag${flag2}=1))
THEN
    RULE_2:CALL_TYPE=FF,ERROR_CODE=570
ENDIF " >>called_filter2.cfg
let flag1=flag1+1
let flag2=flag2+1
}

>called_filter2.cfg
while read line
do
  calledno=$(echo $line|awk -F, '{print $1}')
  convertno=$(echo $line|awk -F, '{print $2}')
  fileno=$(echo $line|awk -F, '{print $3}')
  
 get_rule "$calledno" "$convertno" "$fileno"
 #echo "$calledno $convertno $fileno"
done<filter_data

sed "s/)OR)/))/g" < called_filter2.cfg > called_filter2.cfg2
