##1.grep trash ftrans.cfg 将这里面的trash目录去重列一下
##2.到各个trash目录下查看文件 ，这些为不满足ftrans后扔掉的文件，将文件的前21位截取下 然后弄到某个文件里

cur_path=$(pwd)
prefix=$$_tmp
dst_file="trash_file.txt"

####function define ####
get_dirlist(){
        grep trash ~/etc/ftrans.cfg|awk -F"=" '{print $2}' >${cur_path}/"${prefix}1.txt"
        awk '!a[$0]++' < "${prefix}1.txt" >"${prefix}2.txt"
}

get_filePrefix21(){
        #echo ${1}
        path=$(eval echo ${1})
        if [ ! -d "${path}" ];then
                echo "dir not exist"
        else
                cd ${path}
                files=$(ls )
                for file in ${files}
                do
                        prefix21=$(expr substr ${file} 1 21)
                        echo ${prefix21} >>${cur_path}/${dst_file}
                done
        fi      
}

get_list(){
        while read line
        do
                #echo ${line}
                get_filePrefix21 "${line}"
        done<"${prefix}2.txt"
}

clean_file(){
        cd ${cur_path}
        rm ${prefix}* 2>/dev/null
}

####shell start###
get_dirlist
get_list
clean_file

