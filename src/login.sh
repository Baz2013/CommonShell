#!/bin/expect -f  

# 主机跳转脚本

if {$argc < 2} {
  puts stdout "$argv0 hostip username passwd\n"
  exit 1
}

set ip [lindex $argv 0 ]
set user [lindex $argv 1]
set password [lindex $argv 2 ]
set timeout 10 

spawn ssh ${user}@${ip}
expect {
"*yes/no" { send "yes\r"; exp_continue}
"*password:" { send "${password}\r" }
}  
interact 

