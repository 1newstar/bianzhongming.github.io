create table t1 
(a    VARCHAR2(1), 
 b NVARCHAR2(1)
);

create table t2 
(a    VARCHAR2(1), 
 b NVARCHAR2(1) 
)

select * from t1 for update ;
/*1	5
2	6*/

select * from t2 for update ;
/*2	7
3	8*/

--������
select * from t1 a,t2 b where a.a=b.a(+);
select * from t1 a left join t2 b on a.a=b.a;--�ȼ�
--������
select * from t1 a,t2 b where a.a(+)=b.a;
select * from t1 a right join t2 b on a.a=b.a;--�ȼ�
--��ֵ����
select * from t1 a,t2 b where a.a=b.a;
select * from t1 a inner join t2 b on a.a=b.a;--�ȼ�
--ȫ����
select * from t1 a full join t2 b on a.a=b.a;
