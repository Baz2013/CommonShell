. ~/user/gucb/common/gucb.common.func.sh

eval f1_path=\$FILTER1_DIR_${1}
eval f2_path=\$FILTER2_DIR_${1}
eval rr_path=\$RR_DIR_${1}
eval rate_path=\$RATE_DIR_${1}
eval indb_path=\$INDB_DIR_${1}
eval bak_path=\$BAK_MOVED_DATA_${1}
eval log_name=\$LOG_NAME_${1}

#��������ͨ����·���Ƿ����ú�
#$1 prov_code
base_check(){
  eval log_name=\$LOG_NAME_${1}
  #echo "${1}"
  eval channel=\$CHANNEL_${1}
  
  #echo "${f1_path}\n${f2_path}\n${rr_path}\\n${rate_path}\n${indb_path}"
  if [ ! -n "${channel}" -o ! -n "${f1_path}" -o ! -n "${f2_path}" -o ! -n "${rr_path}" -o ! -n "${rate_path}" -o ! -n "${indb_path}" ];then
    echo "ERROR: ͨ���Ż�������·��δ���� !!"
    exit BASE_CHECK_ERROR
  fi
}

split_file(){
  eval ct=\$FILE_COUNT_${1}
  cd $2
  file=${3}
  sed 's/^72,/71,/g' < $file >_tmp #�滻����Դ�ֶ�
  rm $file
  mv _tmp $file
  split -l ${ct} -a 4 $file tmp_
  mkdir -p splitbak
  mv $file splitbak
  ls tmp_*|awk '{printf("mv %s %s%04s\n", $0,f, NR)}' f="$file" > mv.sh
  sh mv.sh
  rm mv.sh
  writeLog "${log_name}" "�ļ��ѱ��ָ�� ${ct} ��һ�� "
}

get_cdr(){
  eval spool_sh=\$SPOOL_SH_${1}
  eval log_name=\$LOG_NAME_${1}
  eval select_cond=\$SELECT_COND_${1}
  #echo $spool_sh
  spool_path=$(dirname ${spool_sh})
  sh=$(basename ${spool_sh})
  cd ${spool_path}
  cdr_file=$(grep 'spool \/' ${sh}|awk '{print $2}')
  cdr_path=$(dirname ${cdr_file}) #����·��
  cdr_name=$(basename ${cdr_file})
  cur_time=$(date +"%Y%m%d%H%M")
  cur_filename=${cur_time}"_ucr_${1}.txt" #���ɻ������ļ��� 
  sed "s/${cdr_name}/${cur_filename}/g;s/COND_AAAA/${select_cond}/g" < ${sh} >tmp.sh
  #cd ${cdr_path}
  #rm * 2>/null #���ɻ���ǰȷ������Ŀ¼��û�������ļ� 
  #cd -
  chmod 775 tmp.sh
  ./tmp.sh
  rm tmp.sh
  writeLog "${log_name}" "����${cdr_path}/${cur_filename}������"
  #�ָ��
  split_file "${1}" "${cdr_path}" "${cur_filename}" 
  #echo $cdr_file
}

mv_files(){
  cd $1
  ls -l |grep '^-'|awk '{print $9}'|xargs -i sh -c "mv {} $2"
  cd -
}

clean_input_dir(){
  echo "${bak_path}"
  eval log_name=\$LOG_NAME_${1}
  
  cur_time=$(date +"%Y%m%d%H%M")
  tmp_dir=${cur_time}"_mved"
  cd ${bak_path}
  mkdir -p ${tmp_dir}
  for path in ${f1_path} ${f2_path} ${rr_path} ${rate_path} ${rate_path} ${indb_path}
  do
    mv_files "${path}" "${bak_path}/${tmp_dir}"  
    #echo "${path}"
  done
  cd ${bak_path}
  zip -r ${tmp_dir}\.zip ${tmp_dir}
  rm -r ${tmp_dir}
  writeLog "${log_name}" "����Ŀ¼�µĲ����ļ��ѱ�����"
}

mv_cdr(){
  eval spool_sh=\$SPOOL_SH_${1}
  eval log_name=\$LOG_NAME_${1}
  spool_path=$(dirname ${spool_sh})
  sh=$(basename ${spool_sh})
  cd ${spool_path}
  cdr_file=$(grep 'spool \/' ${sh}|awk '{print $2}')

  cdr_path=$(dirname ${cdr_file}) #����·��
  cd ${f1_path}

  mv ${cdr_path}/201* .
  writeLog "${log_name}" "�ļ����ƶ���һ������Ŀ¼ ${f1_path} �� "
}

# ͨ���ж�����·���µĻ���������ȷ�������Ƿ�����
check_count_1(){
  eval log_name=\$LOG_NAME_${1}
ct=1000
while [ "${ct}" -gt "0" ]
do
sleep 4
sum=0
for path in ${f1_path} ${f2_path} ${rr_path} ${rate_path} ${rate_path} ${indb_path}
do 
  s=$(ls -l ${path}|grep '^-'|wc -l)
  #echo "$s"
  ((sum=${sum}+${s}))
done
ct=${sum}
#echo "$ct"
echo "${log_name}"
writeLog "${log_name}" "��������Ŀ¼�µ��ļ����� ${ct}"
done
echo "${log_name}"
writeLog "${log_name}" "�����ļ��Ѵ����� "
#echo "0"
}

base_check "$1" #����������
#kill_program "$1" #
#get_cdr "$1" #
#clean_input_dir "$1"  #������������Ŀ¼�µĲ����ļ�
#mv_cdr "$1"
#start_program "$1" #
#check_count_1 "$1"
