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

#���ݳ���
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

#�����ļ���
cd ~/;zip -r etc_bak0314.zip etc;
cd ~/user/gucb/gucb_bak0314;
cp ~/etc_bak0314.zip .;

#���л���
cd  ~/user/gucb/gucb_bak0314;
ls -al >> check_bak_file.log$no ;
mv check_bak_file.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


############���򷢲�
1-7 ���ϵ�send_code.sh ������һ��С���� echo cp $src_c $des_c;



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

###########�����ʩ
1.ͣ���������س���
2.�ȴ����л������������ͣ�����е����۳���
3.ͣ�����յ�������
4.���������ļ����������۳���
5.�ܰ��ռ�ѹ����
6.�������
7.�������ļ��������ٴθ��������µ�

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
#���������ļ�������
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

#��ѹԴ�ļ�
cd  ~/user/gucb/update_20130316;
unzip src.zip;

#���л���
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


###���´��� u16_03.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/update_20130316;
sh get_code.sh 1>/dev/null;

cd ~/src/proc/;
ls -lrt>>check16_1.log$no;
mv check16_1.log$no ~/user/gucb/send_result/;
cd ~/user/gucb/;sh ftp_send.sh;
cd ~/user/gucb/send_result;rm * 2>/dev/null;

##---ͣ���� u16_04.sh
ps -ef|grep rate|grep `whoami`|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"
ps -ef|grep smsremind|grep `whoami`|grep 'c[0-9]\{4\}'|awk '{print$2}'|xargs -i sh -c "kill {}"

5 ok
7 ok
8 ok
6 ok
3 ok
4 ok
2 ok

#####���򷢲�����
1.���������ļ�
2.���ݳ���
3.���´���
4.ͣ����
5.�������
6.��������
7.���Գ���
8.����TFS״̬
9.���ܽ��ʼ�

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
1.ͣ���۳���
2.�������������Ŀ¼�»����������ͣ������
3.������������ļ�
4.�������ŵ��������Ŀ¼��
5.�𰲻�������
6.�������ļ��Ļ�


no=$(whoami|cut -c8);
cd ~/;
zip -r etc${no}_bak0319.zip etc;

cd ~/user/gucb/send_result/;
mv ~/etc${no}_bak0319.zip .;

cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###############2014-03-19���򷢲�#############
#u19_02.sh
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p update_20130319;

#u19_03.sh
#���������ļ�������
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

#��ѹԴ�ļ�
cd  ~/user/gucb/update_20130319;
unzip src.zip;

#���л���
cd  ~/user/gucb/send_result;
touch check_bak_file16.log$no;
cd ~/user/gucb/gucb_bak0319;
ls -al >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;

#�������ftp�ر���
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##u19_04.sh ���´���
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

##����ּ���� �Ȳ��ύ
cd dbparam;
make clean;
make release;
make submit;
cd ../app;
make clean;
make release;

###�������
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

#####����ּ���� �Ȳ��ύ Make_rate_release.sh

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

����ͨ�����·�� ~/billdata/pp_yw/bak/zhouq/proc
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

####################2014-03-20�������###
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

#��ѹԴ�ļ�
cd  ~/user/gucb/update_20140320;
unzip src.zip;

#���л���
cd  ~/user/gucb/send_result;
touch check_bak_file16.log$no;
cd ~/user/gucb/gucb_bak0320;
ls -al >> ~/user/gucb/send_result/check_bak_file16.log$no ;
mv check_bak_file16.log$no ~/user/gucb/send_result/;

#�������ftp�ر���
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

##u20_03.sh ���´���
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

###�������
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
##�Ľű�ʹ�õ�ǰ���ǣ������Ѿ���ȷ����
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

#�����ļ���
cd ~/;zip -r etc_bak0429.zip etc;
cd ~/user/gucb/gucb_bak0429;
cp ~/etc_bak0429.zip .


