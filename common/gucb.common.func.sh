###********˵��********###
#Author gucb
#Version 1.0.2
#Last Update 2015-02-28 12:30
##ʹ�÷�ʽ
#1.��shell�ļ���ֱ������(. path/gucb.common.func.sh)
#2.��������ķ�ʽʹ���ļ��е��Զ��庯��,ʹ��ǰ�ڵ�ǰshell����ִ�� . path/gucb.common.func.sh
#���ѹ�ļ��ĺ��� extract ,ȥ��dos�ַ��ĺ��� delDos delDosAll��

. ~/user/gucb/common/ucr_conn
. ~/user/gucb/common/ucr_err_conn

######
#set -A arr_prov 0 11 70 79 38 30 87 10 34 75 88 90 83 85 59 31 86 19 50 89 17 18 34 84 51 36 81 76 91 13 71 97
set -A arr_prov 0 11 34 38 86 97 36 13 31 87 51 81 59 79 91 74 89 75 76 10 85 88 17 70 18 71 83 19 90 84 30 50
set -A str_prov 0 bj js fj yn hlj zj tj sh gs gd sc gx xz ln hun xj jx hen nm gz nx sd qh hb hub cq sx jl shx ah hn
##### ÿ����ʡ�ֵĸ��� 
set -A arr_area 0 4 5 4 4 4 2 3 5

#### �Զ���·�� 
GUCB_LOG_DIR="/ngbss/billing5/user/gucb/log" #�ű���־�ļ�·��

####����Ŀ¼
PP_DIR_76="${BOSS_DATA5}/pp_yw/src/it100/76_sj"
FILTER1_DIR_76="${BOSS_DATA5}/pp_yw/std/fixvoice/it100/"
FILTER2_DIR_76="${BOSS_DATA5}/filter/filter1/fixvoice/prov/it100/"
RR_DIR_76="${BOSS_DATA5}/filter2/it100"
RATE_DIR_76="${BOSS_DATA5}/rr/it100/"
INDB_DIR_76="${BOSS_DATA5}/rate/output/it100/"
PP_ERR_DIR_76="${BOSS_DATA5}/pp_yw/err/it100/fixvoice/"
FILTER1_ERR_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100" #һ�ִ�����Ŀ¼
FILTER1_ERR_E_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100/indb_e"
FILTER1_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100/indb_f"
FILTER1_TRASH_DIR_76="${BOSS_DATA5}/filter/filter1/fix/trash/it100" #һ��trash������Ŀ¼
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100" #����������Ŀ¼
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100/indb_e"
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100/indb_f"
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100" # ���ִ�����Ŀ¼
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100/indb_e"
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100/indb_f"
RR_REPEAT_DIR_76="${BOSS_DATA5}/rr/repeat/it100 "
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100"
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100/indb_e"
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100/indb_f"
INDB_BAK_76="${BOSS_DATA5}/rate/bak/it100"


####���ɻ������·��
SPOOL_SH_76="/ngbss/billing5/user/gucb/spool_cdr/filter_fix_gsm_spool.sh"
SELECT_COND_76="ucr_hen01.tg_cdr_fix_special_201407 where source_type not in ('9H','9L')"
LOG_NAME_76="run_program"
FILE_COUNT_76=3000 # ÿ���ļ������� 
BAK_MOVED_DATA_76="/ngbss/billing5/user/gucb/cdr_data/"

####������ͨ��
CHANNEL_76="
filter#7100\n
filter#7110\n
rr#5100\n
rate#5100\n
indb#5100
"

####
BASE_CHECK_ERROR=67
#####���ݿ�
BILL_UCR_76="ucr_hen01/ucr_hen01@40ngbill" ##�嵥���û�
BILL_UCR_ERR_76="ucr_err_hen01/ucr_err_hen01@40ngbill" ## �����û� 

#####���ݵı�
TB_FIX_76="tg_cdr08_fix"
TB_PP_FIX_76="tg_cdr_pp_err_fix"
TB_NOINFO_FIX_76="tg_cdr_noinfo_fix"
TB_RATE_FIX_76="tg_cdr_rate_err_fix"

##########test test #############
LIS_DIR="/ngbss/billing5/user/gucb/test"
LIS_WORK_DIR="/ngbss/billing5/user/gucb/work"


