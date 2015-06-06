echo "a : kill all channels";
echo "b : kill one channel ";
echo "c : restart the process";
echo "d : start process ";
echo "please choic";

read choose1;

if [ "${choose1}" = "a" ]; then
  echo "Input the process you want to kill (like pp or filter or rate ...)";
  read proc1;
  ps -ef|grep `whoami`|grep "${proc1}"|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill
  echo "kill all done!";
  
elif [ "${choose1}" = "b" ]; then
 echo "Input the process you want to kill (like rate 8400 or filter 2100 ...)";
 read proc2
 channel=`echo "${proc2}"|cut -f1 -d" " `
 proc_no=`echo "${proc2}"|cut -f2 -d" " `
 ps -ef|grep "${channel}"|grep "c${proc_no}"|awk '{print$2}'|xargs -n1 kill
 echo "kill done!";
elif [ "${choose1}" = "c" ]; then
  echo "Input the process you want to restart (like pp or filter or rate ...)";
  read proc3;
  ps -ef|grep `whoami`|grep "${proc3}"|grep 'c[0-9]\{4\}'|awk '{print $8,$9}' > tmp_111.sh;
  no=$(wc -l tmp_111.sh|awk '{print$1}');
  echo "There ${no} process need restart?(yes|no)";
  read an
  if [ "${an}" = "yes" ] || [ "${an}" = "y" ]; then
    ps -ef|grep `whoami`|grep "${proc3}"|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill;
    chmod 777 tmp_111.sh;
	./tmp_111.sh  >> proc1.log;
	rm  tmp_111.sh;
    echo "all the process have started!";
  elif [ "${an}" = "no" ] || [ "${an}" = "n" ]; then
    exit 0;
  fi
elif [ "${choose1}" = "d" ]; then
  echo "Input the process you want to restart (like pp or filter or rate ...)";
  read proc4;
  #杀掉正在运行的进程
  ps -ef|grep `whoami`|grep "${proc4}"|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill
  
  no=$(whoami|cut -c 8); 
  i=`grep "b${no}" r.cfg|awk '{print$2}'`
  i=`expr $i + 1`
  
  ##rate,smsremind,indb,rr
  if [ "${proc4}" = "rate" ] || [ "${proc4}" = "smsremind" ] || [ "${proc4}" = "rr" ] || [ "${proc4}" = "indb" ]; then
  j=1
  while [ $j -lt $i ];do
    echo "${proc4} -c${no}${j}00">> rate_t.sh
    ((j+=1))
  done
  chmod 777 rate_t.sh;
  ./rate_t.sh >> proc1.log;
  rm rate_t.sh;
  
  ##pp
  elif [ "${proc4}" = "pp" ];then
  k=4;
  m=1;
  while [ $m -lt $i ];do
    j=0;
    while [ $j -lt $k ];do
      echo "${proc4} -c${no}${m}${j}0"  #>> pp_t.sh
      ((j+=1))
     done
    ((m+=1))
   done
  #chmod 777 pp_t.sh;
  #./pp_t.sh;
  #rm pp_t.sh;
  
  ##ftrans
  elif [ "${proc4}" = "ftrans" ];then
    k=4;
    m=1;
    
    while [ $m -lt $i ];do
      j=0;
      while [ $j -lt $k ];do
        echo "${proc4} -c${no}${m}${j}0"
        ((j+=1))
      done
      ((m+=1))
    done
    
    l=9;
    n=1;
    while [ $n -lt $l ];do
      echo "${proc4} -c${no}${n}40"
      ((n+=1))
    done
    
  #chmod 777 ftrans_t.sh;
  #./ftrans_t.sh >> proc1.log;
  #rm ftrans_t.sh;
  
  elif [ "${proc4}" = "filter" ]; then
    k=8;
    m=1;
    while [ $m -lt $i ];do
      j=0;
      while [ $j -lt $k ];do
        echo "${proc4} -c${no}${m}${j}0" >> filter_t.sh;
        ((j+=1))
       done
      ((m+=1))
    done
    chmod 777 filter_t.sh;
    ./filter_t.sh >> proc1.log;
    rm filter_t.sh;
  fi
 
fi

