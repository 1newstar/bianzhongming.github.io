create table T
(
  unitname VARCHAR2(200) not null,
  unitcode VARCHAR2(40) 
)

--�������ݷ�ʽ
--way 1
insert into t (select unitname,unitcode from bd_corp);
--way 2
insert into t (unitname,unitcode) values('J001','001');--ֻ�ܵ����������ݣ�values������select
--ȱʡ�ֶ�
insert into t (unitname) (select unitname from bd_corp);  insert into t (unitname) values('J001');--���Բ�����δ�����ֶ�Ĭ��NULL
insert into t (unitcode) (select unitcode from bd_corp); insert into t (unitcode) values('001');--���ɲ�������Ϊ�ֶ�����not null

drop table t purge;



