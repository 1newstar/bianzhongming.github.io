--������ʹ�������ѯ
WITH Now AS
 (select count(*) connNum from v$process),
Allpro AS
 (select value connNum from v$parameter where name = 'processes')

select '��ǰ������' conn,to_char(connNum) from Now
union all
select '���������' conn,connNum from Allpro
union all
select 'ʹ����' conn,a.connNum/b.connNum*100||'%' connNum from Now a,Allpro b;

--���û�����Ļ����
select count(*),username from v$session where status='ACTIVE' group by username;


/*--����������޸�
show parameter processes 
alter system set processes = 300 scope = spfile; --�������ݿ������Ч
shutdown immediate
*/





