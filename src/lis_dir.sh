##�ű�����:����ĳ��Ŀ¼,�����Ŀ¼�´���shell�ű�(.sh�ļ�),��ִ�иýű�

while true;do
cd ~/user/gucb/;
if [ ! -d "exec_file" ];then
  mkdir -p ~/user/gucb/exec_file;
  mkdir -p ~/user/gucb/exec_file/bak;
fi

cd ~/user/gucb/exec_file;
ls *.sh>tmp_01 2>/dev/null ;
f_size=$(ls -l tmp_01|awk '{print$5}');
if [ $f_size -gt "0" ];then
  while read line;do
    file_name=$(echo "$line"|awk '{print$1}');
    #nohup sh $file_name & 
    echo "the file is $file_name";
    sh $file_name;
    #chmod 777 $file_name ;./$file_name;
    sleep 3;
    cd ~/user/gucb/exec_file/;mv *sh bak 2>/dev/null;
  done<tmp_01
  #echo "exist sh file";
fi
#echo "not exist file";
done
