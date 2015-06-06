. $HOME/user/gucb/common/gucb.common.func.sh
if [ $# -ne "4" ];then
  echo "ʹ�÷���: sh  gucb_redo.sh ����ͨ���� ʡ�ֱ��� ҵ������ where����"
  echo "����:sh  gucb_redo.sh 8300 84 3 \"user_id in (''123'',''456'')\" "
  exit
fi

channel_no=$1
prov_code=$2
biz_type=$3
sql_wh=$4
no=$(whoami|cut -c8)
no1=$(echo "$1"|cut -c2)
mon2=$(date +%m)
mon1=$(expr $mon2 % 2)
bak_date=$(date +%m%d%H)

if [ $3 -eq "1" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/1/g;s/_GS//g" < ~/user/gucb/redo/sql/template_redo_yy.sql > tmp_redo.sql
  filter_no=${no}${no1}00
elif [ $3 -eq "3" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/3/g;s/_GS/_GS/g" < ~/user/gucb/redo/sql/template_redo_yy.sql >tmp_redo.sql
  filter_no=${no}${no1}10
elif [ $3 -eq "2" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/2/g;s/_GS/_SM/g" < ~/user/gucb/redo/sql/template_redo_yy.sql >tmp_redo.sql
  filter_no=${no}${no1}20
elif [ $3 -eq "8" ];then
  sed "s/SQL_WHERE/$sql_wh/g;s/BIZ_TYPE_AAA/8/g;s/_GS/_SP/g" < ~/user/gucb/redo/sql/template_redo_yy.sql >tmp_redo.sql
  filter_no=${no}${no1}30
fi

#echo "$filter_no"
echo "�Ƿ�ͣ��һ�ֽ��� filter -c${filter_no} (y/n)"
read answer
if [ "${answer}" = "yes" ] || [ "${answer}" = "y" ];then
  ps -ef|grep filter|grep "c${filter_no}"|awk '{print $2}'|xargs -n1 kill
  echo "����ֹͣ�ּ����"
  sleep 2
  check=$(ps -ef|grep filter|grep "c${filter_no}"|wc -l)
  if [ $check -eq "1" ];then
     echo "�÷ּ���̿��ܹ���"
  fi
fi  

rate_no=${no}${no1}00
echo "�Ƿ�ͣ�����۽��� rate -c${rate_no} (y/n)"

read answer1
if [ "${answer1}" = "yes" ] || [ "${answer1}" = "y" ];then
  ps -ef|grep rate|grep "c${rate_no}"|awk '{print $2}'|xargs -n1 kill
  echo "����ֹͣ���۽���..."
  sleep 3
  check=$(ps -ef|grep rate|grep "c${rate_no}"|wc -l)
  if [ $check -eq "1" ];then
     echo "�����۽��̿��ܹ���,��ȷ��"
  fi
fi

eval ORACONN=\$ORACONN_UCR_${prov_code}
eval ALTI_IP=\$ALT_IP_${no}
mkdir -p ~/user/gucb/redo/alti_bak_data/alti_bak_${bak_date}

sed "s/ALTI_IP/${ALTI_IP}/g;s/USER_AAA/billing${no}/g;s/MON1_SUB/${mon1}/g;s/MON2_SUB/${mon2}/g" < ~/user/gucb/redo/sql/template_alti.sh > alti.sh
cd ./alti_bak_data/alti_bak_${bak_date}/
cp ../../alti.sh .;
sh alti.sh 1>/dev/null
cd ~/user/gucb/redo/;
nohup sqlplus $ORACONN@cbss_bildb_i${no} @./tmp_redo.sql > insert.log &
