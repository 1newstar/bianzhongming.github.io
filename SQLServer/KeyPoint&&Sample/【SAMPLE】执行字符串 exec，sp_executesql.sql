--ִ���ַ���
EXECUTE sp_executesql 
          N'select CREATE_TIME from md_institution where PARTY_ID=93'
--ִ�б������ɽ����
declare @test nvarchar(500)  /*����nvarchar���4000*/
set @test='select CREATE_TIME from md_institution where PARTY_ID=93'
EXECUTE sp_executesql  @test

--ִ���ַ���2
exec ('select CREATE_TIME from md_institution where PARTY_ID=93')