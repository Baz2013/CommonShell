writeLog(){
cur_time=$(date +"%Y-%m-%d %H:%M:%S")
cur_date=$(date +"%Y%m%d")
log_name=${cur_date}"".log
#printf "${cur_time}|$1" >> ${log_name}
echo "${cur_time}|$1" >> ~/user/gucb/public/bude.${log_name}
}

#$1 路径 $2 是否提交(1:提交 0:不提交)
compile(){
cd $1
make clean
make release
if [ "$2" -eq "1" ];then
  make submit
fi
writeLog "$1 编译完成"
}

#$1 路径 $2 是否提交(1:提交 0:不提交)
compile_1(){
cd $1
chmod  +x  getenv
if [ "$2" -eq "1" ];then
  make all submit
fi
writeLog "$1 编译完成"
}

#$1 路径 $2 是否提交(1:提交 0:不提交)
compile_2(){
cd $1
make clean -f makefile.udb
make release -f makefile.udb
if [ "$2" -eq "1" ];then
  make submit -f makefile.udb
fi
writeLog "$1 编译完成"
}

compile_3(){
cd $1
make clean -f makefile.cparam
make release -f makefile.cparam
if [ "$2" -eq "1" ];then
  make submit -f makefile.cparam
fi
writeLog "$1 编译完成"
}

bakup_bude(){
cur_date=$(date +"%m%d")
file_name=gucb_bude_bak${cur_date}
mkdir -p $HOME/user/gucb/${file_name}
cd $HOME/user/gucb/${file_name} 
cp -p -r $HOME/bude .
}

##start here###
bakup_bude

compile "$HOME/bude/syscomp/src/appfrm" "0"
#compile "$HOME/bude/lang/src/base" "0"
#compile "$HOME/bude/syscomp/src/cppsocket" "0"
#compile "$HOME/bude/syscomp/src/hessian" "0"
#compile "$HOME/bude/syscomp/src/dbi" "0"
#compile "$HOME/bude/syscomp/src/log4cpp" "0"
#compile "$HOME/bude/syscomp/src/dbparam" "0"
#compile "$HOME/bude/syscomp/src/file" "0"
#compile_1 "$HOME/bude/syscomp/src/dta" "0"
#compile "$HOME/bude/syscomp/src/ftrans" "0"
#compile "$HOME/bude/syscomp/src/jshlp" "0"
#compile "$HOME/bude/syscomp/src/occi_dbi" "0"
#compile "$HOME/bude/syscomp/src/outdb" "0"
#compile_2 "$HOME/bude/syscomp/src/udbi" "0"
#compile "$HOME/bude/syscomp/src/des" "0"
#compile "$HOME/bude/syscomp/src/archy" "0"
#compile "$HOME/bude/syscomp/src/passmgr" "0"
#compile "$HOME/bude/syscomp/src/dynlib" "0"
#compile "$HOME/bude/syscomp/src/dataset" "0"
#compile "$HOME/bude/syscomp/src/bill" "0"
#compile "$HOME/bude/syscomp/src/mwci" "0"
#compile_3 "$HOME/bude/syscomp/src/cparam" "0"
