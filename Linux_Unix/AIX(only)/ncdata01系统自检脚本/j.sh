#
# ���屨��ͷ
#
report_header()
{
HOSTIP=$(ifconfig -a | sed -n '2p' |awk '{print $2}')
HOSTNAME=$(hostname)
cat<<!
Hostname: $HOSTNAME       Server: $HOSTIP
Time: $(date +%Y'-'%m'-'%d' '%H':'%M':'%S)

                                 SYSTEM CHECK REPORT
                                 ===================
 
!
}

#
# ������־�ļ���ŵ�Ŀ¼����־�ļ���������ǰ�û�Ŀ¼����ΪLOG_PATH
#
LOG_PATH=/zj
LOG_FILE=$LOG_PATH/`date +%m%d%H`_nc1.log
#
# �������ͷ��Ϣ
#
report_header >$LOG_FILE

# ��� CPU��ʹ
echo "***************************************** Check CPU *****************************************">>$LOG_FILE
vmstat 1 10 | awk '{print $0;if($1 ~ /^[0-9].*/) (totalcpu+=$16);(avecpu=100-totalcpu/10)}; END {print "The average usage of cpu is :"avecpu}' >/zj/cpu_info

cat /zj/cpu_info >>$LOG_FILE

cpu_used_pct=`cat /zj/cpu_info | grep "The average usage of cpu is" |awk -F ":" '{print $2}' `
if [ "$cpu_used_pct" -gt "50" ] ; then
    echo "LOG-Warnning:`date +%Y'-'%m'-'%d' '%H':'%M':'%S`, CPU���س�����ֵ���ã�����ϵͳ!!">>$LOG_FILE
else
 echo "\t\t\t\t CPU��������!!">>$LOG_FILE
fi


#
# �ڴ�ʹ�ü�أ�������������ʹ��������
#                               
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check memory useage *****************************************">>$LOG_FILE
cat /zj/cpu_info  | awk '{print $0;if($1 ~ /^[0-9].*/) (totalpi+=$6)(totalpo+=$7)};\
END {if(totalpi<10 && totalpo<10) print "\t\t\t\tMemory��������!!"; if(totalpi>10 || totalpo>10) print "Memory�����쳣������ϵͳ!!"} '>>$LOG_FILE 

#
# �����̿ռ�.
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check disk space *****************************************">>$LOG_FILE
df -g >>$LOG_FILE
df -g |grep -v proc |grep -v Filesystem |awk '{x=1*$4}{print $1","$2","$3","$4","$5","$6","$7}'>/zj/disk_info

cat /zj/disk_info| grep -v '^#' | while read line
do
item1=$(echo $line | awk -F ',' '{print $1}')
item2=$(echo $line | awk -F ',' '{print $2}')
item3=$(echo $line | awk -F ',' '{print $3}')
item4=$(echo $line | awk -F ',' '{print $4}' |awk -F '%' '{print $1}')
item5=$(echo $line | awk -F ',' '{print $5}')
item6=$(echo $line | awk -F ',' '{print $6}')
item7=$(echo $line | awk -F ',' '{print $7}')
if [ "$item4" -gt "80" ]; then
    echo "LOG-Warnning: `date +%Y'-'%m'-'%d' '%H':'%M':'%S`, ����$item7\tʣ��ռ䲻�㣬�봦��!!" >>$LOG_FILE
else
    echo "\t\t\t\t ���̿ռ�$item7\t\tʹ������!!" >>$LOG_FILE
fi
done
#
# �����̵�io���м�أ�iostat
# 
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check iostat *****************************************">>$LOG_FILE
iostat 1 3 >>$LOG_FILE

#
# �������������м�أ������������һ�������б���ÿ������ping��������Ƿ���ͨ��
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check netstat *****************************************">>$LOG_FILE
netstat -i >>$LOG_FILE

#
# ��������ĸ澯��־ 
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check system err *****************************************">>$LOG_FILE
errpt | head -10 >>$LOG_FILE


#
# ���HA�������Ƿ�����                
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check HACMP status *****************************************">>$LOG_FILE
lspv >> $LOG_FILE

#
# ���ntpd�������Ƿ�����                
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check ntpd status *****************************************">>$LOG_FILE
lssrc -ls xntpd >> $LOG_FILE

#
# ���CRS�������Ƿ�����                
#
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check HACMP CRS *****************************************">>$LOG_FILE
cd /
./oracle/product/10.2/crs/bin/crs_stat -t >>$LOG_FILE

#
# ������ݿ����.   
#                                   
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check oracle process *****************************************">>$LOG_FILE
ps -ef|grep ora_|grep -v grep >> $LOG_FILE


#
# ������ݿ��������.   
#                                   
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check oracle listener *****************************************">>$LOG_FILE
ps -ef|grep -i listener|grep -v grep >>$LOG_FILE


#
# ������ݿ�alert.   
#                                   
echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check oracle alert *****************************************">>$LOG_FILE
tail -100 /oracle/admin/nc/bdump/alert_nc1.log |grep ORA->>$LOG_FILE
tail -100 /oracle/admin/nc/bdump/alert_nc1.log |grep WARNING>>$LOG_FILE


echo >>$LOG_FILE
echo >>$LOG_FILE
echo "***************************************** check backup  *****************************************">>$LOG_FILE
ls -l /back/ncv502/iufoautobak1.dmp /back/ncv502/autobak1.dmp.gz>>$LOG_FILE 
tail -1 /back/ncv502/iufoautobak.log>>$LOG_FILE 
tail -1 /back/ncv502/v5autobak.log>>$LOG_FILE 
tail -1 /back/ncv502/interface.log>>$LOG_FILE 


FTP_FILE=`date +%m%d%H`_nc1.log

ftp -i -in  << !!!
open 172.19.100.115 21 
user ncv5 ncv5_123 
lcd /zj
cd log

put $FTP_FILE
bye

!!!
