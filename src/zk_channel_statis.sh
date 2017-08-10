#!/bin/bash
. ~/.bash_profile

## usage: sh script_name

for app in custsplit fileproducter operBill pp yunMmInfo sdfstrans cdrAnaly subsidyfeetrans redoDel DdSignIn infoload rr split smsremind filter acctbillfac eventor rate Mrate indb infocheck inforecycle accumulated cv infocheck_mdb
do
   echo -e "ls /BOSS_S/OFCS/CLUSTER_A05/APP/${app}\t y"|zkshell|sed 's/ /\n/g'|grep -wE "${app}-[0-9]{1,5}"|sort|uniq >> ./channels/${app}.txt 2>/dev/null
done 

