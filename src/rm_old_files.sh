set -A arr 0 4 5 4 4 4 2 3 5
no=$(whoami|cut -c8)
mons="02 03 04 05"

writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/log/rmfile.${log_name}
}

delete_file(){
#while read line; do
cd $1;
for mon in ${mons}
do
i=1
#mon=02
end=$((`cal $mon 2014|xargs |awk '{print NF}'`-9))
while [ $i -lt `expr $end + 1` ]; do
        if [ $i -lt 10 ];then
          j=0${i}
        else
          j=${i}
        fi
        k=0
        while [ $k -lt 24 ];do
        if [ $k -lt 10 ];then
           h=0${k}
        else
           h=${k}
        fi
        file1=2014${mon}${j}${h}
        rm *${file1}* 2>/dev/null
        writeLog "$1 下的文件 *${file1}* 已删除"
        #echo "rm *${file1}*" >>~/user/gucb/public/a.txt
        ((k=k+1))
        done
((i=i+1))
done
done
#done <path
}

m=1
while [ m -le "${arr[no]}" ]
do
#delete_file "$HOME/billdata/filter2_yw/srcbak/gsm_imei/it${m}00/"
delete_file "$BOSS_DATA1/filter2_yw/srcbak/gsm_imei/it${m}00/"
((m=m+1))
done
