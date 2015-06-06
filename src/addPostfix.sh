#批量给文件添加后缀(前缀)名

sh_file=$0
fix=".dat" 

files=$(ls)
for f in $files
do
	mv ${f} ${f}${fix}
done

mv ${sh_file}${fix} ${sh_file}
