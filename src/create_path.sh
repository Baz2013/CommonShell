set -A arr_area 0 4 5 4 4 4 2 3 5
no=$(whoami|cut -c8)

m=1
n=0
echo "${arr_area[no]}"
while [ "$m" -le "${arr_area[no]}" ];do
while [ "$n" -lt "24" ]
do
len=${#n}
if [ "$len" -lt "2" ];then
  n=0"$n"
fi
#echo "$m $n"
mkdir -p /data/bildata/data${no}/pp_yw/src/it0${m}/fixvoice/${n}
mkdir -p /data/bildata/data${no}/pp_yw/src/it0${m}/fixnet/${n}
chmod -R 777 /data/bildata/data${no}/pp_yw/src/it0${m}/fixvoice/${n}
chmod -R 777 /data/bildata/data${no}/pp_yw/src/it0${m}/fixnet/${n}
let n=n+1
done
mkdir -p /data/bildata/data${no}/pp_yw/src/it0${m}/fisc/
chmod -R 777 /data/bildata/data${no}/pp_yw/src/it0${m}/fisc/
let m=m+1
#echo "m = $m"
n=0
done


