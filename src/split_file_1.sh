if [ ! -f "${1}" ];then
  echo "file not exists"
  exit
fi

prefix="1GP3102"
#curr_time=$(date +"%m%d%H%M%S")
file=${1};
num="10"
split -l ${num} -a 4 ${file} tmp_;
mkdir -p splitbak;
mv $file splitbak;

files=$(ls tmp*)
i=0
for f in ${files}
do
curr_time=$(date +"%m%d%H%M%S")

printf "mv ${f} ${prefix}_${curr_time}.%04s.REDO\n" ${i}
let i=i+1
sleep 1
done




##1GP3102_0914170331.0000.REDO
#ls tmp_*|awk '{printf("mv %s %s_%s.%04s.REDO\n", $0,f,ctime, NR)}' f="$prefix" ctime="$curr_time"  > mv.sh
#sh mv.sh
#rm mv.sh

