---------- Mysql ����SETֵ��
set @i =100;/set @i:=100;/select @i:=101
set @i =100,@j=100;  -- �ɶ������ֵ

---------- sqlserver ����SETֵ��
declare @i int,@j int --����declare
--set @i=100
--set @j=101
--���ɶ����һ��SET
select @i=100,@j=101
select @i,@j