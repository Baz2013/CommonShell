CREATE OR REPLACE PROCEDURE GUCB_TMP(
   v_prov         IN VARCHAR2 ,
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
   --dbms_output.put_line('----');
   ---'11' prov_code,'ucr_bj01' db_user,'monfee' flag
   V_SQL := 'INSERT INTO tmp_sp(sp_srvid,prov_code,dbuser,flag) select distinct sp_srvid ,'''||v_prov||''' prov_code,'''||emp_row.DB_USER||''' db_user,''sp'' flag from '||emp_row.db_user||'.tg_cdr05_sp t where source_type = ''4D'' and exists (select * from td_b_party_price b where t.sp_srvid = b.productcode) and not exists (select * from td_b_party_product a where t.sp_srvid = a.sp_product_id)';
    
   EXECUTE IMMEDIATE V_SQL;
  --  dbms_output.put_line(V_SQL);
    
  COMMIT;
   ---- tg_cdr05_monfee
   V_SQL := 'INSERT INTO tmp_sp(sp_srvid,prov_code,dbuser,flag) select distinct oper_code ,'''||v_prov||''' prov_code,'''||emp_row.DB_USER||''' db_user,''monfee'' flag from '||emp_row.db_user||'.tg_cdr05_monfee t where exists (select * from td_b_party_price b where t.oper_code = b.productcode) and not exists (select * from td_b_party_product a where t.oper_code = a.sp_product_id)';
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

