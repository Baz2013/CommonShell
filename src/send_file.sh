#!/bin/sh
#�ļ��ַ��ű�,ʵ�ֽ�ָ��Ŀ¼�µ��ļ��ַ�������������Ŀ¼�� 
#��һ������Ϊȫ·�����ļ��� �ڶ�������ΪҪ�ַ���ʡ��

if [ $# -ne "2" ];then
        echo "param wrong"
        exit
fi

set -A host 0 10.124.0.32 10.124.0.32 10.124.0.32 10.124.0.32 10.124.0.31 10.124.0.31 10.124.0.31 10.124.0.31 10.124.0.31 10.124.0.31
set -A users 0 billing1 billing2 billing3 billing4 billing5 billing6 billing7 billing8
set -A arr_prov 0 11 34 38 86 97 36 13 31 87 51 81 59 79 91 74 89 75 76 10 85 88 17 70 18 71 83 19 90 84 30 50
set -A arr_area 0 4 5 4 4 4 2 3 5

password="billing@123"

src_path="${1}"
prov_code="${2}"
cur_path=$(pwd)
prov_no=""
area_no=""
serial_no=""
dst_host=""
dst_user=""
dst_path=""

writeLog(){
        cur_time=$(date +"%Y-%m-%d %H:%M:%S")
        cur_date=$(date +"%Y%m%d")
        log_name=${cur_date}"".log
        printf "${cur_time}|$1|\n" >>${2}/send_file.${log_name}
}

##����ļ��Ƿ�Ϊ.sh�ļ�,��������˳��ű�
check_file(){
        file=${1}
        file_name=$(basename ${file})
        len=$(expr length ${file_name})
        pos=$(expr ${len} - 2)
        post_fix=$(expr substr "${file_name}" "${pos}" 3)
        #echo "$post_fix"
        if [ "${post_fix}" == ".sh" ];then
                exit
        fi
}

check_param(){
        if [ ! -f "${1}" ];then
                writeLog "�ļ�${1} ������ !! " "${cur_path}"
                echo "�ļ�${1} ������ !! "
                exit
        fi

        i=1
        while [ ${i} -le 31 ]
        do
                if [ ${arr_prov[i]} -eq ${2} ];then
                        prov_no=${i}
                        break
                fi      
                let i=i+1
        done
        
        ##echo "${prov_no}"
        if [ ! -n "${prov_no}" ];then
                echo "prov_code ${prov_code} ������ !"
                writeLog "prov_code ${prov_code} ������ !" "${cur_path}"
                exit
        fi
        writeLog "������ȷ" "${cur_path}"
}

get_area(){
        i=1
        k=0
        while [ ${i} -lt 9 ]
        do
                #echo "${arr_area[i]}"
                j=1
                while [ ${j} -le ${arr_area[i]} ]
                do
                        let k=k+1
                        if [ ${k} -eq ${prov_no} ];then
                                #echo "get it "
                                area_no=${i}
                                serial=${j}
                                break
                        fi
                        let j=j+1
                done
                
                if [ -n "${area_no}" -a -n "${serial}" ];then
                        break
                fi
                let i=i+1
        done
        writeLog "${prov_code}Ϊ${area_no}��ĵ�${serial}��ʡ" "${cur_path}"
}

get_dst(){
        dst_host="${host[area_no]}"
        dst_user="${users[area_no]}"
        dst_path="/ngbss/billdata/data${area_no}/rr/it${serial}00/"
        #echo "${dst_host}"
        #echo "${dst_user}"
        send_cmd="scp ${src_path} ${dst_user}@${dst_host}:\${BOSS_DATA${area_no}}/rr/it${serial}00/"
        writeLog "Ŀ������:${dst_host},Ŀ���û� :${dst_user}" "${cur_path}"
}

send_file(){
rm cmd.sh 2>/dev/null
        echo "#!/usr/bin/expect -f
set USER [lindex \$argv 0]
set HOST [lindex \$argv 1]
set PASD [lindex \$argv 2]
set COMD [lindex \$argv 3]
spawn scp ${src_path} \${USER}@\${HOST}:/ngbss/billdata/data${area_no}/rr/it${serial}00/
expect \"*assword:\"
send \"\${PASD}\\\r\"
expect '#'
expect eof
" >>cmd.sh

chmod 777 cmd.sh
#echo "./cmd.sh ${dst_user} ${dst_host} ${password}"

re=$(./cmd.sh ${dst_user} ${dst_host} ${password} 2>/dev/null)
#./cmd.sh ${dst_user} ${dst_host} ${password} 2>&1 >/dev/null

writeLog "�ļ�${src_path}�Ѵ���Ŀ������Ŀ¼�� " "${cur_path}"
}

bak_srcfile(){

        path=$(dirname ${src_path})
        filename=$(basename ${src_path})
        cd ${path}
        if [ ! -d "cdr_bak" ];then
                mkdir -p cdr_bak
        fi
        mv ${filename} ./cdr_bak
        writeLog "�ļ�${filename} ���Ƶ�cdr_bakĿ¼��" "${cur_path}"
        cd ${cur_path}
}

clean_file(){
        sleep  2
        rm -f cmd.sh

        writeLog "�м��ļ���ɾ�� " "${cur_path}"
}

######start #####
check_file "${src_path}"
check_param "${src_path}" "${prov_code}"
get_area
#echo "${area_no} ${serial}"

get_dst
#echo "${send_cmd}"
send_file
bak_srcfile
clean_file
echo "${dst_host}@${dst_user}:${dst_path}"

