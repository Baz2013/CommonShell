set -A arr 0 4 5 4 4 4 2 3 5
no=$(whoami|cut -c8)

cd ~/user/gucb/send_result;

#echo ${arr[no]}
i=1
echo "${no} Óò --------------------------------------" >>file_number_${no}.log
while [ i -le "${arr[no]}" ]
do
count=$(ls -l ~/billdata/pp_yw/bak/it${i}00/bcgprs | grep '^-'|wc -l)
echo "~/billdata/pp_yw/bak/it${i}00/bcgprs ------- ${count}" >>file_number_${no}.log

count=$(ls -l ~/billdata/pp_yw/bak/it${i}00/bcgsm | grep '^-'|wc -l)
echo "~/billdata/pp_yw/bak/it${i}00/bcgsm ------- ${count}" >>file_number_${no}.log

count=$(ls -l ~/billdata/pp_yw/bak/it${i}00/bcsms | grep '^-'|wc -l)
echo "~/billdata/pp_yw/bak/it${i}00/bcsms ------- ${count}" >>file_number_${no}.log

count=$(ls -l ~/billdata/pp_yw/bak/it${i}00/bcvac | grep '^-'|wc -l)
echo "~/billdata/pp_yw/bak/it${i}00/bcvac ------- ${count}" >>file_number_${no}.log
((i=i+1))
done

cd ~/user/gucb;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;
