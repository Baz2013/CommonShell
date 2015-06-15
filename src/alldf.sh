#!/bin/sh
#检查各主机的存储空间,使用量超过90%告警 

set -A host 92 94 96 98 212 214 216 218 227
set -A users billing2 billing4 billing6 billing8 billing2 billing4 billing6 billing8 billing1

_statistics_space(){
	i=0
	while [ "${i}" -lt "${#host[@]}" ]
	do
		echo "*******10.161.2.${host[i]}存储空间********** \n"
		echo "Filesystem                          GB blocks     Free   %Used  Iused    %Iused   Mounted on"
		h="${host[i]}"
		tr -d "\015" < result.${h}.txt > result1.${h}.txt
		cat result1.${h}.txt|grep -E 'bildata|billing'|grep -v '@'
		cnt=$(cat result1.${h}.txt|grep -E 'bildata|billing'|grep '9[0-9]\{1\}%'|wc -l)
		if [ "${cnt}" -gt 0 ];then
			echo "\n\n*************Warning!!Warning  以下磁盘使用量超过了90%*********"
			echo "Filesystem                          GB blocks     Free   %Used  Iused    %Iused   Mounted on"
			####cat result1.${h}.txt|grep -E 'bildata|billing'|grep '9[0-9]\{1\}%'
			cat result1.${h}.txt|grep -E 'bildata|billing'|grep -E '9[0-9]{1}%|100%'
		fi
		let i=i+1
		echo ""
	done
}

get_data(){

	i=0
	while [ "${i}" -lt "${#host[@]}" ]
	do
		user="${users[i]}"
		h="${host[i]}"
		ip="10.161.2.${h}"
		cmd="df -g";
		.send_cmd.sh  ${user} ${ip} 'password' "${cmd}" >> result.${h}.txt  &
		let i=i+1
	done

	echo "                                        正在统计1-8域磁盘空间....................\c"
	tput sc
	count=13
	while true;
	do
		if [ $count -gt 0 ];then
			(( count -= 1))
			sleep 1;
			tput rc
			tput ed
			echo "$count\c"
		else
			tput rc
			tput ed
			echo "\n"
			break;
		fi
	done
}

get_data

_statistics_space

rm result*.txt

