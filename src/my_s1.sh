cd ~/src/rate ;find . -name '*'>~/user/gucb/send_result/rate_file;
cd ~/user/gucb/;sh ftp_send.sh;

no=$(whoami|cut -c8);
cd ~;zip -r etc_bak0314.zip etc 1>/dev/null;cp etc_bak0314.zip ~/user/gucb/gucb_bak/;
cd ~/user/gucb/gucb_bak/;ls -al>>check1.log$no;mv check1.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;

cd ~/user/gucb/;ls -l>>file_list;mv file_list ~/user/gucb/send_result;
cd ~/user/gucb/;sh ftp_send.sh;
cd  ~/user/gucb/send_result;rm * 2>/dev/null;

cd ~/user/gucb/;
nohup ./listen01.sh &
ps -ef|grep ./listen01.sh >> check_ch ;
mv  check_ch  ~/user/gucb/send_result;
cd ~/user/gucb/;sh ftp_send.sh;
cd  ~/user/gucb/send_result;rm * 2>/dev/null;



no=$(whoami|cut -c8);
cd ~/user/gucb/llk_20140314;
unzip src.zip 1>/dev/null;
ls -al >> check_file.log$no ;mv check_file.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd  ~/user/gucb/send_result;rm * 2>/dev/null;


##########################################3

#备份程序
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0314;
cd ~/user/gucb/gucb_bak0314;
cp ~/bin/filter .;
cp ~/bin/rate .;
cp ~/bin/pp .;
cp ~/bin/smsremind .;
cp ~/bin/eventor .;
cp ~/bin/rr .;
cp ~/bin/redo .;
cp ~/bin/monthend .;

#备份文件：
cd ~/;zip -r etc_bak0314.zip etc;
cd ~/user/gucb/gucb_bak0314;
cp ~/etc_bak0314.zip .;

#进行稽核
cd  ~/user/gucb/gucb_bak0314;
ls -al >> check_bak_file.log$no ;
mv check_bak_file.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


############程序发布
1-7 域上的send_code.sh 还存在一个小错误 echo cp $src_c $des_c;



no=$(whoami|cut -c8);
cd ~/user/gucb/llk_20140314;
cp list6 ~/user/gucb/send_result/;
cp get_code.sh ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;


##############
no=$(whoami|cut -c8);
cd ~/user/gucb/llk_20140314;
sh get_code.sh 1>/dev/null;

cd ~/src/rate/base;
ls -l>>check_1.log$no;
mv check_1.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;


################
no=$(whoami|cut -c8);
cd ~/user/gucb/;
ps -ef|grep ./listent01.sh >>check_lis.log$no;
mv check_lis.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;

##########
no=$(whoami|cut -c8);
cd ~/user/gucb/;
nohup ./listent01.sh &

###########处理措施
1.停掉所有排重程序
2.等待所有话单都处理完后，停掉多有的批价程序
3.停掉安徽的入库程序
4.更换配置文件，更换批价程序
5.跑安徽挤压话单
6.话单入库
7.将配置文件，程序再次更换成最新的

########################
cd ~/user/gucb/llk_20140314;
rm manage_pro.sh;
cd  ~/user/gucb/;
rm  manage_pro.sh;


cd ~/user/gucb/llk_20140314;
cp manage_pro.sh ../;
cd ~/user/gucb/;
chmod 777 manage_pro.sh;

######################20140316############
cd ~/user/gucb/;
mkdir -p update_20130316;


