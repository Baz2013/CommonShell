###********说明********###
#Author gucb
#Version 1.0.2
#Last Update 2015-02-28 12:30
##使用方式
#1.在shell文件中直接引用(. path/gucb.common.func.sh)
#2.单行命令的方式使用文件中的自定义函数,使用前在当前shell窗口执行 . path/gucb.common.func.sh
#如解压文件的函数 extract ,去除dos字符的函数 delDos delDosAll等

. ~/user/gucb/common/ucr_conn
. ~/user/gucb/common/ucr_err_conn

######
#set -A arr_prov 0 11 70 79 38 30 87 10 34 75 88 90 83 85 59 31 86 19 50 89 17 18 34 84 51 36 81 76 91 13 71 97
set -A arr_prov 0 11 34 38 86 97 36 13 31 87 51 81 59 79 91 74 89 75 76 10 85 88 17 70 18 71 83 19 90 84 30 50
set -A str_prov 0 bj js fj yn hlj zj tj sh gs gd sc gx xz ln hun xj jx hen nm gz nx sd qh hb hub cq sx jl shx ah hn
##### 每个域省分的个数 
set -A arr_area 0 4 5 4 4 4 2 3 5

#### 自定义路径 
GUCB_LOG_DIR="/ngbss/billing5/user/gucb/log" #脚本日志文件路径

####输入目录
PP_DIR_76="${BOSS_DATA5}/pp_yw/src/it100/76_sj"
FILTER1_DIR_76="${BOSS_DATA5}/pp_yw/std/fixvoice/it100/"
FILTER2_DIR_76="${BOSS_DATA5}/filter/filter1/fixvoice/prov/it100/"
RR_DIR_76="${BOSS_DATA5}/filter2/it100"
RATE_DIR_76="${BOSS_DATA5}/rr/it100/"
INDB_DIR_76="${BOSS_DATA5}/rate/output/it100/"
PP_ERR_DIR_76="${BOSS_DATA5}/pp_yw/err/it100/fixvoice/"
FILTER1_ERR_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100" #一分错单输入目录
FILTER1_ERR_E_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100/indb_e"
FILTER1_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter1/fix/err/it100/indb_f"
FILTER1_TRASH_DIR_76="${BOSS_DATA5}/filter/filter1/fix/trash/it100" #一分trash单输入目录
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100" #无主错单输入目录
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100/indb_e"
NOINFO_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/noinfo/it100/indb_f"
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100" # 二分错单输入目录
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100/indb_e"
FILTER2_ERR_F_DIR_76="${BOSS_DATA5}/filter/filter2/fix/err/it100/indb_f"
RR_REPEAT_DIR_76="${BOSS_DATA5}/rr/repeat/it100 "
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100"
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100/indb_e"
RATE_ERR_F_DIR_76="${BOSS_DATA5}/rate/err/it100/indb_f"
INDB_BAK_76="${BOSS_DATA5}/rate/bak/it100"


####生成话单相关路径
SPOOL_SH_76="/ngbss/billing5/user/gucb/spool_cdr/filter_fix_gsm_spool.sh"
SELECT_COND_76="ucr_hen01.tg_cdr_fix_special_201407 where source_type not in ('9H','9L')"
LOG_NAME_76="run_program"
FILE_COUNT_76=3000 # 每个文件的条数 
BAK_MOVED_DATA_76="/ngbss/billing5/user/gucb/cdr_data/"

####各程序通道
CHANNEL_76="
filter#7100\n
filter#7110\n
rr#5100\n
rate#5100\n
indb#5100
"

####
BASE_CHECK_ERROR=67
#####数据库
BILL_UCR_76="ucr_hen01/ucr_hen01@40ngbill" ##清单库用户
BILL_UCR_ERR_76="ucr_err_hen01/ucr_err_hen01@40ngbill" ## 错单库用户 

#####备份的表
TB_FIX_76="tg_cdr08_fix"
TB_PP_FIX_76="tg_cdr_pp_err_fix"
TB_NOINFO_FIX_76="tg_cdr_noinfo_fix"
TB_RATE_FIX_76="tg_cdr_rate_err_fix"

##########test test #############
LIS_DIR="/ngbss/billing5/user/gucb/test"
LIS_WORK_DIR="/ngbss/billing5/user/gucb/work"


####公用函数
# $1 日志文件名 $2 日志内容
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


#执行SQL的函数 没有返回值
# $1 用户名/密码@库 $2 SQL语句
executesql(){
`sqlplus -S /nolog  << EOF
set heading off feedback off pagesize 0 verify off echo off
conn $1
$2
exit
EOF`
}

#执行SQL的函数 返回条数
# $1 用户名/密码@库 $2 SQL语句
executesql_1(){
  value=`sqlplus -S /nolog  << EOF
  set heading off feedback off pagesize 0 verify off echo off
  conn $1
  $2
  exit
  EOF`
echo "$value"
}

# 执行 sql 文件
#$1 文件路径  $2  文件名  $3 连接 
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

##删除指定目录下 N 天以前的文件 
# $1 目录 $2 N
del_oldfile(){
  eval path=$(echo "$1")
  #echo $path
  find ${path} -name "*" -mtime +${2} -exec rm {} 2>/dev/null \;
}

#启动程序函数
#$1 省分代码
start_program(){
 eval config=\$CHANNEL_${1}
  echo ${config}|while read line
  do
    name=$(echo $line|cut -d "#" -f 1)
    channel_no=$(echo $line|cut -d "#" -f 2)
    cd ~/bin
    ./${name} -c${channel_no} >/dev/null
    writeLog "run_program" "${name} -c${channel_no} 已启动"
  done
  exit 0
}

#杀掉进程函数
#$1 省分代码
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
       writeLog "run_program" "${name} -c${channel_no}已停止"
    else
       writeLog "run_program" "${name} -c${channel_no}未启动"
    fi
  done
  echo "0"
}


#自动启动进程，防止进程挂掉后不能进行后续工作
# $1 
auto_start(){
  echo "0"
}

## 文件解压 ,直接调用此函数,不必考虑使用什么解压命令
## 最好将此函数保存到.profile或者.bashrc中
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

##判断是否是闰年
##input year (如 2015)
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

###获取指定月份的天数 参数: $1 YYYYMM
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
##删除dos字符
delDos(){
  ##echo $#
  if [ $# -ne 1 ];then
    echo " Error !! 需要一个参数"
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
