#!/bin/bash
##shell 关联数组demo (http://blog.csdn.net/ysdaniel/article/details/7909824)
##适用环境 Linux

prov_code=(11 34 38 86)
declare -A prov_name
prov_name=([11]="bj" [34]="js" [38]="fj" [86]="yn")

for key in ${!prov_name[*]}
do
	echo "${key} ${prov_name[$key]}"
done

