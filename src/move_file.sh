#�ű����ܣ����һ��Ŀ��Ŀ¼����Ŀ¼�е��ļ���������100ʱ����Ŀ¼�·��ļ�

times=$1 #��һ������ָ��Ƶ��
num=$2 #�ڶ�������ָ������
dir="/billing7/billdata/rr/source_200/it200" #�ļ����·��
dis_dir="/billing7/billdata/rr/it200" #Ŀ��·��

#get_list {
cd "$dir"
ls -lrt 0*|grep "^-"|grep -v 'move_aa.txt'>move_aa.txt ##���ԴĿ¼���ļ�������Ļ�,����ʹ��find 
#}

#move {
cd $dir
count=$(wc -l move_aa.txt|awk '{print $1}')
i=1
while [ "$i" -lt "$count" ]
do
  j=0
  t_count=$(ls -l ${dis_dir}|grep "^-"|wc -l|awk '{print $1}')
  if [ ${t_count} -lt 10 ];then ###��Ŀ��Ŀ¼������10���ļ���ʱ��,���Ŀ¼�·��ļ�
  while [ "$j" -lt "$num" ]
  do
   cat move_aa.txt|awk 'NR==v1 {print $9}' v1="$i"|xargs -i sh -c "mv {} ${dis_dir}"
   let j=j+1 #����i=$(expr $i + 1)
   let i=i+1 #����j=$(expr $j + 1)
  done
  fi
sleep $times
done
#}

#get_list
#move
