CREATE OR REPLACE PROCEDURE GUCB_TMP_FEE3(
   v_prov         IN VARCHAR2 ,
   v_domain         IN VARCHAR2 ,
   v_resultcode       OUT NUMBER ,
   v_resultinfo       OUT VARCHAR2
) IS

V_SQL      VARCHAR2(500);
BEGIN
DECLARE
CURSOR emp_cur IS
 SELECT DISTINCT B.DB_USER , v_prov prov FROM UCR_PARAM.TD_USER_CHANNEL_DEF A, UCR_PARAM.TD_CHANNEL B WHERE A.PROVINCE_CODE = v_prov AND A.CHANNEL_NO = B.CHANNEL_NO ORDER BY B.DB_USER;
BEGIN
FOR emp_row IN emp_cur
LOOP
  V_SQL :='insert into tmp_sp_fee3(SOURCE_TYPE,fee_ratedescode,sp_srvid,cnt,fee,domain,prov_code,dbuser,flag) select t.SOURCE_TYPE,t.fee_ratedescode,t.sp_srvid ,count(*),sum(t.discount_cfee + discount_mfee + discount_tfee) ,'''||v_domain||''' domain,'''||v_prov||''' prov_code ,'''||emp_row.DB_USER||''' db_user,''sp'' flag from '||emp_row.DB_USER||'.tg_cdr05_sp t where EXISTS (SELECT * FROM TD_B_PARTY_PRODUCT A WHERE T.SP_SRVID = A.SP_PRODUCT_ID)  group by t.SOURCE_TYPE,t.fee_ratedescode,t.sp_srvid';
   --dbms_output.put_line(V_SQL);
   EXECUTE IMMEDIATE V_SQL;
  COMMIT;

END LOOP;

--COMMIT;
END;

  v_resultcode := 0;
COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    V_RESULTINFO := SUBSTR(SQLERRM, 1, 250);
    ROLLBACK;
    RETURN;

END;
/
