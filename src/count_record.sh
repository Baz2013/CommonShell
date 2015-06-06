writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
printf "${cur_time}|$1|\n" >>~/user/gucb/log/count_record.${log_name}
}

while true
do
c0=$(ls ~/billdata/rr/it400|wc -l)
c1=$(ls ~/billdata/rr/it401|wc -l)
c2=$(ls ~/billdata/rr/it402|wc -l)
c3=$(ls ~/billdata/rr/it403|wc -l)
c4=$(ls ~/billdata/rr/it404|wc -l)

let a=c0+c1+c2+c3+c4
writeLog "上海批价输入目录下的所有文件数是 ${a}"
sleep 120
done
