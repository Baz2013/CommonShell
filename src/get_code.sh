if [ ! -f "src.zip" ]; then
echo "src file not exists!!";
fi
echo "src file exists";
unzip src.zip 1>/dev/null;
##get code list
find ./src -name '*' >> tmp_list;
while read line;do
if [ ! -d $line ]; then
echo "$line" >>list;
fi
done<tmp_list

bak_date=`date  '+%D'|awk -F"/" '{printf("%s%s\n",$1,$2)}'`;
echo "${bak_date}";

no=$(whoami|cut -c8);
while read line; do
 src_c=$(echo "$line");
 des_c=$(echo "$line"|sed "s/\.\//\/billing${no}\//g")
 if [ ! -f $des_c ]; then
   # echo "file not exist";
   # echo $des_c;
   touch $des_c
   cp $src_c $des_c
 else
    bak_des=$(echo "${des_c}_bak${bak_date}")
    echo "$bak_des";
    cp $des_c $bak_des;
    cp $src_c $des_c;
 fi
 #echo $des_c;
done<list

rm tmp_list;
