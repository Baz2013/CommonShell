#����������Ҫ�Զ������Ľ���,ע�⻻�з�(���һ�в���Ҫ���з�)
config="
rate#1100\n
rate#1200
"
#д��־
writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/log/auto_start.${log_name}
}

check_channel(){
name=$1
channel_no=$2
count=$(ps -ef|grep "${name}"|grep `whoami`|grep "c${channel_no}"|wc -l)
#echo "-----------count : $count"
if [ ${count} -eq 0 ];then
cd ~/bin
./${name} -c${channel_no} >/dev/null
writeLog "${name} -c${channel_no} ���� auto_start.sh �ű�����"
fi
}

while true;
do
  echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    check_channel "$name" "$channel_no"
  done
sleep 60
done
