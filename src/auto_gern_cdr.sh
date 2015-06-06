#!/bin/sh
#�ýű�ʵ�����Զ����ɻ������ָ�����Զ������Ŀ¼�µĲ���������Ȼ�����ɵĻ����ŵ�һ�ֵ�
#����Ŀ¼�£����ݻ��������������Ӧ�ĳ���

#����
config="
filter#502\n
filter#503\n
rate#504\n
indb#505
"
filter1_dir="${BOSS_DATA6}/filter/input/fixgsm/henit100" #һ�ηּ�����Ŀ¼
spool_sh_dir="/ngbss/billing6/user/gucb/spool_cdr" #���������ű�����·��
spool_file="filter_fix_gsm_spool.sh" #���ɻ����ű����ļ���
g_select_cond="ucr_hen01.tg_cdr07_fix_in where source_type not in ('9H','9L')" #���ɻ����ı������
db_user="ucr_hen01/ucr_hen01@40ngbill" #�嵥���û�������

writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/log/run_program.${log_name}
}

#��ͣ�����еķּ����ۡ�������
kill_program(){
  echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    pid=$(ps -ef|grep "${name}"|grep `whoami`|grep "c${channel_no}"|awk '{print $2}')
    if [ -n ${pid} ];then
       kill $pid
       writeLog "${name} -c${channel_no}��ֹͣ"
    else
       writeLog "${name} -c${channel_no}δ����"
    fi
  done
}

#�������軰��
get_cdr(){
  cd ${spool_sh_dir}
  cur_time=$(date +"%Y%m%d%H%M")
  cdr_filename=${cur_time}"_ucr_hen.txt"
  sed "s/aaaaaaaatxt/${cdr_filename}/g;s/COND_AAAA/${g_select_cond}/g" < ${spool_file} >tmp.sh
  chmod 775 tmp.sh
  ./tmp.sh
  rm tmp.sh
  writeLog "����${spool_sh_dir}/${cdr_filename}������"
  echo "${cdr_filename}" #�����ɵ��ļ�������
}

split_file(){
  cd ${spool_sh_dir}
  path=$(grep 'spool \/' ${spool_file}|awk '{print $2}') #��ȡ�����ļ���·��
  dir_name=$(dirname $path)
  cd ${dir_name}
  file=${1}
  sed 's/^72,/71,/g' < $file >_tmp #�滻����Դ�ֶ�
  rm $file
  mv _tmp $file
  split -l 3000 -a 4 $file tmp_
  mkdir -p splitbak
  mv $file splitbak
  ls tmp_*|awk '{printf("mv %s %s%04s\n", $0,f, NR)}' f="$file" > mv.sh
  sh mv.sh
  rm mv.sh
  writeLog "�ļ��ѱ��ָ��3000��һ��"
}

clean_input_dir(){
cd ~/user/gucb
sh rm_files.sh
writeLog "����Ŀ¼�µĲ����ļ��ѱ�����"
}

mv_cdr(){
cd ${spool_sh_dir}
path=$(grep 'spool \/' ${spool_file}|awk '{print $2}') #��ȡ�����ļ���·��
dir_name=$(dirname $path)
cd ${filter1_dir}
mv ${dir_name}/${1}* .
writeLog "�ļ����ƶ���һ������Ŀ¼��"
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
writeLog "���ݵı���Ϊ ${table_name}"
#bak_sql=$(echo "create table ${tabel_name} as select \052 from tg_cdr07_fix;delete from tg_cdr07_fix;")
echo $table_name
bak_table  "${table_name}" "${db_user}"
writeLog "�������"
}

start_program(){
echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    cd ~/bin
    ./${name} -c${channel_no} >/dev/null
    writeLog "${name} -c${channel_no} ������"
  done
 exit 0
} 

kill_program #ɱ���������Ľ���
file_name=$(get_cdr) #
split_file "${file_name}" #�ָ��ļ�
clean_input_dir #������������Ŀ¼�µĲ����ļ�
mv_cdr "${file_name}"  #���ָ��Ļ����ļ����õ�һ������Ŀ¼��
bak_del_tg_cdr   #����ɾ���굥��
start_program #������Ӧ�ĳ���
