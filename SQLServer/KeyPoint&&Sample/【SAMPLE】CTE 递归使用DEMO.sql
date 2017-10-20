--CTE �ݹ�ʹ��DEMO

--������� 1���ݹ����ְ��
create table testbzm (
id int, --����ID
name varchar(10), --����
position varchar(10),--ְ��
upid int --�ϼ�ID
)

--����򵥲�������
insert into testbzm values
(1,'Tom','Sales',4),
(2,'Jim','Sales',4),
(3,'Sam','Sales',5),
(4,'Jirry','Manager',6),
(5,'Lily','Manager',6),
(6,'Tomas','CEO',NULL)



with cte as (
--��ʼ����
select id,name,position,cast(0 as int) pLevel from testbzm a where upid is null
union all
--CTEÿ�εݹ�����
select a.id,a.name,a.position,cte.pLevel+1 pLevel from testbzm a,cte/*CTE��Ҫ��ȷд��from����*/ where a.upid=cte.id
)

select * from cte
--�ݹ�������ƣ�����ָ�������ݹ�100��
--ָ��OPTION(MAXRECURSION number)��number=0 �����κ����ƣ��������Ƶݹ�number��


--������� 2��ѭ�����⣨����ָ�룩
/*
A	B	    C
1	2.05	3.14
2	9.1	    =B2*C1=28.574
3	2.74	=B3*C2=78.29276
 ����
*/
create table testbzm(
a int,
b decimal(20,8)
)

insert into testbzm values(1,2.05),(2,9.1),(3,2.74)

with cte_test(a,b,c)/*ȥ��(a,b,c)ֱ��дcte_test Ҳ����*/ as (
select a,b,cast(3.14 as decimal(20,8)) c from testbzm a where a=1
union all
select a.a,a.b,cast(a.b*ct.c as decimal(20,8)) c from testbzm a,cte_test ct where a.a=ct.a+1 and a.a<>1
)--ע��C�е����ݸ�ʽҪ��ǿת������ᱨ��
select * from cte_test --OPTION(MAXRECURSION 0)
/*
1	2.05000000	3.14000000
2	9.10000000	28.57400000
3	2.74000000	78.29276000
*/

drop table testbzm