--1)����MM_PO_B���������ݣ�dr=1��
--99676122
--dr=1:79651788
Select Count(*) From MM_PO_B a Where a.dr=1;
--����ԭ�������ݱ�
create table MM_PO_B_bak140415 as select * from MM_PO_B;  ---775S
--truncateԭ���ı�
truncate table MM_PO_B��
--���dr=0�ı�
insert into /*+ append*/ MM_PO_B select * from MM_PO_B_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name='MM_PO_B';

---2)����IC_GENERAL_H����������
Select Count(*) From IC_GENERAL_H a Where a.dr=1;
--3289952
--dr=1:45513
--����ԭ�������ݱ�
create table IC_GENERAL_H_bak140415 NOLOGGING PARALLEL 4 as select * from IC_GENERAL_H;
----truncateԭ���ı�
truncate table IC_GENERAL_H��
select 'alter index '|| a.index_name ||' unusable;' from user_indexes a where a.table_name='IC_GENERAL_H';
--���dr=0�ı�
insert into /*+ append*/ IC_GENERAL_H select * from IC_GENERAL_H_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name='IC_GENERAL_H';

--3������IC_GENERAL_B����������
Select Count(*) From IC_GENERAL_b a Where a.dr=1;
--4327615
--dr=1:144390
--����ԭ�������ݱ�
create table IC_GENERAL_B_bak140415 as select * from IC_GENERAL_B;
----truncateԭ���ı�
truncate table IC_GENERAL_B��
select 'alter index '|| a.index_name ||' unusable;' from user_indexes a where a.table_name='IC_GENERAL_B';
--���dr=0�ı�
insert into /*+ append*/ IC_GENERAL_B select * from IC_GENERAL_B_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name='IC_GENERAL_B';


--4)����gl_voucher����������   
Select Count(*) From gl_voucher a Where a.dr=1;
----350347
--dr=1:103339
--����ԭ�������ݱ�
create table gl_voucher_bak140415 as select * from gl_voucher;
----truncateԭ���ı�
truncate table gl_voucher��
select 'alter index '|| a.index_name ||' unusable;' from user_indexes a where a.table_name='GL_VOUCHER';
--���dr=0�ı�
insert into /*+ append*/ gl_voucher select * from gl_voucher_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name='GL_VOUCHER';

--5)����gl_detail����������
Select Count(*) From gl_detail a Where a.dr=1;
----2697924
--dr=1:1656699
--����ԭ�������ݱ�
create table gl_detail_bak140415 as select * from gl_detail;
----truncateԭ���ı�
truncate table gl_detail
select 'alter index '|| a.index_name ||' unusable;' from user_indexes a where a.table_name='GL_DETAIL';
--���dr=0�ı�
insert into /*+ append*/ gl_detail select * from gl_detail_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name='GL_DETAIL';

--6)����Pub_Workflownote����������
Select Count(*) From Pub_Workflownote a Where a.dr=1;
--9182269
--dr=1:413060
--����ԭ�������ݱ�
create table Pub_Workflownote_bak140415 as select * from Pub_Workflownote;
----truncateԭ���ı�
truncate table Pub_Workflownote��
select 'alter index '|| a.index_name ||' unusable;' from user_indexes a where a.table_name=upper('Pub_Workflownote');
--���dr=0�ı�
insert into /*+ append*/ Pub_Workflownote select * from Pub_Workflownote_bak140415 where dr<>1;
---rebuild�ñ����������
select 'alter index '|| a.index_name ||' rebuild nologging;' from user_indexes a where a.table_name=upper('Pub_Workflownote');











--------------------------------------------------------------------------------------------------------------------------
select count(*) from mm_mo a where a.dr=1;
--1552993
--dr=1:81557

Select count(*) From PUB_WF_ACTINSTANCE a Where a.dr=1;
Select count(*) From IA_BILL_B a Where a.dr=1;
--3903063
--dr=1:1083156

Select count(*) From IA_BILL a Where a.dr=1;
--3162560
--dr=1:46287

Select count(*) From IC_GENERAL_BB1 a Where a.dr=1;
--3343749
--dr=1:27381


Select count(*) From MM_PICKM_B a Where a.dr=1;
--7476111
--dr=1:499974


Select count(*) From PUB_WF_TASK a Where a.dr=1;
--8109469
--dr=1:340



Select count(*) From PUB_WF_TASK a Where a.dr=1;
--8109469
--dr=1:340



Select count(*) From IA_PERIODACCOUNT a Where a.dr=1;
--8787712
--dr=1:0



Select count(*) From SM_OPERATELOG a Where a.dr=1;
--29622238
--dr=1:0


Select count(*) From PUB_WF_ACTINSTANCE a Where a.dr=1;
--13234087
--dr=1:540

Select count(*) From PUB_WF_ACTINSTANCESRC a Where a.dr=1;
--11204174
--dr=1:467


Select count(*) From IC_ATP_F a Where a.dr=1;
--10743474
--dr=1:0



