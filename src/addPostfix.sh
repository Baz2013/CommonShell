#�������ļ���Ӻ�׺(ǰ׺)��

sh_file=$0
fix=".dat" 

files=$(ls)
for f in $files
do
	mv ${f} ${f}${fix}
done

mv ${sh_file}${fix} ${sh_file}
