#!/bin/bash
# ͬʱ��ȡ���д��������ڵļ����й�ϵ��ʱ��ʹ�ñȽϷ���
#�� a.txt
#a1
#a2
#a3
#b1
#b2
#b3

while read -r line
do
read -r sec_line
read -r third_line
echo "${line}:${sec_line}:${third_line}"
done<a.txt

