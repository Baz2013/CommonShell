cdrpath=$(pwd)
username=${1}
filename=${2}

sqlplus -s ${username}/AiQpOL_3@cbss_bildb_i1 <<EOF >/dev/null
set echo off
set feedback off
set heading off
set pagesize 0
set newpage 0
set linesize 4096
set termout off
set trims on
set trimout on
set wrap off
set trimspool on
spool ${cdrpath}/ods_data/${filename}

select trim(SOURCE_TYPE)||','||trim(BIZ_TYPE)||','||trim(FID)||','||trim(RR_FLAG)||','||trim(FILE_NAME)||','||trim(DEAL_TIME)||','||
trim(RECORD_TYPE)||','||trim(NI_PDP)||','||trim(MSISDN)||','||trim(IMSI_NUMBER)||','||trim(SGSN)||','||trim(MSNC)||','||
trim(LAC)||','||trim(RA)||','||trim(CELL_ID)||','||trim(CHARGING_ID)||','||trim(GGSN)||','||trim(APNNI)||','||trim(APNOI)||','||
trim(PDP_TYPE)||','||trim(SPA)||','||trim(SGSN_CHANGE)||','||trim(SGSN_PLMN_ID)||','||trim(CAUSE_CLOSE)||','||trim(RESULT)||','||
trim(HOME_AREA_CODE)||','||trim(VISIT_AREA_CODE)||','||trim(CITY_CODE)||','||trim(VISIT_AREA_HOMETYPE)||','||trim(USER_TYPE)||','||
trim(FEE_TYPE)||','||trim(ROAM_TYPE)||','||trim(SERVICE_TYPE)||','||trim(IMEI)||','||trim(START_DATE)||','||trim(START_TIME)||','||
trim(CALL_DURATION)||','||trim(SERV_ID)||','||trim(SERV_GROUP)||','||trim(SERV_DURATION)||','||trim(DATA_UP1)||','||
trim(DATA_DOWN1)||','||trim(DATA_UP2)||','||trim(DATA_DOWN2)||','||trim(CHARGED_ITEM)||','||trim(CHARGED_OPERATION)||','||
trim(CHARGED_UNITS)||','||trim(FREE_CODE)||','||trim(BILL_ITEM)||','||trim(CFEE_ORG)||','||trim(CFEE)||','||trim(DIS_CFEE)||','||
trim(DFEE_ORG)||','||trim(DFEE)||','||trim(DIS_DFEE)||','||trim(RECORDSEQNUM)||','||trim(FILE_NO)||','||'000'||','||
trim(CUST_ID)||','||trim(USER_ID)||','||trim(A_PRODUCT_ID)||','||trim(A_SERV_TYPE)||','||trim(CHANNEL_NO)||','||trim(OFFICE_CODE)||','||
trim(DOUBLEMODE)||','||trim(OPEN_DATETIME)||','||trim(A_USER_STAT)||','||trim(INTER_GPRSGROUP)||','||trim(APN_GROUP)||','||
trim(APN_TYPE)||','||trim(TARIFF_FEE)||','||trim(RATE_TIMES)||','||trim(INDB_TIME)||','||trim(RESERVER1)||','||trim(RESERVER2)||','||
trim(RESERVER3)||','||trim(RESERVER4)||','||trim(RESERVER5)||','||trim(RESERVER6)||','||trim(RESERVER7)||','||trim(RESERVER8)||','||
trim(PARTITION_ID)||','||trim(PROVINCE_CODE)||','||trim(RATE_TYPE)||','||trim(RESOURCELIST) FROM tg_cdr09_gs 
where user_id in (select member_role_id from jc_sd_limk.temp_user_0917 ) 
and start_date like '201509__' 
and source_type = '31'
and resourcelist is null;

spool off
EOF

