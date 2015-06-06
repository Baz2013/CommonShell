sqlplus -s ucr_sd/ucr_sd@yzbillin<<EOF >/dev/null
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
spool /billing2/wang/bak/gucb_tmp/jna_sp_oneuser12.txt

select trim(source_type)||','||trim(biz_type)||','||trim(FID)||','||trim(RR_FLAG)
||','||trim(CDR_SEQID)||','||''||','||trim(SP_CODE)||','||trim(SP_LOGINNAME)||','||trim(MSIP_ADDRESS)
||','||trim(SP_SRVTYPE)||','||trim(SP_SRVTYPENAME)||','||trim(SP_SRVKIND)||','||trim(SP_SRVID)
||','||trim(SP_SRVNAME)||','||trim(CONTENT_CODE)||','||trim(CONTENT_NAME)||','||trim(MSISDN)
||','||trim(IMSI_NUMBER)||','||trim(NAI_NAME)||','||trim(NAI_DOMAIN)||','||trim(START_DATE)||','||trim(START_TIME)||','||trim(END_DATE)
||','||trim(END_TIME)||','||trim(QTY)||','||trim(ACTIVE_TIME)||','||trim(UP_COUNT)
||','||trim(DOWN_COUNT)||','||trim(TOTAL_COUNT)||','||trim(PRE_DISCOUNTFEE)||','||trim(POST_DISCOUNTFEE)
||','||trim(DISCOUNTFEE)||','||trim(RATE_UNIT)||','||trim(FEE_TYPE)||','||trim(FEE_RATEDESCODE)
||','||trim(DISCOUNT_DESCODE)||','||trim(URL)||','||trim(SYS_ID)||','||trim(SYS_INTRAKEY)
||','||trim(USER_TYPE)||','||trim(OTHER_PARTY)||','||trim(RATE_FLAG)||','||trim(SEND_STATUS)||','||trim(FILE_NO)||','||trim(ERROR_CODE)
||','||trim(RESERVER1)||','||''||','||''||','||trim(NAI_TYPE)||','||trim(HOME_AREA_CODE)||','||trim(VISIT_AREA_CODE)
||','||trim(ROAM_TYPE)||','||trim(CALLED_HOME_CODE)||','||trim(CUST_ID)||','||trim(USER_ID)||','||trim(A_PRODUCT_ID)
||','||trim(A_BRAND_TYPE)||','||trim(A_SERV_TYPE)||','||trim(A_USER_STAT)||','||trim(CHANNEL_NO)||','||trim(OFFICE_CODE)
||','||trim(DOUBLEMODE)||','||trim(OPEN_DATETIME)||','||trim(B_ASP)||','||trim(B_SERV_TYPE)||','||trim(B_HOME_TYPE)||','||trim(RATE_TIMES) from  tg_cdr3g_sp a where a.user_id ='3100250998';

spool off
EOF
