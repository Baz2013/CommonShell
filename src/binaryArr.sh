##shell 模拟二维数组

set -A arr 0 10 5 5 1 5 5 5 5 3 10 5 5 1 5 5 3 3 5 5 3 3 10 1 5 5 5 5 5 5 5 5
set -A arr_area 0 4 5 4 4 4 2 3 5

arr_print(){
i=1
k=1

while [ "${i}" -lt "${#arr_area[@]}" ]
do
  j=1
  while [ "${j}" -le "${arr_area[i]}" ]
  do
  if [ "${i}" -eq "${1}" ];then
    #echo "$j ${arr_area[i]} ${arr[k]}"
    str=${arr[k]}" "${str}
  fi
  let j=j+1
  let k=k+1
  done
  let i=i+1
done
echo ${str}
}

arr_print_1(){
  d=$(arr_print "${1}")
  i=1
  echo "${#b[@]}"
  while [ "${i}" -lt ${#b[@]} ]
  do
    echo "${b[i]}"
  done
}

b=$(arr_print "4")

echo "${b}"

for i in ${b}
do
  echo ${i}
done

##arr_print_1 "4" "2"

