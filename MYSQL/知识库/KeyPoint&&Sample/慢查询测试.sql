-- ����ѯ����
1. ���壺��¼����ʱ����ֵ��SQL��䡣������¼����ʱ�䣩
2.����
slow_query_log :�Ƿ�������ѯ��¼����
slow_query_log_file :����ѯ��¼��־���λ��
long_query_time:ʱ����ֵ����ѯ����������ż�¼��
3.������ѯ�������޸�
-- ��ѯ
show VARIABLES like "%slow%"; 
show variables like "long_query_time";
-- ���
��������ѯ��
set global slow_query_log='ON';
��������ѯ��־��ŵ�λ�ã�
set global slow_query_log_file='/usr/local/mysql/log/slow.log';
����ʱ����ֵ��--Mysql 5.6+������Ч
set global long_query_time=2; 
���ױ�����ã��޸������ļ�my.cnf��������Ч��
[mysqld]
slow_query_log = ON
slow_query_log_file='/usr/local/mysql/log/slow.log'
long_query_time = 2
log_queries_not_using_indexes = ON ###��¼��û��ʹ��������query���������������ʱ����ֵ��Ч

mysql> select sleep(3); #�ӳ�2��ִ�� 

-- test SQL 1
START TRANSACTION;
select sleep(0.5);
insert into testi values(1,'hehea');
select sleep(0.5);
COMMIT;
--δ����¼����ѯ

