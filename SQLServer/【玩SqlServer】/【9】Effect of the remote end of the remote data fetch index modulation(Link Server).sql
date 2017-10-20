--Զ�̵�ȡ����ʱԶ�̶�������Ӱ��
set statistics time on;
set statistics io on;

--REMOTE
sp_helpindex DataSync20170327
--The object 'DataSync20170327' does not have any indexes, or you do not have permissions.

select * FROM DEVDB.NJTESTDB.DBO.DataSync20170327 where INNERCODE between 1000298 and 1000300
/*
SQL Server �����ͱ���ʱ��: 
   CPU ʱ�� = 0 ���룬ռ��ʱ�� = 220 ���롣

(16181 ����Ӱ��)

 SQL Server ִ��ʱ��:
   CPU ʱ�� = 78 ���룬ռ��ʱ�� = 3908 ���롣
   */
------------REMOTE
/*
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(16181 ����Ӱ��)
Table 'DataSync20170327'. Scan count 5, logical reads 231209, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 3282 ms,  elapsed time = 1454 ms.*/


--REMOTE
create index I_DataSync20170327 on DataSync20170327(INNERCODE)

select * FROM DEVDB.NJTESTDB.DBO.DataSync20170327 where INNERCODE between 1000298 and 1000300
/*
SQL Server �����ͱ���ʱ��: 
   CPU ʱ�� = 0 ���룬ռ��ʱ�� = 0 ���롣
SQL Server �����ͱ���ʱ��: 
   CPU ʱ�� = 0 ���룬ռ��ʱ�� = 191 ���롣

(16181 ����Ӱ��)

 SQL Server ִ��ʱ��:
   CPU ʱ�� = 32 ���룬ռ��ʱ�� = 1087 ���롣
   */
------------REMOTE
/*
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(16181 ����Ӱ��)
Table 'DataSync20170327'. Scan count 1, logical reads 16221, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 47 ms,  elapsed time = 284 ms.
*/
--statistics������Զ�̵��õľ�����Ϣ�����Ƕ�β���Զ�˽���������Ч�ʵ�ȷ����ˡ�


----�����淨
ִ��һ�����Ӳ�ѯ���鿴ִ�мƻ�
Remote Query(SOURCE:(DEVDB), QUERY:(SELECT "Tbl1001"."TRADE_DATE" "Col1038","Tbl1001"."PRE_CLOSE_PRICE" "Col1039" FROM "NJTESTDB"."DBO"."DataSync20170327" "Tbl1001" WHERE "Tbl1001"."TRADE_DATE"<convert(date, '2014-11-18') AND "Tbl1001"."innercode"=?))	
--REMOTE  ����SQL
select   request_session_id  spid,OBJECT_NAME(resource_associated_entity_id) tableName 
from   sys.dm_tran_locks with(nolock) where resource_type='OBJECT'
and OBJECT_NAME(resource_associated_entity_id)='DataSync20170327'
--65
select spid,text from sys.sysprocesses a with(nolock) 
cross apply sys.dm_exec_sql_text(sql_handle)
where spid in(65)
--TEXT
(@P1 int)SELECT "Tbl1004"."TRADE_DATE" "Col1026","Tbl1004"."PRE_CLOSE_PRICE" "Col1027" FROM "NJTESTDB"."DBO"."DataSync20170327" "Tbl1004" WHERE "Tbl1004"."TRADE_DATE"<convert(date, '2014-11-18') AND "Tbl1004"."innercode"=@P1

--���ۣ�Զ��ץȡSQL������ǽ���Զ�̷��������ܵģ������ϲ�������������Զ�̽����������LinkServer��ȡ���ݿ����ݵ�Ч�ʲ���Ӱ��ġ�


