����(heartbeat)
1.���壺��masterû��дbinlogʱ����heartbeat���Ա�slave֪��master�Ƿ�������
2.ȡֵ��Χ����λ�룬0 �� 4294967�롣��ȷ�ȿ��Դﵽ���룬��С�ķ�0ֵ��0.001�롣
3.����������master������binlog��־�ļ����趨�ļ��ʱ����û���յ��µ��¼�ʱ������
4.�����鿴��
--salve env
select heartbeat from mysql.slave_master_info;
--30
SHOW VARIABLES like '%slave_net_timeout%';
--60
ֵ��Ĭ��Ϊslave_net_timeout��ֵ����2������Ϊ0��ʾ��ȫ�Ľ���������

��������(master_heartbeat_period)
1.��λ���롣���ȣ�1 ���롣MySQL5.5��ʼ�ṩ�Ĳ�����
2.salve�Ƽ����ã�
mysql> stop slave;  
mysql> change master to master_heartbeat_period = 10;  
mysql> set global slave_net_timeout = 25;  
mysql> start slave;  
���壺
 Master ��û�����ݵ�ʱ��ÿ ��master_heartbeat_period ���ڣ�10 �룩����һ�������������� Slave ����֪�� Master �ǲ��ǻ�������
 slave_net_timeout �������ڶ��û�յ����ݺ���Ϊ���糬ʱ��֮�� Slave �� IO �̻߳��������� Master ��
 ������������þͿ��Ա��������������⵼�µĸ�������master_heartbeat_period ��
 ��ע����ǰmaster_heartbeat_period =Slave_heartbeat_period��
3.�����鿴
show status like  'Slave_heartbeat_period' 
SHOW STATUS LIKE '%heartbeat%';
Slave_heartbeat_period
Slave_last_heartbeat�����һ���յ�������ʱ��
Slave_received_heartbeats���ܹ��յ�����������

--���������鿴
show status like 'slave%'; 
SHOW VARIABLES like '%time%';


�ο����ϣ�
https://dev.mysql.com/worklog/task/?id=342
https://www.percona.com/blog/2011/12/29/actively-monitoring-replication-connectivity-with-mysqls-heartbeat/