####���ú���
# $1 ��־�ļ��� $2 ��־����
writeLog(){
 cur_time=$(date +"%Y-%m-%d %H:%M:%S")
 cur_date=$(date +"%Y%m%d")
 log=${cur_date}"".log
 echo "${cur_time}|$2" >> ${GUCB_LOG_DIR}/${1}.${log}
}

# $1 min_value $2 max_value
random(){
  min=$1
  max=$2-$1
  #num=$(date +%s+%N)
  num=$(echo $RANDOM)
  ((retnum=num%max+min))
  echo $retnum
} 


#ִ��SQL�ĺ��� û�з���ֵ
# $1 �û���/����@�� $2 SQL���
executesql(){
`sqlplus -S /nolog  << EOF
set heading off feedback off pagesize 0 verify off echo off
conn $1
$2
exit
EOF`
}

#ִ��SQL�ĺ��� ��������
# $1 �û���/����@�� $2 SQL���
executesql_1(){
  value=`sqlplus -S /nolog  << EOF
  set heading off feedback off pagesize 0 verify off echo off
  conn $1
  $2
  exit
  EOF`
echo "$value"
}

# ִ�� sql �ļ�
#$1 �ļ�·��  $2  �ļ���  $3 ���� 
executesqlfile(){
  echo "0"
  pre_path=$(pwd)
  cd $1
  `sqlplus -S /nolog  << EOF
  set heading off feedback off pagesize 0 verify off echo off
  conn $3
  @$2
  exit
  EOF`
  cd ${pre_path}
}

##ɾ��ָ��Ŀ¼�� N ����ǰ���ļ� 
# $1 Ŀ¼ $2 N
del_oldfile(){
  eval path=$(echo "$1")
  #echo $path
  find ${path} -name "*" -mtime +${2} -exec rm {} 2>/dev/null \;
}

#����������
#$1 ʡ�ִ���
start_program(){
 eval config=\$CHANNEL_${1}
  echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    cd ~/bin
    ./${name} -c${channel_no} >/dev/null
    writeLog "run_program" "${name} -c${channel_no} ������"
  done
  exit 0
}

#ɱ�����̺���
#$1 ʡ�ִ���
kill_program(){
 eval config=\$CHANNEL_${1}
 echo "${config}"
 echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    pid=$(ps -ef|grep "${name}"|grep `whoami`|grep "c${channel_no}"|awk '{print $2}')
    if [ -n ${pid} ];then
       kill $pid
       writeLog "run_program" "${name} -c${channel_no}��ֹͣ"
    else
       writeLog "run_program" "${name} -c${channel_no}δ����"
    fi
  done
  echo "0"
}


#�Զ��������̣���ֹ���̹ҵ����ܽ��к�������
# $1 
auto_start(){
  echo "0"
}

## �ļ���ѹ ,ֱ�ӵ��ô˺���,���ؿ���ʹ��ʲô��ѹ����
## ��ý��˺������浽.profile����.bashrc��
extract() {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

##�ж��Ƿ�������
##input year (�� 2015)
##output "true" "false"

is_leap(){
  Y=$(expr substr $1 1 4)

  r1=$(echo "${Y}%4"|bc)
  r2=$(echo "${Y}%100"|bc)
  r3=$(echo "${Y}%400"|bc)

  if [ ${r1} -eq "0" -a ${r2} -ne "0" -o "${r3}" -eq "0" ];then
    leap="true"
  else
    leap="false"
  fi

 echo "${leap}"
}

###��ȡָ���·ݵ����� ����: $1 YYYYMM
get_mon_days(){
  Y=$(expr substr $1 1 4)
  M=$(expr substr $1 5 2)

  case ${M} in
     01|03|05|07|08|10|12) days=31;;
     04|06|09|11) days=30;;
     02) 
     isleap=$(is_leap "${Y}")
     if [ "${isleap}" = "true" ];then
       days=29
     else
       days=28
     fi
     ;;
     *) days=0;;
  esac

  echo "${days}"
}

###-----test ------
##ɾ��dos�ַ�
delDos(){
  ##echo $#
  if [ $# -ne 1 ];then
    echo " Error !! ��Ҫһ������"
  else
    tr -d '\015' < $1 >tmp
    mv tmp $1
  fi
}

delDosAll(){
  files=$(ls -F|grep -v '\/')
  for f in $files
  do
    #echo $f
    delDos $f
  done
}
