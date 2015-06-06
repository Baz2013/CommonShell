#!/bin/sh
#该脚本实现了自动生成话单并分割话单，自动清理各目录下的残留话单，然后将生成的话单放到一分的
#输入目录下，备份话单，最后启动相应的程序

#配置
config="
filter#502\n
filter#503\n
rate#504\n
indb#505
"
filter1_dir="${BOSS_DATA6}/filter/input/fixgsm/henit100" #一次分拣输入目录
spool_sh_dir="/ngbss/billing6/user/gucb/spool_cdr" #话单导出脚本输入路径
spool_file="filter_fix_gsm_spool.sh" #生成话单脚本的文件名
g_select_cond="ucr_hen01.tg_cdr07_fix_in where source_type not in ('9H','9L')" #生成话单的表和条件
db_user="ucr_hen01/ucr_hen01@40ngbill" #清单库用户名密码

writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/log/run_program.${log_name}
}

#先停掉所有的分拣、批价、入库程序
kill_program(){
  echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    pid=$(ps -ef|grep "${name}"|grep `whoami`|grep "c${channel_no}"|awk '{print $2}')
    if [ -n ${pid} ];then
       kill $pid
       writeLog "${name} -c${channel_no}已停止"
    else
       writeLog "${name} -c${channel_no}未启动"
    fi
  done
}

#生成所需话单
get_cdr(){
  cd ${spool_sh_dir}
  cur_time=$(date +"%Y%m%d%H%M")
  cdr_filename=${cur_time}"_ucr_hen.txt"
  sed "s/aaaaaaaatxt/${cdr_filename}/g;s/COND_AAAA/${g_select_cond}/g" < ${spool_file} >tmp.sh
  chmod 775 tmp.sh
  ./tmp.sh
  rm tmp.sh
  writeLog "话单${spool_sh_dir}/${cdr_filename}已生成"
  echo "${cdr_filename}" #将生成的文件名返回
}

split_file(){
  cd ${spool_sh_dir}
  path=$(grep 'spool \/' ${spool_file}|awk '{print $2}') #获取生成文件的路径
  dir_name=$(dirname $path)
  cd ${dir_name}
  file=${1}
  sed 's/^72,/71,/g' < $file >_tmp #替换数据源字段
  rm $file
  mv _tmp $file
  split -l 3000 -a 4 $file tmp_
  mkdir -p splitbak
  mv $file splitbak
  ls tmp_*|awk '{printf("mv %s %s%04s\n", $0,f, NR)}' f="$file" > mv.sh
  sh mv.sh
  rm mv.sh
  writeLog "文件已被分割成3000条一个"
}

clean_input_dir(){
cd ~/user/gucb
sh rm_files.sh
writeLog "所有目录下的残余文件已被清理"
}

mv_cdr(){
cd ${spool_sh_dir}
path=$(grep 'spool \/' ${spool_file}|awk '{print $2}') #获取生成文件的路径
dir_name=$(dirname $path)
cd ${filter1_dir}
mv ${dir_name}/${1}* .
writeLog "文件已移动到一分输入目录下"
}

bak_table(){
cd ~/user/gucb/sql
#echo "${1}"
sed "s/table_name/${1}/g" < bak_cdr_fix.sql >tmp.sql
sqlplus -s $2 << EOF
set heading off wrap on numwidth 30 linesize 5000 feedback off
@tmp.sql
disconnect
exit
EOF
rm tmp.sql
}

bak_del_tg_cdr(){
cur_time=$(date +"%m%d%H%M")
table_name="bak${cur_time}_tg_cdr07_fix"
writeLog "备份的表名为 ${table_name}"
#bak_sql=$(echo "create table ${tabel_name} as select \052 from tg_cdr07_fix;delete from tg_cdr07_fix;")
echo $table_name
bak_table  "${table_name}" "${db_user}"
writeLog "备份完成"
}

start_program(){
echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    cd ~/bin
    ./${name} -c${channel_no} >/dev/null
    writeLog "${name} -c${channel_no} 已启动"
  done
 exit 0
} 

kill_program #杀掉已启动的进程
file_name=$(get_cdr) #
split_file "${file_name}" #分割文件
clean_input_dir #清理所有输入目录下的残留文件
mv_cdr "${file_name}"  #将分割后的话单文件放置到一分输入目录下
bak_del_tg_cdr   #备份删除详单表
start_program #启动相应的程序
