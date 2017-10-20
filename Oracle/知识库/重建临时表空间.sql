select name from v$tempfile;
--C:\ORACLE\PRODUCT\10.2.0\ORADATA\ORCL\TEMP01.DBF

--������ת��ʱ��ռ�
create TEMPORARY TABLESPACE TEMP2 TEMPFILE 'C:\ORACLE\PRODUCT\10.2.0\ORADATA\ORCL\TEMP02.DBF' SIZE 1024M REUSE AUTOEXTEND ON NEXT 1024K MAXSIZE 5120M; 
--�ı�ȱʡ��ʱ��ռ� Ϊ�ոմ���������ʱ��ռ�temp2
alter database default temporary tablespace temp2;
--ɾ��ԭ����ʱ��ռ�
drop tablespace temp including contents and datafiles;

--���´�����ʱ��ռ�
create TEMPORARY TABLESPACE TEMP TEMPFILE 'C:\ORACLE\PRODUCT\10.2.0\ORADATA\ORCL\TEMP01.DBF' SIZE 100M REUSE AUTOEXTEND ON NEXT 1024K MAXSIZE 5120M; 

--����ȱʡ��ʱ��ռ�Ϊ�½���temp��ռ�
alter database default temporary tablespace temp; 

--ɾ����ת����ʱ��ռ�
drop tablespace temp2 including contents and datafiles;

--����ָ���û���ռ�Ϊ�ؽ�����ʱ��ռ�
alter user zxd temporary tablespace temp;
  
--������ʱ��ռ�����������Ը�����ɡ� 
--�����ǲ�ѯ��sort������ʹ�õ�ִ�к�ʱ��SQL:
Select se.username,se.sid,su.extents,su.blocks*to_number(rtrim(p.value))as    Space,tablespace,segtype,sql_text
from v$sort_usage su,v$parameter p,v$session se,v$sql s
where p.name='db_block_size' and su.session_addr=se.saddr and s.hash_value=su.sqlhash and s.address=su.sqladdr
order by se.username,se.sid
--�������������ٲ鿴����ʱ�á