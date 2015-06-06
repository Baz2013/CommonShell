#脚本功能：检查一个目标目录，当目录中的文件数量少于100时往该目录下放文件

times=$1 #第一个参数指定频次
num=$2 #第二个参数指定数量
dir="/billing7/billdata/rr/source_200/it200" #文件存放路径
dis_dir="/billing7/billdata/rr/it200" #目标路径

#get_list {
cd "$dir"
ls -lrt 0*|grep "^-"|grep -v 'move_aa.txt'>move_aa.txt ##如果源目录下文件数过多的话,可以使用find 
#}

#move {
cd $dir
count=$(wc -l move_aa.txt|awk '{print $1}')
i=1
while [ "$i" -lt "$count" ]
do
  j=0
  t_count=$(ls -l ${dis_dir}|grep "^-"|wc -l|awk '{print $1}')
  if [ ${t_count} -lt 10 ];then ###当目标目录下少于10个文件的时候,向该目录下放文件
  while [ "$j" -lt "$num" ]
  do
   cat move_aa.txt|awk 'NR==v1 {print $9}' v1="$i"|xargs -i sh -c "mv {} ${dis_dir}"
   let j=j+1 #或者i=$(expr $i + 1)
   let i=i+1 #或者j=$(expr $j + 1)
  done
  fi
sleep $times
done
#}

#get_list
#move
