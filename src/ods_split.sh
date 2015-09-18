##${1} sourcfile #绝对路径的
##${2} linenum
##${3} channelno

echo "split gprsfle redo use"
echo "usage: srcfile fileLineCount channelId"

if [ $# -ne 3 ]; then
echo "input error"
exit 1
fi


echo "input: $1  $2 $3"
echo "yes|no"
read flg
if [ "$flg" != "yes" ] ; then
echo "input error"
exit 2
fi
 

#ODS文件前缀
PREFIX=3ODS_
DATETMP=`date +"%m%d%H%M%S"`
MYSRCFILE=$1
FILELINE=$2
CHANNELID=$3
REDOFLG="REDO"
WORKTMP=`pwd`

if [ ! -e ${MYSRCFILE} ] ; then
echo ${MYSRCFILE}" not found"
exit 3
fi

echo ${MYSRCFILE} "|"${FILELINE}"|"${PREFIX}
cd ${WORKTMP}

split -l ${FILELINE} -a 4 ${MYSRCFILE} ${PREFIX}


ls ${PREFIX}*|awk -F'_' '{printf("mv %s %s%s_%s.%04s.%s\n", $0,$1,c,t,NR,"REDO")}' c=${CHANNELID} t=${DATETMP} >mv.sh

chmod 777 mv.sh
./mv.sh
rm mv.sh

#back up

mkdir -p splitbak;
mv ${MYSRCFILE} splitbak;


