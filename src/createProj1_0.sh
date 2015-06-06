#!/bin/sh

#���� : ���ٴһ��C++����,����������Ҫ��Ŀ¼,cp���,������ֱ���õ�Makefile�ʹ���main.cpp�ļ�
#		�ű�ִ�����,ֱ���ȵ�commonĿ¼��ִ��" make clean;make ",�ٵ��½��Ĺ���Ŀ¼��ִ��
#		"make clean;make",�Ϳ��Ա����һ�������еļ򵥳���.
#Author : gucb
#Version : 1.0.0
#Last Update : 2015-03-11 14:10

if [ $# -ne 1 ];then
    echo " Error !! ��Ҫһ������"
    exit
fi

common_path="/ngbss/billing1/user/gucb/test1"  ###common �ļ�����Ŀ¼ 
main_path=$(pwd);
proj_name=${1}

#�ж�common �ļ��Ƿ����

cp -r ${common_path}/common .

cd ${main_path}/common 
sed "s,MAIN_PATH.*=.*,MAIN_PATH = ${main_path},g" <Makefile>tmp
mv tmp Makefile

cd ${main_path}
mkdir -p lib
mkdir -p bin
mkdir -p ${proj_name}

cd ${proj_name}

mkdir -p src
mkdir -p inc
mkdir -p obj

echo "
###########################################
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

#Ԥ���뻷��
ORAINC          = \${ORACLE_HOME}/rdbms/public
ORALIBS         = -L \${ORACLE_HOME}/lib  -lclntsh -locci -lodbccli -lpthread -L \$(LIB_PATH) -lcommon
ALTIBASE_INC    = \$(ALTIBASE_HOME)/include
ALTIBASE_LIB    =-L \$(ALTIBASE_HOME)/lib

#����������
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

cd src
echo "
#include<iostream>
#include<string>

using namespace std;

int main(int argc,char **argv)
{
        cout<<\"test  project ${proj_name} \"<<endl;
        return 0;
}
" >>main.cpp

