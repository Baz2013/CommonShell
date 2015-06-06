#该脚本实现将模板文件中的字符串用参数文件中的字符串来替换,并输出到另一个指定文件中
#Author gucb
#Version 1.0.1 
#LAST UPDATE 2014.10.31

showUsage(){
  echo "echo $0 参数替换文件 模板文件 输出文件 "
  echo "如: sh $0 param_file aaaa bbbb "
  exit 0
}

replace(){
  #echo "$1"
  sed $1 <${replace_file}>>${output_file}
}

parse_field(){
  field_num=$(echo "${1}"|awk -F"," '{print NF}')
  #echo "field_num ${field_num}"
  i=1
  s_str=""
  while [ i -le "${field_num}" ]
  do
   str=$(echo "${1}"|awk -F"," '{print $v}' v="$i")
   str1=$(echo "${str}"|awk  -F"=" '{print $1}')
   str2=$(echo "${str}"|awk  -F"=" '{print $2}')

   #echo "${str1} : ${str2}"
   ##防止参数文件中存在"/"的情况,如果参数文件中存在"^"字符,可以将其替换为参数文件中不存在的特殊字符
   s_str=${s_str}"s^${str1}^${str2}^g;"
   let i=i+1
  done
   #echo "${s_str}"
   replace "${s_str}"
}

param_file=${1}
replace_file=${2}
output_file=${3}
>${output_file}  ## 清空输出文件

if [ $# -ne "3" ];then
  showUsage
fi

while read line
do
   parse_field "$line" 
done<${param_file}
