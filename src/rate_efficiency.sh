if [ $# -lt 1 ];then
        echo "Need one parameter!!!"
        exit
fi
if [ $# -eq 2 ];then
        WORDS=${2}
fi

NUM=${1}
TMPFILE="$$_bbb.txt"
DATE=$(date +"%Y%m%d")
TARGETFILE="${DATE}_statis.dat"
CUR_PATH=$(pwd)
CUR_TIME=$(date +"%Y-%m-%d %H:%M:%S")

set -A channels 4100 4101 4102 4103 4104 4105 4106 4107 4108 4109 4200 4201 4202 4203 4204 4205 4206 4207 4208 4209 4300 4301 4302 4303 4304 4400 4401 4402 4403 4404

############
check(){
        if [ ! -f "logProcess" ];then
                echo " program logProcess not exists !!!"
                exit
        fi
}

write_data(){
 cur_time=$(date +"%Y-%m-%d %H:%M:%S")
 echo "${cur_time}|channel: ${1}|$2" >> ${CUR_PATH}/${TARGETFILE}
}

get_data(){
        i=0
        while [ ${i} -lt ${#channels[@]} ] 
        do
                channel=$(echo ${channels[i]})
                ./logProcess ~/log/rate.${DATE}.log ${channel} >${TMPFILE}
                num=$(tail -n${NUM} ${TMPFILE}|awk -F"," '{sum1=sum1+$5;sum2=sum2+$6;}END{print sum1/sum2}')
                write_data "${channel}" "${num}"
                let i=i+1
        done
}

clean_files()
{
        rm ${TMPFILE}
}


################
check

echo "==================${CUR_TIME}=========\n">>${CUR_PATH}/${TARGETFILE}
if [ $# -eq 2 ];then
        echo "========${WORDS}==============\n">>${CUR_PATH}/${TARGETFILE}
fi

get_data

clean_files

