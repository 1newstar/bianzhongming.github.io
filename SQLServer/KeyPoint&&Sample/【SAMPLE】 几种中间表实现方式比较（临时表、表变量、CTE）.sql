--��sqlserver�� �����м��ʵ�ַ�ʽ�Ƚϣ���ʱ���������CTE��
 
/*
��ʱ��
�ں�����#��ͷ�ľֲ���ʱ����##��ͷ��ȫ����ʱ��
�洢�������tempdb���ݿ⣨���� �ֲ���ʱ��ȫ����ʱ����
������
    �ֲ���ʱ���Ե�ǰ������Ч��ֻ�ڴ������Ĵ洢���ȡ���������̬�������Ч��������C�����оֲ�������������
    ȫ����ʱ�����������Ӷ�������������ʱ���ᱻɾ�����Դ�������˵���Ͽ����Ӿ��ǽ������ã��ԷǴ����ߣ��������þ��ǽ������á�
���������󣬾�ͨ��drop  table ���ɾ������ʱ�ͷ���Դ��
���ԣ��ܺ���ͨ��һ������Լ���ʹ��������������ݷֲ���ͳ����Ϣ����������ͨ�ı�һ����
ʹ�ó�����������Сֱ�ӵ����м��ʹ�ã��������ϴ����ͨ���Ż���߲�ѯЧ�ʣ����ڸ��ӵĲ�ѯ���Խ��м���������ʱ�����Թ̻�ִ�мƻ���ר��ִ�мƻ��ߴ�
*/
--DEMO
 --�����ж�
if ( object_id('tempdb..#t') is not null)
DROP TABLE #t
GO
--���������
select top 100000 * into #t from testbzm
--������
select top 10 * from #t
create index IDX_T_ID on #t(update_time) WITH(ONLINE=OFF,FillFactor=90) --ONLINE=ON�������ܴ������ؽ���ɾ�����ϱ�����ʱ���ϵ�����������ִ������������
--WITH(ONLINE=ON,FillFactor=90)
SET STATISTICS PROFILE ON --ִ�мƻ����ı���
select * from #t where update_time = '20160101' 
--explain plan
  --Nested Loops(Inner Join, OUTER REFERENCES:([Bmk1000]))
       --Index Seek(OBJECT:([tempdb].[dbo].[#t]), SEEK:([tempdb].[dbo].[#t].[UPDATE_TIME]='2016-01-01 00:00:00.000') ORDERED FORWARD)
       --RID Lookup(OBJECT:([tempdb].[dbo].[#t]), SEEK:([Bmk1000]=[Bmk1000]) LOOKUP ORDERED FORWARD)
--��������
drop table #t
SET STATISTICS PROFILE OFF


/*  
�����
�洢������������tempdb���ݿ��С�
�����򣺺���ͨ�ı���һ�����ڶ��������Ĵ洢���̡���������̬��䡢��������ʱ�����Զ������
���ԣ�������������������ֱ�Ӵ���������Ҳû���κ����ݵ�ͳ����Ϣ��
ʹ�ó�����С���������������ڣ�
ע�⣺��������������Լ���������DEMO����ʾ��
*/
--DEMO �����
declare @tb table(id int primary key,val1 varchar(10))

begin tran  
    insert into @tb values (1,'aa'),(2,'bb'),(3,'cc') 
rollback tran  

select count(1) from @tb ; --3
--�����û��rollback

begin tran  
    delete from @tb where id=1 
rollback tran 
 
select count(1) from @tb  --2
--�����û��rollback
   
   
/*
CTE
�ں���ͨ�ñ��ʽ��
���棺��ȷ������Щ���֣�������ѻ���������ݴ洢��tempdb��worktable��workfile�У����⣬һЩ���hash join�����������Ҳ����м����ݴ洢��tempdb��
������CTE�µ�һ��SQL��������ò��ˣ�
ʹ�ó������ݹ飬SQL�߼������ظ��Ĳ���д��CTE���棬�ܼ���SQL��������SQL�����ԺͿɶ��ԣ�
ע�⣺SQL�߼�����д�����̶ܹ�ִ�мƻ����߼��м��ʵ�ʽ�������һ��SQL��
*/
--DEMO
--SQL�߼���
--SQL A
select * from 
(select id,name from testbzm where UPDATE_TIME >'2015-01-01') a 
join (select id,name from testbzm where UPDATE_TIME >'2015-01-01' and dr=1) b on a.id=b.id
join (select id,name from testbzm where UPDATE_TIME >'2015-01-01' and dr=1 and name like 'H%') c on a.id=c.id
/*SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(972 ����Ӱ��)
Table 'testbzm'. Scan count 15, logical reads 8850, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 79 ms,  elapsed time = 216 ms.
*/ 

--SQL�߼��ȼ�ת��==>SQL B
with cte_testtb as ( 
select id,name,dr from testbzm where UPDATE_TIME >'2015-01-01'
) --Ҳ����ͬʱ���������ö��Ÿ�������
select * from 
cte_testtb a 
join (select id,name from cte_testtb where dr=1) b on a.id=b.id
join (select id,name from cte_testtb where dr=1 and name like 'H%') c on a.id=c.id
/*SQL Server parse and compile time: 
   CPU time = 16 ms, elapsed time = 56 ms.

(972 ����Ӱ��)
Table 'testbzm'. Scan count 15, logical reads 8850, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 79 ms,  elapsed time = 369 ms.
*/
--ִ�мƻ����첻��

drop table testbzm

