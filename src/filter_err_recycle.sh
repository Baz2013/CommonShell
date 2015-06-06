if [ $# -ne "4" ];then
  echo "使用方法: sh  filter_err_recycle.sh 回收通道号 省分编码 业务类型 where条件"
  echo "例如:sh  filter_err_recycle.sh 8310 84 3 \"user_id in (''123'',''456'')\" "
  exit
fi

. $HOME/user/gucb/common/gucb.common.func.sh

channel_no=$1
prov_code=$2
biz_type=$3
sql_wh=$4
no=$(whoami|cut -c8)
no1=$(echo "$1"|cut -c2)
bak_date=$(date +%m%d%H)

if [ $3 -eq "1" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/1/g;s/_GS//g" < ~/user/gucb/recycle/sql/template_filter_yy.sql > tmp_filter.sql
  filter_no=${no}${no1}00
elif [ $3 -eq "3" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/3/g;s/_GS/_GS/g" < ~/user/gucb/recycle/sql/template_filter_yy.sql >tmp_filter.sql
  filter_no=${no}${no1}10
elif [ $3 -eq "2" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/2/g;s/_GS/_SM/g" < ~/user/gucb/recycle/sql/template_filter_yy.sql >tmp_filter.sql
  filter_no=${no}${no1}20
elif [ $3 -eq "8" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/8/g;s/_GS/_SP/g" < ~/user/gucb/recycle/sql/template_filter_yy.sql >tmp_filter.sql
  filter_no=${no}${no1}30
fi

#echo "$filter_no"
echo "是否停掉一分进程 filter -c${filter_no} (y/n)"
read answer
if [ "${answer}" = "yes" ] || [ "${answer}" = "y" ];then
  ps -ef|grep filter|grep "c${filter_no}"|awk '{print $2}'|xargs -n1 kill
  echo "正在停止分拣进程"
  sleep 3
  check=$(ps -ef|grep filter|grep "c${filter_no}"|wc -l)
  if [ $check -eq "1" ];then
     echo "该分拣进程可能挂死"
  fi
fi  

eval ORACONN=\$ORACONN_UCR_ERR_${prov_code}
nohup sqlplus $ORACONN@cbss_bildb_i${no} @./tmp_filter.sql > insert.log &
