create table TEST1111
(
  a         VARCHAR2(30)
)

--������
alter table TEST1111 add test varchar2(10);

--�޸���
alter table TEST1111 modify test varchar2(20);
alter table TEST1111 modify test null; --����Ϊ��
alter table TEST1111 modify test not null; --�ǿ�

--ɾ����
alter table TEST1111 drop column test;


select * from TEST1111;
drop table TEST1111 purge;

--��ѯ���������
select OWNER, TABLE_NAME, COLUMN_NAME
from all_tab_columns 
where table_name = 'BD_CORP';

--ͬ������
update CRMKH set id=BIRTHDAY ,BIRTHDAY=id where ����;
--oracle ��undo ֧���������ӻ���ˮ�ģ�����Ҫ���������ӡ�
update  crmkh a set a.birthday =a.sex ,a.sex=a.name, a.name=a.createcorp where ~~   --���н���

--��������
alter table tablename add constraint keyname primary key (columnName) enable validate; 
--ɾ������
alter table tablename drop constraint keyname;