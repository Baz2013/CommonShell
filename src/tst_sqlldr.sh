##功能 : 截取 GPP* 话单的关键字段输出到文件,然后将该文件用sqlldr入库

writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
printf "${cur_time}|$1|\n" >>$2/gs_ldr.${log_name}
}

if [ ! -d ${1} ];then
  echo "路径 ${1} 不存在 " 
  exit
fi

cd $1
> gs_ldr.dat
ls GPP*|xargs awk -F"," '{printf("%s,%s,%s,%s,%s,%s,%s,%s\n",$3,$61,$7,$31,$32,$33,$37,$38)}' >>gs_ldr.dat
a=$(ls GPP*|xargs cat|wc -l|awk '{print $1}')
b=$(wc -l gs_ldr.dat|awk '{print $1}')
echo "$a , $b "
if [ ${a} -eq ${b} ];then
  writeLog "文件核对一致,现在开始入库" "${1}"
else
  writeLog "文件核对不一致,脚本退出!!!" "${1}"
  exit
fi

echo "load data
infile \"$1/gs_ldr\" 
append into table TEST_CDR03_GS_FLOW
fields terminated by \",\" TRAILING NULLCOLS
(
rr_fid     ,
user_id    ,
msisdn     ,
begin_date ,    
begin_time ,
duration   ,
data_up1   ,
data_down1 
)" >gs_ldr.ctl

sqlldr ucr_bj01/ucr_bj01@40ngbill control=gs_ldr.ctl rows=10000 bindsize=33554432

