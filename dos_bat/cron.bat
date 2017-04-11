: 设置定时执行任务
: 参考http://nxhujiee.blog.163.com/blog/static/2984442200910229226381/
schtasks /create /sc minute /mo 60 /tn "load lock paper scrīpt" /tr "python E:\Learn\load_win10_lock_paper.py"
