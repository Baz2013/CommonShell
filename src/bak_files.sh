set -A province 4 5 4 4 5 2 3 5
area=$(whoami|cut -c 8)
#echo ${province[area-1]}
prov_no=${province[area-1]}

p1=BOSS_DATA"${area}"
p2="$"$p1
path=$(echo $p2|xargs -i sh -c "echo {}")
path_bak="${path}/eventor_bak/"

if [ ! -d "${path_bak}" ]; then
mkdir -p ${path_bak}
fi

k=1
while [ $k -lt $prov_no+1 ];do
#echo "${path}/eventor/common/it${k}00"
cd "${path}/eventor/common/it${k}00" ;
ls -l|grep '^-'|awk '{print $9}'|xargs -i sh -c "mv {} ${path_bak}"
((k+=1))
done

