#!/bin/bash
#��ȡָ����ǩ�������,��<51000>....</51000>��ǩ�µ�������,������ǩ
#getremote_channels.txt������Ϊ<51000>\n<51010>....

while read line
do
end_line=$(echo ${line}|sed 's/</<\\\//g') #��<51000>�滻Ϊ</51000>
#echo "${line}"
#echo "${end_line}"
#echo "/${line}/,/${end_line}/{;p}"
sed -n "/${line}/,/${end_line}/{;p}" ~/etc/sdfstrans.cfg
done<getremote_channels.txt

