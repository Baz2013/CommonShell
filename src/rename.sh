#���ļ��е�����ǰ�߼�0,ʹĿ¼�µ������ļ���˳������,����:
#A6--TD_NUMBER_CONVERT.sql --> A06--TD_NUMBER_CONVERT.sql
#���߿���ͨ��һ������ʵ��
#ll |grep  'A[0-9]\{1\}--'|awk '{print $NF}'|xargs -n1|awk -F '-' '{printf("mv %s A0%s--%s \n",$0,substr($1,2),$NF)}'|xargs -i sh -c "{}"

ls A* >filenames

rename(){
  num=$(echo $1|awk -F"-" '{print $1}'|awk -F"A" '{print $2}')
  last_name=$(echo $1|awk -F"-" '{print $NF}')
 # echo $num
 # echo $last_name
  len=${#num}
  if [ ${#num} -ne "2" ];then
   re_num="0"$num
  newname="A"${re_num}"--"${last_name}
 # echo $newname
  mv $1 $newname
  fi
}

replace_dos(){
  tr -d '\015' < $1 > tmp.sql
  mv tmp.sql $1
}

while read line
do
replace_dos $line #ɾ���ļ��е�dos�ַ�
rename $line #������
done<filenames

ls A*|xargs cat > imp.sql

rm -f filenames
rm -f tmp.sql
