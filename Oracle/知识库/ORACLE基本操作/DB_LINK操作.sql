--��ѯ
select * from ALL_DB_LINKS;  --��ϸ
select owner,object_name from dba_objects where object_type='DATABASE LINK';
--����
CREATE USER test IDENTIFIED BY test DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE temp;--�û�
grant connect,create public database link,create database link to test; --����DB_LINK��Ȩ

create database link mytestlink 
  connect to ecology identified by ecology --���������ּ�"" 
  using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.19.100.181)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = tloa)
    )
  )';

--ʹ��
select * from workflow_titleSet@mytestlink  

--ɾ��
drop /* public*/ database link MYTESTLINK;

--drop user test cascade;



---===============
--��������(71)
vi /oracle/ora10g/product/db/network/admin/tnsnames.ora
-----
NC1=
(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.19.100.121)(PORT=1521)))(CONNECT_DATA=(SID=nc1)(SERVER=DEDICATED)))
------
conn ncv502/*** 
create database link testLink connect to ncv502 identified by tesiro_nc502 using 'RAC71' ;
select unitname from bd_corp@testLink;  
