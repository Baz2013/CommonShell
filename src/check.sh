##检查某个进程是否停掉,如果停掉将该进程重新启动

start()
{
  cd ~/user/gucb/statistics2/bin/
  cdrStatis ${1}
}

while true
do
for i in 1 2 3 4 5 6 7 8 
do
  #echo "ps -ef|grep 'cdrStatis ${i}\$'"
  cnt=`ps -ef|grep "cdrStatis ${i}"|grep -v 'grep'|wc -l`   ##grep 引用外部变量时用双引号
  echo ${cnt}
  if [ ${cnt} -lt 1 ];then
    echo "process ${i}  was stoped"
    start "${i}"
  else
    echo "process ${i} exists"   
  fi
  
done 
sleep 120
done

