--��1��sqlplus��
SQL> set autotrace on; --ʵ��ִ�к�����ִ�мƻ�
SQL> select * from dual;--SQL
����--ִ�������󣬻���ʾexplain plan �� ͳ����Ϣ��
SQL> set autotrace traceonly;--ֻ�г�ִ�мƻ���������������ִ����䣨ִ�мƻ����ܲ�׼��
SQL>SET AUTOTRACE OFF ��������������--������AUTOTRACE���棬����ȱʡģʽ 
SQL>SET AUTOTRACE ON EXPLAIN ���� --�������ð���ִ�мƻ����ű����������û��ͳ����Ϣ 
SQL>SET AUTOTRACE TRACEONLY STAT --��������ֻ������ͳ����Ϣ 

--��2��ALL
explain plan for
select * from dual;--SQL
select * from table(dbms_xplan.display);



--Look
ִ��˳�� 
ִ��˳���ԭ���ǣ��������£��������� 
�������£���ִ�мƻ���һ�㺬�ж���ڵ㣬��ͬ����(����)�Ľڵ㣬���ϵ�����ִ�У����µĺ�ִ�� 
����������ĳ���ڵ��»����ڶ���ӽڵ㣬�ȴ���ҵ��ӽڵ㿪ʼִ�С� 