no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0430;
cd ~/user/gucb/gucb_bak0430;
cp ~/bin/rate .;

#�����ļ���
cd ~/;zip -r etc_bak0430.zip etc;
cd ~/user/gucb/gucb_bak0430;
cp ~/etc_bak0430.zip .

#########20140513�汾����
##���������ļ�����

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

#�����ļ���
cd ~/;zip -r etc_bak0513.zip etc;
cd ~/user/gucb/gucb_bak0513;
cp ~/etc_bak0513.zip .;

#��飬�����������
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


###########��������
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

##���������ļ�����

no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0520;
cd ~/user/gucb/gucb_bak0520;
cp ~/bin/smsremind .;

#�����ļ���
cd ~/;zip -r etc_bak0520.zip etc;
cd ~/user/gucb/gucb_bak0520;
mv ~/etc_bak0520.zip .;

#��飬�����������
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
chmod 775 smsremind ###һ���ǵü�Ȩ��

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

##########20140526�汾����###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0526;
cd ~/user/gucb/gucb_bak0526;

cp -p ~/bin/rate .;

#�����ļ���
cd ~/;zip -r etc_bak0526.zip etc;
cd ~/user/gucb/gucb_bak0526;
mv ~/etc_bak0526.zip .;

#��飬�����������
cd ~/user/gucb/gucb_bak0526;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0526/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;

    �����������ԭ������ǵ�ʱ�����˼ƷѲ������߳���汾����

##########20140616�汾����###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0616;
cd ~/user/gucb/gucb_bak0616;

cp -p ~/bin/rate .;
cp -p ~/bin/redo .;
cp -p ~/bin/monthend .;

#�����ļ���
cd ~/;zip -r etc_bak0616.zip etc;
zip -r bude_bak0616.zip bude;
cd ~/user/gucb/gucb_bak0616;
mv ~/etc_bak0616.zip .;
mv ~/bude_bak0616.zip .;

#��飬�����������
cd ~/user/gucb/gucb_bak0616;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0616/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


###
cp ~/bude/syscomp/lib �� /billing8/bude/lang/lib �µ������ļ�����������
ע�⸳Ȩ :chmod * 775

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
�洢ʹ�����  -> /bildata${no}  �� /billing${no}
������� -> 
�ļ���ѹ ->




##########20140625�汾����###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0625;
cd ~/user/gucb/gucb_bak0625;

cp -p -r ~/bin .;

#�����ļ���
cd ~/;zip -r etc_bak0625.zip etc;
cd ~/user/gucb/gucb_bak0625;
mv ~/etc_bak0625.zip .;

#��飬�����������
cd ~/user/gucb/gucb_bak0625;
ls -lrt >>a.out_${no}
cd ~/user/gucb/send_result;
mv ~/user/gucb/gucb_bak0625/a.out_${no} .;
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


##########20140629�汾����###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0629;
cd ~/user/gucb/gucb_bak0629;

cp -p -r ~/bin .;

#�����ļ���
cd ~/;zip -r etc_bak0629.zip etc;
cd ~/user/gucb/gucb_bak0629;
mv ~/etc_bak0629.zip .;

#��飬�����������
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

#��飬�����������
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


##########20140630�汾����###
no=$(whoami|cut -c8);
cd ~/user/gucb/;
mkdir -p gucb_bak0630;
cd ~/user/gucb/gucb_bak0630;

cp -p -r ~/bin/monthend .;

#�����ļ���
cd ~/;zip -r etc_bak0630.zip etc;
cd ~/user/gucb/gucb_bak0630;
mv ~/etc_bak0630.zip .;

#��飬�����������
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

#��飬�����������
cd ~/user/gucb/send_result;
ls -al ~/bin/monthend >check_pro.out_${no}
cd ~/user/gucb/;
sh ftp_send.sh;
cd ~/user/gucb/send_result;
rm * 2>/dev/null;


