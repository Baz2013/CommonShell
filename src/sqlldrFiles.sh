#dbUser="UCR_HUN02"
if [ $# -eq "3" ];then
	dbUser=${2}
	dbPasswd="HJIwxx_2"
	dbServer="cbss_bildb_i4"
	path=${1}
	MAXFILE=1000
	k=100
	TABLE_NAME=${3}
else
    echo "wrong parameters"
fi

##########
writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
printf "${cur_time}|$1|\n" >>${2}/gs_ldr.${log_name}
}

if [ ! -d ${1} ];then
  echo "路径 ${1} 不存在 " 
  exit
fi

cd ${1}

if [ ! -d "g_bak" ];then
  mkdir -p g_bak
fi


get_ctl(){
echo "
load data
infile \"${1}\" 
append into table $2
fields terminated by \",\" TRAILING NULLCOLS
(
SOURCE_TYPE       ,
BIZ_TYPE          ,
RR_FID            ,
RR_FLAG           ,
RECORD_TYPE       ,
NI_PDP            ,
MSISDN            ,
IMSI_NUMBER       ,
SGSN              ,
MSNC              ,
LAC               ,
RA                ,
CELLID            ,
CHARGING_ID       ,
GGSN              ,
APNNI             ,
APNOI             ,
PDP_TYPE          ,
SPA               ,
SGSN_CHANGE       ,
SGSN_PLMN_ID      ,
CAUSE_CLOSE       ,
RESULT            ,
HOME_AREA_CODE    ,
VISIT_CODE        ,
USER_TYPE         ,
FEE_TYPE          ,
ROAM_TYPE         ,
SERVICE_TYPE      ,
IMEI              ,
BEGIN_DATE        ,
BEGIN_TIME        ,
DURATION          ,
SERV_ID           ,
SERV_GROUP        ,
SERV_DURATION     ,
DATA_UP1          ,
DATA_DOWN1        ,
DATA_UP2          ,
DATA_DOWN2        ,
CFEE_ORG          ,
DFEE_ORG          ,
FILE_NO           ,
ERROR_CODE        ,
RATE_TIMES        ,
RESERVER1         ,
HOME_TYPE_A       ,
RESERVER3         ,
RESERVER4         ,
CYCLE_TAG         ,
RESERVER6         ,
RESERVER7         ,
SPLIT_TAG         ,
A_ASP             ,
A_SERV_TYPE       ,
CITY_CODE         ,
VISIT_AREA_TYPE   ,
INTER_GPRSGROUP   ,
APN_GROUP         ,
APN_TYPE          ,
USER_ID           ,
CUST_ID           ,
A_PRODUCT_ID      ,
A_SERV_TYPE_YZ    ,
OFFICE_CODE       ,
DOUBLEMODE        ,
CHANNEL_NO        ,
A_USER_STATE      ,
OPEN_DATETIME     ,
PROVINCE_CODE   ) " > ${path}/gs_ldr.ctl
}

merge_file()
{
  cd ${1}
  mkdir -p g_bak
  ls GPP*>aaa.txt
  n=$(ls GPP*|wc -l|awk '{print $1}')
  while [ ${n} -gt "0" ]
  do
    j=0
    while [ ${j} -lt ${MAXFILE} ]
    do
      #fileName=$(printf "TPP_%06d.txt" "${k}")
       fileName="TPP_${k}.txt"
      cat aaa.txt|awk 'NR==v1 {print $1}' v1="$j"|xargs -i sh -c "cat {} >>${fileName} && mv {} g_bak"

      let j=j+1
    done

     ls GPP*>aaa.txt 2>/dev/null
     n=$(ls GPP*|wc -l|awk '{print $1}')
     let k=k+1
  done

}

###清理掉脚本执行过程中产生的中间文件
clean_files(){
cd ${1}
 mv aaa.txt ./g_bak
 mv *.log ./g_bak
}

merge_file "${path}"

cd ${path}
files=$(ls TPP*)
for f in ${files}
do
        ##num=$(awk "_" '{print $1}' ${f})
        #sed "s/AA_FILE_AA/${f}/g;/AA_TABLE_AA/tg_cdr_zhouq/g" < tst.ctl > ${1}/aaa_tmp
        #mv ${1}/aaa_tmp ${1}/gs_ldr.ctl
        get_ctl "${f}" "${TABLE_NAME}"
        sqlldr ${dbUser}/${dbPasswd}@${dbServer} control=gs_ldr.ctl rows=10000 bindsize=33554432 >/dev/null 2>&1
        #判断是否执行成功
        if [ $? -eq "0" ];then
        rm gs_ldr.ctl
        writeLog "文件${f} 已入库" "${1}"
        ##处理完一个文件后,移入备份目录
        mv ${f} g_bak
        else
                writeLog "ERROR 文件${f} sqlldr入库未成功!!!!" "${1}"
                exit
        fi
done

writeLog "目录 ${1} 下的GPP* 文件全部已入库" "${1}"

clean_files "${path}"
