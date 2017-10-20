--����������
select INDEX_NAME,TABLE_NAME from dba_indexes where table_name ='BD_CORP';
--dba_indexes�������û��Ķ���,user_indexes:��ǰ�û�����

--DDL����ȡ
--INDEX
SELECT INDEX_NAME,TABLE_NAME,TABLE_OWNER,DBMS_METADATA.get_ddl('INDEX',INDEX_NAME,'NCV502') INDEX_DDL
   FROM user_indexes --��ǰ�û��µ�����
 WHERE table_name = 'BD_CORP';
--Table 
SELECT owner,table_name,tablespace_name,DBMS_METADATA.GET_DDL('TABLE', table_name, 'NCV502') TABLE_DDL
  from dba_tables
 WHERE table_name = 'BD_CORP';
--tablespace
SELECT tablespace_name,DBMS_METADATA.GET_DDL('TABLESPACE', tablespace_name)
  FROM DBA_TABLESPACES;
--User
SELECT username,DBMS_METADATA.GET_DDL('USER',username) 
 FROM DBA_USERS;
--�õ�һ���û��µ����б��������洢���̵�ddl
SELECT DBMS_METADATA.GET_DDL(U.OBJECT_TYPE, u.object_name)
FROM USER_OBJECTS u
where U.OBJECT_TYPE IN ('TABLE','INDEX','PROCEDURE');

--����ռ䡿ִ�в�ѯ�������һ���������б�ռ�Ĵ������
select 'select dbms_metadata.get_ddl(' || '''TABLESPACE''' || ',' || '''' ||
       tablespace_name || '''' || ') from dual ;'
  from dba_data_files
 group by tablespace_name