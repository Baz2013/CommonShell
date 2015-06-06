##删除GPP*文件中最后一个字段,文件以","为分隔符

files=$(ls GPP*)
for f in ${files}
do
  sed 's/,[^,]*$//g' ${f} >tmp;
  mv tmp ${f}
done

