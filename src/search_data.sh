##awk 使用外部变量

for i in 101 103 104 105 203 301 302 303 304 305 306 307 308 309 310 313 315
do
  #echo ${i}
  awk -F"^Y" '{if($2 == v1) {print $0}}' v1="${i}" ~/user/wangh/ctob/7_* >>a.txt #^Y 为特殊资费,Ctrl + v ,Ctrl + y 打出来的
done

