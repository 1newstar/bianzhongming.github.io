--�洢����
--===����&�����������޲δ洢���̣�
--1�����洢����
create procedure BZMtest
as
select * from sys_table where name_en='bond' or node_cd='N06'
--2ִ�д洢����
execute bzmtest --���Ʋ����ִ�Сд
--3�Ƴ��洢����
drop procedure bzmtest
go

--===�����
select * from sys_table where name_en='bond' or node_cd='N06'
--����
create proc bzmtest  -- create procedure=create proc
( @name_en varchar(10),
 @node_cd varchar(10)
)
as 
select * from sys_table where name_en=@name_en or node_cd= @node_cd
--����
exec bzmtest 'bond','N06'--ֱ��˳�򴫲�
exec bzmtest @node_cd='N06' ,@name_en='bond'--ָ������

--===�������
select table_id from sys_table where name_en='bond' or node_cd='N06'
--����
create proc bzmtest  
( @name_en varchar(10),
 @node_cd varchar(10),
 @table_id varchar(10) output   --���Ρ����μӱ�ʶ��output����
)
as 
select @table_id=table_id from sys_table 
where name_en=@name_en or node_cd= @node_cd
--����
declare @table_id2 varchar(10)
exec bzmtest @name_en='bond',@node_cd='N06' ,@table_id=@table_id2 output
select @table_id2
--ֻ�ܴ�һ����ֵ


--====�����ݴ��ݣ������м��
create proc bzmtest  -- create procedure=create proc
( @name_en varchar(10),
 @node_cd varchar(10)
)
as 
select table_id,NAME_CN,name_en from sys_table where name_en=@name_en or node_cd= @node_cd
go
--���������ʱ��
create proc p_test @name_en1 varchar(10), @node_cd1 varchar(10)
as
set nocount on --�Ż��洢����

if exists(select * from sysobjects where xtype in ('S','U') and name='testbzm')
drop table testbzm
else
create table testbzm(table_id varchar(10),NAME_CN varchar(500),name_en varchar(500))
insert into testbzm
exec bzmtest @name_en=@name_en1,@node_cd=@node_cd1
go
--ִ��
exec p_test @node_cd1='N06' ,@name_en1='bond'
select * from testbzm
--����
drop procedure bzmtest
drop procedure p_test
drop table testbzm

--=================
--ѭ��
declare @i int
set @i = 0
while @i < 100
begin
  update table set column = @i where ID_column = @i
  set @i = @i + 1
end