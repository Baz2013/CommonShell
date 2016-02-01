cdr_path=$(pwd)
username=${1}
filename=${2}
echo "${username} ${filename}"

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
spool ${cdr_path}/filter_data/${filename}

select /*+ parallel(t1 10) */ trim(SOURCE_TYPE)||','||trim(BIZ_TYPE)||','||trim(FID)||','||trim(RR_FLAG)||','||
trim(RECORD_TYPE)||','||trim(NI_PDP)||','||trim(MSISDN)||','||trim(IMSI_NUMBER)||','||
trim(SGSN)||','||trim(MSNC)||','||trim(LAC)||','||trim(RA)||','||trim(CELL_ID)||','||
trim(CHARGING_ID)||','||trim(GGSN)||','||trim(APNNI)||','||trim(APNOI)||','||trim(PDP_TYPE)||','||
trim(SPA)||','||trim(SGSN_CHANGE)||','||trim(SGSN_PLMN_ID)||','||trim(CAUSE_CLOSE)||','||trim(RESULT)||','||
trim(HOME_AREA_CODE)||','||trim(VISIT_AREA_CODE)||','||trim(USER_TYPE)||','||trim(FEE_TYPE)||','||
trim(ROAM_TYPE)||','||trim(SERVICE_TYPE)||','||trim(IMEI)||','||trim(START_DATE)||','||trim(START_TIME)||','||
trim(CALL_DURATION)||','||trim(serv_id)||','||trim(serv_group)||','||trim(serv_duration)||','||
trim(DATA_UP1)||','||trim(DATA_DOWN1)||','||trim(DATA_UP2)||','||trim(DATA_DOWN2)||','||trim(CFEE_ORG)||','||
trim(DFEE_ORG)||','||trim(FILE_NO)||','||'000'||','||trim(RATE_TIMES)||','||trim(RESERVER1)||','||
'redo'||','||trim(RESERVER3)||','||trim(RESERVER4)||','||trim(RESERVER5)||','||trim(RESERVER6)||','||
trim(RESERVER7)||','||trim(RESERVER8) from tg_cdr09_gs t1
where t1.user_id in (select member_role_id from jc_sd_limk.temp_user_0917 ) 
and t1.start_date like '201509__' 
and t1.source_type = '31'
and t1.resourcelist is null
order by t1.user_id,t1.start_date,t1.start_time ;

spool off
EOF

