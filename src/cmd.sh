#!/usr/bin/expect -f
set USER [lindex $argv 0]
set HOST [lindex $argv 1]
set PASD [lindex $argv 2]
set COMD [lindex $argv 3]
#spawn scp /billing1/user/gucb/monitor/tmp/mmcheck ${USER}@${HOST}:~/user/public
spawn scp /billing1/user/gucb/monitor/tmp/mmrun.sh ${USER}@${HOST}:~/user/public
#expect "*yes*"
#send "yes\r"
expect "*assword:"
send "${PASD}\r"
expect '#'
expect eof

