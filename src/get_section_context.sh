#!/bin/bash
#获取指定标签里的内容,如<51000>....</51000>标签下的所有行,包括标签
#getremote_channels.txt中内容为<51000>\n<51010>....

while read line
do
end_line=$(echo ${line}|sed 's/</<\\\//g') #将<51000>替换为</51000>
#echo "${line}"
#echo "${end_line}"
#echo "/${line}/,/${end_line}/{;p}"
sed -n "/${line}/,/${end_line}/{;p}" ~/etc/sdfstrans.cfg
done<getremote_channels.txt

