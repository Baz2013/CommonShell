# CommonShell
工作中经常使用的shell脚本

将工作中积累下的常用脚本及命令整理并提交,方便进行版本控制及查看

该系列主要有
common 目录:
#该目录下存放的文件为常用的shell函数及工作业务相关的参数文件

使用方法1:
. ${COMMON_PATH}/gucb.common.func.sh
之后就可以直接在脚本中使用 gucb.common.func.sh 定义的一系列函数了

使用方法2:
切换的指定的工作目录下后
执行 . ${COMMON_PATH}/gucb.common.func.sh 
之后 gucb.common.func.sh 中定义的一些函数就可以当作命令使用了

例如:
$ . ${COMMON_PATH}/gucb.common.func.sh 
$ extract 压缩文件 ---这时候就不必为特定的压缩文件去执行特定的压缩命令了
$ delDos  filename  ---删除文件中的dos字符
$ delDosAll ----删除当前目录所有文件中的dos字符

将这些常用函数及命令封装到公共函数文件中或者 .profile 或者 .bash_rc 等
系统文件中,可以极大的提高工作的效率

src 目录:
该目录下是经常使用的shell脚本,工作中有时候遇到处理文本文件,查找特定内容,执行特定任务的时候
可以直接将其中的脚本拷贝过来使用或者经过简单的修改就可以使用,省去了百度然后再去编写测试
的麻烦

test目录:
该目录下为 测试数据及测试脚本文件

更加详细参见 文件中的注释
