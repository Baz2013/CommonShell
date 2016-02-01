##${1} sourcfile #绝对路径的
##${2} linenum
##${3} channelno


if [ "$#" -ne 3 ];then
  echo "usage: filter_split.sh filename num channnelno"
  exit
fi

if [ ! -f "${1}" ];then
  echo "file not exists"
  exit
fi


file=${1};
num=${2}
channelno=${3}


s=$(expr ${num} + 0 2>&1 >/dev/null)
if [ $? -ne 0 ];then
  echo "num is not a digit"
  exit
fi

prefix="1GP${channelno}"
curr_time=$(date +"%m%d%H%M%S")
split -l ${num} -a 4 ${file} tmp_;
mkdir -p splitbak;
mv $file splitbak;
##1GP3102_0914170331.0000.REDO
ls tmp_*|awk '{printf("mv %s %s_%s.%04s.REDO\n", $0,f,ctime, NR)}' f="$prefix" ctime="$curr_time"  > mv.sh
chmod 775 mv.sh
./mv.sh
rm mv.sh

