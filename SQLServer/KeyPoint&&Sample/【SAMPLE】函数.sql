Create function Testbzm(@inpute varchar(10))
Returns varchar(10)
As
Begin
   Declare @output varchar(10)
   Select @output=name_en from sys_table
Where table_id = @inpute
Return @output
End

select dbo.testbzm('458')

drop function testbzm;

--��������ִ��exec�����ܵ��ô洢���̣�
--�������ܴ�����ɾ�������������