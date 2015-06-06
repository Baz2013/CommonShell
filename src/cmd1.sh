#!/usr/bin/expect -f
set USER [lindex $argv 0]
set HOST [lindex $argv 1]
set PASD [lindex $argv 2]
set COMD [lindex $argv 3]
spawn ssh ${USER}@${HOST}
#expect "*yes*"
#send "yes\r"
expect "*assword:"
send "${PASD}\r"
expect '#'
send "${COMD}\r"
expect eof

