awk -F"=" '{a[$2]}END{for (i in a) {print a[i]" "i}}' rule_data.txt >tmp_num.txt

gern_rule(){
  echo "
IF(${2})
THEN
     RULE_2:tmp_bj_flag3=1
ENDIF
IF((tmp_bj_flag3=1)AND(home_area_code=0396))
THEN
    RULE_2:CalledNum=${1}
ENDIF
" >> rule.cfg  
}
while read line
do
  echo "===========$line"
    str=""
  while read line1
  do
    num1=$(echo $line1|awk -F"=" '{print $1}')
    num2=$(echo $line1|awk -F"=" '{print $2}')
    if [ $num2 -eq $line ];then
      str="(term_nbr=${num1})OR${str}"
      #echo "$num1 "
    fi
  done<rule_data.txt
  echo "$str"
  gern_rule "$line" "$str"
done<tmp_num.txt

sed "s/)OR)/))/g" rule.cfg > rule1.cfg
