--�� Microsoft SQL Server Management Studio �У�
--1. ����->ѡ��->Designers->������������ݿ������->������ֹ����Ҫ�����´�����ĸ��ġ���ѡ��Ĺ�ȥ��
--2. �Ҽ�������Ҫ���ĵ����ݱ���ѡ����ơ���Ȼ���ڱ��������������϶����е�λ�ã���󱣴漴�ɡ�

--SQL��
--Move
select * into test_bzm  from house_spider_new_sohu

--check
select count(1) from test_bzm --4614
select count(1) from house_spider_new_sohu --4614

--*****First Copy DDL SQL
--drop
drop table house_spider_new_sohu;

--create && Edit
CREATE TABLE dbo.house_spider_new_sohu();

--Insert
--columns
SELECT
	t.[name] ����,
c.name+',' ����
FROM
	sys.tables AS t,
sys.columns as c
WHERE
	t.object_id=c.object_id
and t.[name] ='test_bzm'
--do
SET IDENTITY_INSERT dbo.[house_spider_new_sohu] ON
insert into house_spider_new_sohu
( --����
ID,
HOUSE_SRN,
HOUSE_NAME
--TMSTAMP
)
(
select 
ID,
HOUSE_SRN,
HOUSE_NAME
--TMSTAMP
from test_bzm
)
SET IDENTITY_INSERT dbo.[house_spider_new_sohu] OFF

--check
select count(1) from house_spider_new_sohu --4614
--clear
drop table test_bzm



