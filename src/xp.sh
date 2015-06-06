#!/usr/bin
min_m=20
max_m=24

# $1 min $2 max
function random_1(){
  min=$1
  max=$2-$1
  num=$(date +%s+%N)
  ((retnum=num%max+min))
  echo $retnum
}

function random(){
  min=$1
  max=$2-$1
  #num=$(date +%s+%N)
  num=$(echo $RANDOM)
  ((retnum=num%max+min))
  echo $retnum
}

# $1 date like 20140812 $2 num
function addone(){
 new_day=$(date -d "+${2} day $1" +%Y%m%d) 
 echo ${new_day}
}

# $1 day like 20140820
function week(){
  y=$(echo $1|cut -c1-4)
  m=$(echo $1|cut -c5,6)
  d=$(echo $1|cut -c7,8)
  w=$(date -d "$y-$m-$d" +%w)
  echo $w 
}

#judge the length of string
# $1 string 
function get_len(){
  l=$(expr length $1)
  if [ $l -eq 1 ];then
    echo "0${1}"
  else
    echo "${1}"
  fi
}

day=$1
while [ $day -lt $2 ]
do
   #echo $day
   we=$(week "$day")
   if [ $we -ne 0 ] && [ $we -ne 6 ];then
   _m=$(random $min_m $max_m)
   _h=$(random 21 23)
   _f=$(random 0 59)
   _f=$(get_len "${_f}")
   echo "$day  ${_h}:${_f}  ${_m} ---->${we}"
   #echo "$day  ----> ${we}"
   fi
   _d=$(random 1 3) #except num of day
   #day=$(addone "$day" "1")
   day=$(addone "$day" "${_d}")
done
