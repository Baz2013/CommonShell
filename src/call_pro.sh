####shell�ű�����Oracle�洢����
####ע��: �洢�������м������,��������,shell�ű����õ�ʱ���Ӧ���м�����κͳ���
###VERSION 0.1

user_name="ubak"
user_pass="ubak"
produre_name="P_CHECK_CDR"
statis_sign="79"
echo ${statis_sign}
sql_str=`
sqlplus -S $user_name/$user_pass@40ngbill <<EOF
set linesize 800;
set long 2048576;
set serveroutput on;
var oi_return NUMBER;
var oi_returninfo VARCHAR2;
        call  $user_name.$produre_name(${statis_sign},:oi_return,:oi_returninfo);
        select :oi_return from dual;
exit
EOF`
echo "$sql_str"|sed -e '4,/^$/!d;/^$/d'|
while read run_return
do
echo $run_return
done

