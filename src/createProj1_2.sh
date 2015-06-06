#!/bin/sh

#功能 : 快速搭建一个C++工程,包括创建必要的目录,cp框架,创建可直接用的Makefile和创建main.cpp文件
#		脚本执行完后,直接先到common目录下执行" make clean;make ",再到新建的工程目录下执行
#		"make clean;make",就可以编译出一个可运行的简单程序.
#Author : gucb
#Version : 1.2.0
#Last Update : 2015-05-11 11:10

if [ $# -ne 1 ];then
    echo " Error !! 需要一个参数"
	echo " $0 工程名"
    exit
fi

common_path="/ngbss/billing1/user/gucb/test1"  ###common 文件所在目录 
main_path=$(pwd);
proj_name=${1}

###############################function define#######################

#判断common 文件是否存在
get_common(){
	if [ ! -d "common" ];then 
		cp -r ${common_path}/common .
		cd ${main_path}/common 
		sed "s,MAIN_PATH.*=.*,MAIN_PATH = ${main_path},g" <Makefile>tmp
		mv tmp Makefile

		cd ${main_path}
		mkdir -p lib
		mkdir -p bin
	fi
}

create_proj(){
	if [ ! -d "${proj_name}" ];then
		mkdir -p ${proj_name}
		cd ${proj_name}

		mkdir -p src
		mkdir -p inc
		mkdir -p obj
	else
		echo "Error!!! 工程已存在!"
		exit
	fi
}

get_makefile(){
	cd ${main_path}/${proj_name}
echo "###########################################
 #Makefile for the rbk programs
###########################################
PROJ_PATH = ${main_path}
MAIN_PATH = \$(PROJ_PATH)/${proj_name}

LIB_PATH = \$(PROJ_PATH)/lib
BIN_PATH = \$(PROJ_PATH)/bin
COMM_INC = \$(PROJ_PATH)/common/inc

SRC_PATH = \$(MAIN_PATH)/src
OBJ_PATH = \$(MAIN_PATH)/obj
INC_PATH = \$(MAIN_PATH)/inc

#预编译环境
ORAINC          = \${ORACLE_HOME}/rdbms/public
ORALIBS         = -L \${ORACLE_HOME}/lib  -lclntsh -locci -lodbccli -lpthread -L \$(LIB_PATH) -lcommon
ALTIBASE_INC    = \$(ALTIBASE_HOME)/include
ALTIBASE_LIB    =-L \$(ALTIBASE_HOME)/lib

#编译器环境
CC        = xlC
CFLAGS    = -g -brtl -q64 -O -lc -bnoquiet -Ddebug
CCINC     = -I\$(ORAINC) -I\$(INC_PATH) -I\$(ALTIBASE_INC) -I\$(COMM_INC)
CCLIB     = \$(ORALIBS) \$(ALTIBASE_LIB)
LINK.CC   = \$(CC) \$(CFLAGS) \$(CCINC) \$(CCLIB)
COMP.CC   = \$(CC) \$(CFLAGS) \$(CCINC)


TARGET = \${BIN_PATH}/${proj_name} #\${BIN_PATH}/dataToFile #\${BIN_PATH}/fileIndb
all: \$(TARGET)

clean:
	-@rm -f \${OBJ_PATH}/*.o \${BIN_PATH}/billCdrCheck \${BIN_PATH}/dataToFile

\${BIN_PATH}/${proj_name}: \${OBJ_PATH}/main.o
	\$(LINK.CC) -o \${BIN_PATH}/${proj_name} \${OBJ_PATH}/main.o \$(CCINC)

\${OBJ_PATH}/main.o:\${SRC_PATH}/main.cpp
	\$(COMP.CC) -o \${OBJ_PATH}/main.o -c \${SRC_PATH}/main.cpp  \${CCINC}
" >>Makefile
}

get_main(){
	cd ${main_path}/${proj_name}/src
echo "#include<iostream>
#include<string>

using namespace std;

int main(int argc,char **argv)
{
	cout<<\"test  project ${proj_name} \"<<endl;
	return 0;
}
" >>main.cpp
}

###########################script start##############
get_common 
create_proj
get_makefile
get_main
