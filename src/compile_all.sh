bakup_bin(){
cd $HOME/user/gucb;
cur_date=$(date +"%m%d")
mkdir -p gucb_bak${cur_date}
cd gucb_bak${cur_date}
cp -p -r $HOME/bin .
}

writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/public/${log_name}
}

compile(){
cd $1
make clean 
make release 
if [ "$2" -eq "0" ];then
make submit 
fi
writeLog "$1 编译完成\n"
}

compile_1(){
cd $1;
make  clean -f  makefile_mgr 
make  release -f  makefile_mgr 
if [ "$2" -eq "0" ];then
make  submit  -f  makefile_mgr 
fi
writeLog "$1 编译完成\n"
}

compile_2(){
cd $1;
make clean -f Makelib 
make release -f Makelib 
make submit -f Makelib 
make release
if [ "$2" -eq "0" ];then
make submit 
fi
writeLog "$1 编译完成\n"
}

compile_3(){
cd $1;
nohup sh Make_release.sh &
}

#备份程序
#bakup_bin
#编译程序 $2 0不提交 1提交
compile "$HOME/src/mdb" "0"
compile "$HOME/src/mdb_param"  "0"
compile_1 "$HOME/src/mdb/semaphore" "0"
compile "$HOME/src/mutexInfoPrint" "0"
compile "$HOME/src/RRC" "0"
compile "$HOME/src/mdb_createTool/tool" "0"
compile "$HOME/src/mdbserver" "0"
compile "$HOME/src/console" "0"
compile "$HOME/src/mdb_bill" "0"
compile "$HOME/src/pmbilling" "0"
compile "$HOME/src/infoload" "0"
compile "$HOME/src/cdr" "0"
compile "$HOME/src/pp" "0"
compile_2 "$HOME/src/rr" "0"
compile "$HOME/src/indb" "0"
compile "$HOME/src/ret" "0"
compile "$HOME/src/send" "0"
compile_3 "$HOME/src/filter" 
compile_3 "$HOME/src/rate" 

count=$(ps -ef|grep Make_release.sh|grep `whoami`|grep -v grep|wc -l)
while [ "$count" -gt 0 ]
do 
sleep 10
count=$(ps -ef|grep Make_release.sh|grep `whoami`|grep -v grep|wc -l)
done
writeLog "$HOME/src/filter 编译完成"
writeLog "$HOME/src/rate 编译完成"

compile "$HOME/src/recycle" "0"
compile "$HOME/src/eventor" "0"
compile_3 "$HOME/src/monthend"
sleep 240
writeLog "$HOME/src/monthend 编译完成"

compile "$HOME/src/custsplit" "0"
compile "$HOME/src/sms_remind" "0"
