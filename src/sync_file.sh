#!/bin/bash

#auto_scp $1 $2
#$1 password
#$2 command
function auto_scp () {
	expect -c "set timeout -1;
              spawn scp -o StrictHostKeyChecking=no -r ${@:2};
              expect {
                    *assword:* {
                                send -- ${1}\r;
                                expect {
                                   *denied* {exit 1;}
                                    eof
                                 }
                    }
                    eof     {exit 1;}
                }
                "
    return $?
}

#auto_ssh $1 $2 $3
#$1 password
#$2 user@ip
#$3 command
function auto_ssh () {
#echo "-----${@:3}"
 expect -c "set timeout -1;
            spawn ssh  -o StrictHostKeyChecking=no $2 ${@:3};
            expect {
                *assword:* {
                        send -- $1\r;
                        expect {
                               *denied* {exit 2;}
                               eof
                               }
                    }
                    eof {exit 1;}
                }
                "
    return $?
}


##############  start  #############
host_list=('xx.xx.xx.126' 'xx.xx.xx.127' 'xx.xx.xx.185' 'xx.xx.xx.188' 'xx.xx.xx.214' 'xx.xx.xx.215' 'xx.xx.xx.80' 'xx.xx.xx.81' 'xx.xx.xx.82') 

PASSWD="billing"

if [ $# -ne "1" ];then
   echo "************同步远程主机程序，同时备份远程主机原文件**************"
   echo "usage: $0 程序名"
   exit
fi

full_file=${1}
dir=$(dirname "${full_file}")
file=$(basename "${full_file}")

####backup files
cur_time=$(date +"%m%d%H")
bak_date=$(date  '+%D'|awk -F"/" '{printf("%s%s\n",$1,$2)}');
echo "cd ${dir}" > tempfile
echo "if [ -f ${file} ]; then" >> tempfile
echo "bak_des=\$(echo \"${file}_bak${bak_date}\")"  >> tempfile
#echo "bak_des=`echo ${file}_bak${bak_date}`" >> tempfile
echo "cp ${file} \${bak_des}" >> tempfile
echo "fi" >> tempfile

for ip in ${host_list[@]} 
do
  auto_scp "${PASSWD}" "tempfile billing@${ip}:~/debug_bin/" >/dev/null 2>&1
  auto_ssh "${PASSWD}" "billing@${ip}" ". ~/.bash_profile && sh ~/debug_bin/tempfile" >/dev/null 2>&1
  auto_scp "${PASSWD}" "${full_file} billing@${ip}:${dir}"
done