set -A host 92 93 94 95 96 97 98 211 212 213 214 215 216 217 218 227
set -A users billing2 billing3 billing4 billing5 billing6 billing7 billing8 billing1 billing2 billing3 billing4 billing5 billing6 billing7 billing8 billing1

#set -A host  95 96 97 98 211 212 213 214 215 216 217 218 227
#set -A users billing5 billing6 billing7 billing8 billing1 billing2 billing3 billing4 billing5 billing6 billing7 billing8 billing1


i=0
while [ "${i}" -lt "${#host[@]}" ]
do
h="${host[i]}"
ip="10.161.2.${h}"
user="${users[i]}"
echo "${ip} : ${user}"
#./cmd.sh "${user}" "${ip}" "U1n@i3v\$e5r"
#./cmd1.sh "${user}" "${ip}" "U1n@i3v\$e5r" "ps -ef|grep mmrun.sh|grep -v grep|awk '{print \$2}'|xargs kill" &
./cmd1.sh "${user}" "${ip}" "U1n@i3v\$e5r" "cd ~/user/public/;nohup sh mmrun.sh &" &
let i=i+1
done
