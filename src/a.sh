for f in `ls`
do
  echo "${f}"
  tr -d '\015' < ${f} >tmp
  mv tmp ${f}
  sleep 1
done
