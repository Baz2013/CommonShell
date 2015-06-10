#!/bin/ksh
ftp   -nv   <<!
open  10.161.2.98
user billing8 password
passive 
Passive mode on  
lcd ~/user/gucb/send_result/
cd ~/user/gucb/ftp_result/
bin
prompt off
mput *
close
bye
