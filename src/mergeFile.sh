###将指定目录下的文件合并成一个大文件
MAXFILE=50  ###每50个文件合并成一个大文件
k=100   ##文件序列号起始序列

merge_file()
{
  cd ${1}
  mkdir -p g_bak
  ls GPP*>aaa.txt
  n=$(ls GPP*|wc -l|awk '{print $1}')
  while [ ${n} -gt "0" ]
  do
    j=0
    while [ ${j} -lt ${MAXFILE} ]
    do
      #fileName=$(printf("TPP_%06d.txt",${k}))
       fileName="TPP_${k}.txt"
      cat aaa.txt|awk 'NR==v1 {print $1}' v1="$j"|xargs -i sh -c "cat {} >>${fileName} && mv {} g_bak"
       
      let j=j+1
    done

     ls GPP*>aaa.txt 2>/dev/null
     n=$(ls GPP*|wc -l|awk '{print $1}')
     let k=k+1
  done

}

