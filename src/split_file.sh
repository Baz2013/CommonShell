#ֻ�����ڵ�ǰĿ¼��ֻ��һ���ļ������,������ڶ���ļ������Ⱥͳ�һ���ļ�(ls G*|xargs -n1 cat >> prefix)�����øýű��ָ�
#splitĬ�ϵ����ָ��ļ���Ϊ676(26*26),-a���������Զ����ļ�����4��ʾ�ĸ��ַ����ȣ�
file=$(ls *.txt); 
file1=0310000GJYY000010430020140731225800 ##�ָ����ļ���ǰ׺
split -l 10000 -a 4 $file tmp_;
mkdir -p splitbak;
mv $file splitbak;
ls tmp_*|awk '{printf("mv %s %s%04s\n", $0,f, NR)}' f="$file1" > mv.sh
sh mv.sh
rm mv.sh
