--�����ַ�������
--�ɼ��ַ���&,_,%
--���ɼ��ַ����Ʊ��,�Ʊ��,�س���
--��������ASCII�뷨��ת�壨escape������define��������Զ��������

���ɼ��ַ����� --ASCII�뷨
�Ʊ���� CHR(9)     ���з��� CHR(10)    �س����� CHR(13)
--eg
select changjiakuanhao,vbatchcode from ts_batchcode where changjiakuanhao like '%'||chr(10)||'%' 

create table t_test_escape(name varchar2(20));
SQL> set define off  --ʹ��set define off �ر���������Ĺ��ܣ����뺬��&�������ַ���
SQL> insert into t_test_escape(name) values('Oracle%&_hello');
1 row inserted

%�ַ�����   --ת�壨escape����
select * from t_test_escape where name like '%a%%' escape 'a';--����ʹ�õ�ת���ַ�Ϊ'a'

&�ַ�����
--��1��define��
SQL> set define off --�ر������������֮�����ֱ�ӽ�&������ͨ�ַ�������escape
select * from t_test_escape where name like '%&%';
--��2��ASCII�뷨
SQL> set define on  --�������������
select ascii('&') from dual; --�����38    --ͨ����ѯ��'&'��ascii���ƹ�����ϰ� 
SQL> select * from t_test_escape where name like '%' || chr(38) || '%'; --ʹ��chr(38)ȥ��������ַ�'&'
--��3��define��  --����������������ַ���Ϊ$
SQL> set define $
SQL> select * from t_test_escape where name like '%&%';

_�ַ�����   --ת�壨escape����
select * from t_test_escape where name like '%a_%' escape 'a';


�ܽ᣺escape�ؼ���ȥת�������ַ���ʱ�򣬲����Ƕ������е������ַ����ܹ�ת��ɹ���ʹ��escape���ܹ��ɹ�ת��'%', '_'�ģ�����ת��'&'

--����ת��ĸ
chr(rownum+64)--ֱ��ת
chr(mod(rownum-1,26)+1+64)--ѭ������A-Z