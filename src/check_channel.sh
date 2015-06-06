writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
printf "${cur_time}|$1|\n" >>~/user/gucb/log/check_channel.${log_name}
}

while true;do
while read line;do
  pro=$(echo $line|awk  '{print $1}')
  no=$(echo $line|awk '{print $2}')
 # echo "${pro} ${no}"
  no1=$(echo $no|sed "s/\-//g")
 # echo "${no1}"
  wc=$(ps -ef|grep ${pro}|grep `whoami`|grep ${no1}|wc -l)
  if [ $wc -eq 0 ];then
     writeLog "${line} ½ø³ÌÒÑÍ£Ö¹"
  fi
done < all_channels
sleep 30
done