###u16_02.sh
#备份配置文件、程序
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0316;
cd ~/;zip -r etc_bak0316.zip etc;
cd ~/user/gucb/gucb_bak0316;
cp ~/etc_bak0316.zip .;
cd ~/bin;
cp rate rate_0316;
cp smsremind smsremind_0316;
cd  ~/user/gucb/gucb_bak0316;
mv ~/bin/*_0316 .;

#解压源文件
cd  ~/user/gucb/update_20130316;
unzip src.zip;

#进行稽核
cd  ~/user/gucb/send_result;
touch check_bak_file16.log$no;
cd ~/user/gucb/gucb_bak0316;
ls -al >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;


cd ~/user/gucb/update_20130316;
echo "bak file ------" >> ~/user/gucb/send_result/check_bak_file16.log$no ;
ls -l >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###更新代码 u16_03.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/update_20130316;
sh get_code.sh 1>/dev/null;

cd ~/src/proc/;
ls -lrt>>check16_1.log$no;
mv check16_1.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;

##---停程序 u16_04.sh
ps -ef|grep rate|grep `whoami`|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
ps -ef|grep smsremind|grep `whoami`|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"

5 ok
7 ok
8 ok
6 ok
3 ok
4 ok
2 ok

#####程序发布流程
1.备份配置文件
2.备份程序
3.更新代码
4.停程序
5.编译程序
6.启动程序
7.测试程序
8.更改TFS状态
9.发总结邮件

##########u16_04.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/;
ps -ef|grep rate|grep `whoami`|grep 'c[0-9]\{4\}'>>check_channel.log$no
ps -ef|grep smsremind|grep `whoami`|grep 'c[0-9]\{4\}'>>check_channel.log$no
cd ~/bin;
ls -lrt>>check_pro.log$no
cd  ~/user/gucb/send_result/;
mv ~/bin/check_pro.log$no .;
mv  ~/user/gucb/check_channel.log$no;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

#################
no=$(whoami|cut -c8);
cd ~/etc/pp/;
mv 011_CBSS_VOICE_DEV.CFG  011_CBSS_VOICE_DEV.CFG_bak0317;
cp ~/user/gucb/update_20130316/011_CBSS_VOICE_DEV.CFG .;

cd ~/etc/pp/;
ls -la >> change.log$no;
cd ~/user/gucb/send_result/;
mv ~/etc/pp/ change.log$no .;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###########
no=$(whoami|cut -c8);
#cd ~/user/gucb/update_20130316/;
#unzip ligm.zip;
cd ~/etc/pp/;
cp ~/user/gucb/update_20130316/ligm/011_INTER_ROAM_GPRS_DEV.CFG .;
cp ~/user/gucb/update_20130316/ligm/011_INTER_ROAM_GSM_DEV.CFG .;
cd ~/etc/;
mv pp.cfg pp.cfg_bak0317;
cp  ~/user/gucb/update_20130316/ligm/etc_${no}/pp.cfg .;

no=$(whoami|cut -c8);
cd ~/etc/pp/;
ll *ROAM* >> t$no;
cd ~/user/gucb/send_result/;
mv ~/etc/pp/t$no .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;



indb -c8100
indb -c8000
indb -c8300
indb -c8500
indb -c8120
indb -c8520
indb -c8420
indb -c8200
indb -c8220
indb -c8320
indb -c8400

#####
1.停批价程序
2.待所有批价输出目录下话单处理完后停入库程序
3.更改入库配置文件
4.将话单放到入库输入目录下
5.起安徽入库程序
6.将配置文件改回


no=$(whoami|cut -c8);
cd ~/;
zip -r etc${no}_bak0319.zip etc;

cd ~/user/gucb/send_result/;
mv ~/etc${no}_bak0319.zip .;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###############2014-03-19程序发布#############
#u19_02.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p update_20130319;

#u19_03.sh
#备份配置文件、程序
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0319;
cd ~/;zip -r etc_bak0319.zip etc;
cd ~/user/gucb/gucb_bak0319;
cp ~/etc_bak0319.zip .;
cd ~/bin;
cp rate rate_0319;
cp filter filter_0319;
cd  ~/user/gucb/gucb_bak0319;
mv ~/bin/*_0319 .;

#解压源文件
cd  ~/user/gucb/update_20130319;
unzip src.zip;

#进行稽核
cd  ~/user/gucb/send_result;
touch check_bak_file16.log$no;
cd ~/user/gucb/gucb_bak0319;
ls -al >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;

#将检查结果ftp回本地
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##u19_04.sh 更新代码
no=$(whoami|cut -c8);
cd ~/user/gucb/update_20130319;
sed "s/_bak0316/_bak0319/g" < get_code.sh >tmp_sh;
mv tmp_sh get_code.sh;
sh get_code.sh 1>/dev/null;

cd ~/src/filter/app;
ls -lrt>>check19_2.log$no;
mv check19_2.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;

##编译分拣程序 先不提交
cd dbparam;
make clean;
make release;
make submit;
cd ../app;
make clean;
make release;

###编译程序
no=$(whoami|cut -c8);
cd ~/src/filter;
#rm nohup.out 2>/dev/null;
#cp ~/user/gucb/update_20130319/Make_filter_release.sh .;
nohup sh Make_filter_release.sh &
sleep 2;
tail nohup.out >>check_nohup.log$no;
mv check_nohup.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

#####编译分拣程序 先不提交 Make_rate_release.sh

cd base;
make clean;
make release;
make submit;
cd ../policy;
make clean;
make release;
make submit;
cd ../param;
make clean;
make release;
make submit;
cd ../local;
make clean;
make release;
make submit;
cd ../proc;
make clean
make release;
make submit;
cd ../JSParser;
make clean;
make release;
make submit;
cd ../app;
make clean;
make release;

##########
no=$(whoami|cut -c8);
cd ~/src/rate;
rm nohup.out 2>/dev/null;
cp ~/user/gucb/update_20130319/Make_rate_release.sh .;

nohup sh Make_filter_release.sh &
sleep 2;
tail nohup.out >>check_nohup.log$no;
mv check_nohup.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


##
no=$(whoami|cut -c8);
cd ~/bin/;
ls -lrt >> check_channel.log${no};
cd ~/user/gucb/send_result/;
mv ~/bin/check_channel.log${no} .;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

所有通道存放路径 ~/billdata/pp_yw/bak/zhouq/proc
##test11.sh
no=$(whoami|cut -c8);
cd ~/billdata/pp_yw/bak/zhouq/proc/;
cat config >> config_$no
cd ~/user/gucb/send_result/;
mv  ~/billdata/pp_yw/bak/zhouq/proc/config_$no .;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

####################2014-03-20程序更新###
#u20_01.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p update_20140320;


#u20_02.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0320;
cd ~/;zip -r etc_bak0320.zip etc;
cd ~/user/gucb/gucb_bak0320;
cp ~/etc_bak0320.zip .;
cd ~/bin;
cp rate rate_0320;
cp filter filter_0320;
cd  ~/user/gucb/gucb_bak0320;
mv ~/bin/*_0320 .;

#解压源文件
cd  ~/user/gucb/update_20140320;
unzip src.zip;

#进行稽核
cd  ~/user/gucb/send_result;
touch check_bak_file16.log$no;
cd ~/user/gucb/gucb_bak0320;
ls -al >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;

#将检查结果ftp回本地
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##u20_03.sh 更新代码
no=$(whoami|cut -c8);
cd ~/user/gucb/update_20140320;
##sed "s/_bak0316/_bak0319/g" < get_code.sh >tmp_sh;
##mv tmp_sh get_code.sh;
sh get_code.sh 1>/dev/null;

cd ~/src/filter/app;
ls -lrt>>check20_2.log$no;
mv check20_2.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;

###编译程序
no=$(whoami|cut -c8);
cd ~/src/filter;
sh ./Make_filter_release.sh >> compile_filter.log${no}
mv compile_filter.log${no} ~/user/gucb/send_result/;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

###
no=$(whoami|cut -c8);
cd ~/src/rate;
sh ./Make_rate_release.sh >> compile_rate.log${no};
mv compile_rate.log${no} ~/user/gucb/send_result/;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

cd ~/src/rate;
rm nohup.out ;
nohup sh Make_rate_release.sh &

cd ~/src/filter/app;
ps -ef|grep filter|grep 'c[0-9]\{4\}'
ps -ef|grep filter|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
ms;

cd ~/src/rate/app;
ps -ef|grep rate|grep 'c[0-9]\{4\}'
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
ms;

###########
##改脚本使用的前提是，程序都已经正确编译
cd ~/src/filter/app;
ps -ef|grep filter|grep 'c[0-9]\{4\}';
ps -ef|grep filter|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}";
ms;
cd ~/user/gucb/;
grep filter < ~/billdata/pp_yw/bak/zhouq/proc/config > start_proc.sh;
sh start_proc.sh;
sleep 2;
rm start_proc.sh;

cd ~/src/rate/app;
ps -ef|grep rate|grep 'c[0-9]\{4\}'
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
ms;
cd ~/user/gucb/;
grep rate < ~/billdata/pp_yw/bak/zhouq/proc/config > start_proc.sh;
sh start_proc.sh;
sleep 2;
rm start_proc.sh;

#####################

no=$(whoami|cut -c8);
cd ~/user/gucb/;
ps -ef|grep listen01.sh >> channel_check.log${no};

cd  ~/user/gucb/send_result;
mv ~/user/gucb/channel_check.log${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;




ps -ef|grep rate|grep 'c[0-9]\{4\}'
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
cd ~/user/gucb/;
grep rate < ~/billdata/pp_yw/bak/zhouq/proc/config > start_proc.sh;
sh start_proc.sh;
sleep 2;
#rm start_proc.sh;

U1n@i3v$e5r

####################3
cd ~/bin/;
mv rate rate_0321;
scp billing8@10.161.2.98:~/src/rate/app/rate .;

:/billing3/bude/syscomp/lib



###############
no=$(whoami|cut -c8);
cd ~/user/gucb/;
ls -lrt > tmp_0416_${no};
cd ~/user/gucb/send_result/;
mv ~/user/gucb/tmp_0416_${no} .; 

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

####################
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0429;
cd ~/user/gucb/gucb_bak0429;
cp ~/bin/filter .;
cp ~/bin/rate .;
cp ~/bin/smsremind .;

#备份文件：
cd ~/;zip -r etc_bak0429.zip etc;
cd ~/user/gucb/gucb_bak0429;
cp ~/etc_bak0429.zip .


no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0430;
cd ~/user/gucb/gucb_bak0430;
cp ~/bin/rate .;

#备份文件：
cd ~/;zip -r etc_bak0430.zip etc;
cd ~/user/gucb/gucb_bak0430;
cp ~/etc_bak0430.zip .

#########20140513版本发布
##程序，配置文件备份

no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0513;
cd ~/user/gucb/gucb_bak0513;
cp ~/bin/filter .;
cp ~/bin/rate .;
cp ~/bin/pp .;
cp ~/bin/smsremind .;
cp ~/bin/eventor .;
cp ~/bin/rr .;
cp ~/bin/redo .;
cp ~/bin/monthend .;

#备份文件：
cd ~/;zip -r etc_bak0513.zip etc;
cd ~/user/gucb/gucb_bak0513;
cp ~/etc_bak0513.zip .;

#检查，并将结果返回
cd ~/user/gucb/;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
cp ~/user/gucb/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

#######

no=$(whoami|cut -c8);
cd ~/user/gucb/tmp_0513;
ls -lrt >>c.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/tmp_0513/c.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###########发布程序
cd ~/user/gucb/;
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print $8" " $9}' >>rate_start.sh
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill 
sleep 15;

count=$(ps -ef|grep rate|grep 'c[0-9]\{4\}'|wc -l)
if [ "$count" -gt 0 ];then
sleep 30
fi

cd ~/bin/;
cp -f -r ~/user/gucb/tmp_0513/rate .;
cp -f -r ~/user/gucb/tmp_0513/smsremind .;
cp -f -r ~/user/gucb/tmp_0513/monthend .;

cd ~/user/gucb/;
chmod 777 rate_start.sh 
sh rate_start.sh

######

no=$(whoami|cut -c8);
cd ~/user/gucb/;
count=$(ps -ef|grep rate|grep 'c[0-9]\{4\}'|wc -l)
echo "$count" >> count.out_${no}

cd ~/user/gucb/send_result;
mv ~/user/gucb/count.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

#####
no=$(whoami|cut -c8);

cd ~/user/gucb/;
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print $8" " $9}' >>rate_start.sh
ps -ef|grep rate|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill 
sleep 15;

count=$(ps -ef|grep rate|grep 'c[0-9]\{4\}'|wc -l)
if [ "$count" -gt 0 ];then
sleep 30
fi


mkdir -p  ~/billdata/smsremind/bak/bak_0514
cd  ~/billdata/smsremind/bak/bak_0514


mv  ~/billdata/smsremind/bak/it000 .
mv  ~/billdata/smsremind/bak/it100 .
mv  ~/billdata/smsremind/bak/it200 .
mv  ~/billdata/smsremind/bak/it300 . 2>/dev/null
mv  ~/billdata/smsremind/bak/it400 . 2>/dev/null
mv  ~/billdata/smsremind/bak/it500 . 2>/dev/null

cd ~/billdata/smsremind/bak/;
mv ~/billdata/smsremind/it000 . 2>/dev/null
mv ~/billdata/smsremind/it100 . 2>/dev/null
mv ~/billdata/smsremind/it200 . 2>/dev/null
mv ~/billdata/smsremind/it300 . 2>/dev/null
mv ~/billdata/smsremind/it400 . 2>/dev/null
mv ~/billdata/smsremind/it500 . 2>/dev/null

cd  ~/billdata/smsremind
mkdir it000 2>/dev/null
mkdir it100 2>/dev/null 
mkdir it200 2>/dev/null
mkdir it300 2>/dev/null
mkdir it400 2>/dev/null
mkdir it500 2>/dev/null

cd ~/billdata/smsremind/bak/bak_0514;
ls -lrt >> e.out_${no}
cd ~/user/gucb/send_result;
mv ~/billdata/smsremind/bak/bak_0514/e.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

cd ~/user/gucb/;
chmod 777 rate_start.sh 
sh rate_start.sh 1>/dev/null

##程序，配置文件备份

no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0520;
cd ~/user/gucb/gucb_bak0520;
cp ~/bin/smsremind .;

#备份文件：
cd ~/;zip -r etc_bak0520.zip etc;
cd ~/user/gucb/gucb_bak0520;
mv ~/etc_bak0520.zip .;

#检查，并将结果返回
cd ~/user/gucb/;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
cp ~/user/gucb/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;



###
no=$(whoami|cut -c8);
cd ~/etc;
cd ~/user/gucb/send_result;

cd ~/user/gucb/;
mkdir -p tmp_0520;

cp ~/etc/b.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##
no=$(whoami|cut -c8);
cd ~/bin;
cp -f -r ~/user/gucb/tmp_0520/smsremind .;
chmod 775 smsremind ###一定记得加权限

cd ~/user;

ps -ef|grep smsremind|grep -v grep |awk '{print $2}'|xargs -n1 kill
####
no=$(whoami|cut -c8);
cd ~/user/gucb/send_result;
ps -ef|grep smsremind|grep -v grep > sms_check.log_${no}

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##########20140526版本发布###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0526;
cd ~/user/gucb/gucb_bak0526;

cp -p ~/bin/rate .;

#备份文件：
cd ~/;zip -r etc_bak0526.zip etc;
cd ~/user/gucb/gucb_bak0526;
mv ~/etc_bak0526.zip .;

#检查，并将结果返回
cd ~/user/gucb/gucb_bak0526;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0526/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

    产生该问题的原因可能是当时修正了计费参数或者程序版本更新

##########20140616版本发布###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0616;
cd ~/user/gucb/gucb_bak0616;

cp -p ~/bin/rate .;
cp -p ~/bin/redo .;
cp -p ~/bin/monthend .;

#备份文件：
cd ~/;zip -r etc_bak0616.zip etc;
zip -r bude_bak0616.zip bude;
cd ~/user/gucb/gucb_bak0616;
mv ~/etc_bak0616.zip .;
mv ~/bude_bak0616.zip .;

#检查，并将结果返回
cd ~/user/gucb/gucb_bak0616;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0616/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###
cp ~/bude/syscomp/lib 和 /billing8/bude/lang/lib 下的所有文件到各个域下
注意赋权 :chmod * 775

####
no=$(whoami|cut -c8);
cd ~/user/gucb/gucb_bak0616;
cp -r -p ~/bin .

cd ~/user/gucb/gucb_bak0616;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0616/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


no=$(whoami|cut -c8);
ps -ef|grep "billing${no}"|grep -v grep|grep 'c[0-9]\{4\}'|awk '{print $2}'|xargs -n1 kill 2>&1 >/dev/null
ps -ef|grep "billing${no}"|grep -v grep|grep "c${no}"|awk '{print $2}'|xargs -n1 kill  2>&1 >/dev/null 

#####
no=$(whoami|cut -c8);
cd ~/user/gucb;
mkdir -p tmp_0616;



##########   U1n@i3v$e5r
no=$(whoami|cut -c8);
ps -ef|grep "billing${no}"|grep -v grep|grep 'c[0-9]\{4\}'
ps -ef|grep "billing${no}"|grep -v grep|grep "c${no}"


cd  ~/bude/syscomp;mv lib lib_bak0616;
cd ~/bude/lang/;mv lib lib_bak0616;

cd  ~/bude/syscomp;
scp -r billing8@10.161.2.98:~/bude/syscomp/lib .;
cd lib ;chmod 775 *

cd ~/bude/lang/;
scp -r billing8@10.161.2.98:~/bude/lang/lib .;
cd lib;chmod 775 *



ps -ef|grep smsremind|grep -v grep

ps -ef|grep smsremind|grep -v grep|awk '{print $2}'|xargs -n1 kill

05.01 - 05.07 6
05.11 - 05.31 21
##########

no=$(whoami|cut -c8);
while read line; do
cd $line;
i=1
mon=02
end=$((`cal $mon 2014|xargs |awk '{print NF}'`-9))
while [ $i <= $end ];
do
	file1=2014${mon}${i}0
	file2=2014${mon}${i}0
	file3=2014${mon}${i}0
	echo *file1*
	echo *file1*
	echo *file1*
done
done <path

ps -ef|grep filter|grep 'c[0-9]\{2\}10'
ps -ef|grep filter|grep 'c[0-9]\{2\}10'|awk '{print $2}'|xargs -n1 kill


#######
存储使用情况  -> /bildata${no}  和 /billing${no}
进程情况 -> 
文件积压 ->




##########20140625版本发布###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0625;
cd ~/user/gucb/gucb_bak0625;

cp -p -r ~/bin .;

#备份文件：
cd ~/;zip -r etc_bak0625.zip etc;
cd ~/user/gucb/gucb_bak0625;
mv ~/etc_bak0625.zip .;

#检查，并将结果返回
cd ~/user/gucb/gucb_bak0625;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0625/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


##########20140629版本发布###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0629;
cd ~/user/gucb/gucb_bak0629;

cp -p -r ~/bin .;

#备份文件：
cd ~/;zip -r etc_bak0629.zip etc;
cd ~/user/gucb/gucb_bak0629;
mv ~/etc_bak0629.zip .;

#检查，并将结果返回
cd ~/user/gucb/gucb_bak0629;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0629/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


#######
no=$(whoami|cut -c8);
cd ~/user/gucb/tmp_0625
chmod 775 monthend 
cd ~/bin
cp -p -r -f ~/user/gucb/tmp_0625/monthend .

#检查，并将结果返回
cd ~/user/gucb/send_result;
ls -al ~/bin/monthend >check_pro.out_${no}
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


##########33
cd ~/etc
no=$(whoami|cut -c8);
sed "s/<8/<${no}/g;s/<\/8/<\/${no}/g;s/BOSS_DATA8/BOSS_DATA${no}/g" < send.cfg >tmp_send.cfg
mv tmp_send.cfg send.cfg


###########
no=$(whoami|cut -c8);
cd ~/etc
<send.cfg grep "BOSS_DATA${no}"|awk -F"=" '{print $2}'|awk -F"#" '{print $1}'|xargs -i sh -c "mkdir -p {}"


##########20140630版本发布###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0630;
cd ~/user/gucb/gucb_bak0630;

cp -p -r ~/bin/monthend .;

#备份文件：
cd ~/;zip -r etc_bak0630.zip etc;
cd ~/user/gucb/gucb_bak0630;
mv ~/etc_bak0630.zip .;

#检查，并将结果返回
cd ~/user/gucb/gucb_bak0630;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0630/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;



#######
no=$(whoami|cut -c8);
cd ~/user/gucb/tmp_0701
chmod 775 monthend 
cd ~/bin
cp -p -r -f ~/user/gucb/tmp_0701/monthend .

#检查，并将结果返回
cd ~/user/gucb/send_result;
ls -al ~/bin/monthend >check_pro.out_${no}
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


