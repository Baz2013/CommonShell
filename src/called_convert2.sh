#���ɱ��к���ת���������ļ�

flag=1

# $1 callednumber  $2 convert number $3 file_no
get_rule(){
 #echo "0"
 echo "
IF(term_nbr=${1})
THEN
    RULE_2:tmp_bj04_flag${flag}=1
ENDIF
IF((tmp_bj_flag${flag}=1)AND(home_area_code=0379)AND(fileno_pre21=${3}))
THEN
    RULE_2:CalledNum=${2}
ENDIF" >>covert_rule2.cfg
let flag=flag+1
}

>covert_rule2.cfg # ÿ������������ļ� 
while read line
do
  calledno=$(echo $line|awk -F, '{print $1}')
  convertno=$(echo $line|awk -F, '{print $2}')
  fileno=$(echo $line|awk -F, '{print $3}')
  
  get_rule "$calledno" "$convertno" "$fileno"
done<convert_data
