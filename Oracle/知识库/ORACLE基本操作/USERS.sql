--�����û�
create user USERNAME identified by ����;
grant create session to USERNAME; --����session��Ȩ�ޣ�û���޷���������
Grant connect,dba to USERNAME; --���Ȩ��

--��Ȩ grant #P on tablename to username;
--#P:all / select  / drop / insert(�ض��ֶΣ���ѡ) /  update(�ض��ֶΣ���ѡ) / alter all
select 'Grant all on '||table_name||'to user2 ;' from all_tables where owner = upper(user1);
e.g.
grant update on tablename to USERNAME; --�����޸ı��Ȩ��
grant update(id) on tablename to USERNAME;--�����ָ�����ض��ֶεĲ�����޸�Ȩ�ޣ�ע�⣬ֻ����insert��update
grant alter all table to USERNAME;--�����û�alter������Ȩ��
--����Ȩ��  �����﷨ͬgrant,�ؼ���Ϊrevoke

--�鿴�û����ɫϵͳȨ��(ֱ�Ӹ�ֵ���û����ɫ��ϵͳȨ��)��
select * from dba_sys_privs; --�鿴��ǰ�û�����Ȩ��
select * from user_sys_privs; --�鿴��ǰ�û���ӵ�е�Ȩ��
select * from user_tab_privs;--�鿴�����û��Ա��Ȩ��
--�鿴��ɫ(ֻ�ܲ鿴��½�û�ӵ�еĽ�ɫ)��������Ȩ��
sql>select * from role_sys_privs;

--�޸�����
alter user sys identified by ������;

--�����ͽ����û�
alter user test account lock;
alter user test account unlock;

--�鿴�����û���
select *��username�� from dba_users;   
select * from all_users;   
select * from user_users;

--�鿴�û�����Ȩ�ޣ�
select * from dba_tab_privs;   
select * from all_tab_privs;   
select * from user_tab_privs;

--ɾ���û�
SQL> drop user test cascade; 
drop user test cascade
*
ERROR at line 1:
ORA-01940: cannot drop a user that is currently connected
  --ͨ���鿴�û��Ľ��У���kill�û����̣�Ȼ��ɾ���û�
SQL> select sid,serial# from v$session where username='TEST';   --ע���û�����ĸ���ô�д
       SID    SERIAL#
---------- ----------
      1105        132
SQL> alter system kill session '1105,132';
System altered.
SQL> drop user ncv3 cascade;
User dropped.

��ORACLE 11G Ĭ������180��������á�
--ȷ��������oracle11g��Ĭ����default��Ҫ�ļ��������ˡ�PASSWORD_LIFE_TIME=180�족�����¡�
--������ں�ҵ������������ݿ��쳣��Ӱ��ҵ��ʹ�á�
1���鿴�û���proifle���ĸ���һ����default��
SELECT username,PROFILE FROM dba_users;
2���鿴ָ����Ҫ�ļ�����default����������Ч�����ã�
SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';
3����������Ч����Ĭ�ϵ�180���޸ĳɡ������ơ���
sql>ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
�޸�֮����Ҫ���������ݿ⣬��������Ч��
