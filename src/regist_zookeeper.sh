#!/bin/bash
##alias zkshell='$ZKCLIENT_HOME/bin/zkCli.sh -server 10.xx.xx.xx:2181,10.xx.xx.xx:2181,10.xx.xx.xx:2181'
#向zookeeper注册程序通道
#zoocreate.txt:5,Meventor-51200

. ~/.bash_profile
if [ $# -eq 2 ];then
	grep -E '<[0-9]{3,}' $2|tr -cd '[0-9\n]'|xargs -i printf "1,${1}-{}\n" > ./zoocreate.txt
fi
if [ $# -eq 3 ];then
	echo "$1,$2-$3" > ./zoocreate.txt
fi
modelsql="create /BOSS_S/OFCS/CLUSTER_A0DOMAIN/APP/CHANNEL 0;0|create /BOSS_S/OFCS/CLUSTER_A0DOMAIN/APP/CHANNEL/001 ;0;|create /BOSS_D/OFCS/CLUSTER_A0DOMAIN/APP/CHANNEL CHANNEL|create /BOSS_D/OFCS/CLUSTER_A0DOMAIN/APP/CHANNEL/LOCK LOCK"
echo -e $modelsql
while read line;do
	echo $line
	domain=`echo $line|awk -F, '{print $1}'`
	echo $domain
	channel=`echo $line|awk -F, '{print $2}'`
	echo $channel
	createsql=`echo -e $modelsql|sed "s/DOMAIN/$domain/g;s/CHANNEL/$channel/g"`
	for i in 1 2 3 4
	do
		ll=`echo $createsql|awk -F'|' -vvar=$i '{print $var}'`
		echo $ll
		echo "$ll"|zkshell
	done
done < ./zoocreate.txt

