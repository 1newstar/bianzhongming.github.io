/*
����һ��ȥ���ظ��У�����һ�У�
�������ȥ��ָ���ֶ��ظ����У����������һ�У�
��������ȥ��ָ���ֶ��ظ����У�����ָ�������һ�У�

��������
��������ID������ϵͳ��ID��ROW_ID��

����˼·��
��1�������������λ����ǰ���Ǳ����б�ע�ı�־��Ψһ��λ��ÿһ�У�
��2���м��/��ʱ�� ����
*/
--DEMO ����������ʱ�䣨dt�����µļ�¼��ɾ��val1,val2�ֶ��ظ��ļ�¼

----------------------sqlserver
create table testbzm (
val1 varchar(10),
val2 varchar(10),
dt varchar(10)
);

insert into testbzm values('1','aa','2016-08-01');
insert into testbzm values('1','aa','2016-09-01');
insert into testbzm values('1','aa','2017-01-01');
insert into testbzm values('2','bb','2016-05-01');
insert into testbzm values('2','bb','2017-08-01');
insert into testbzm values('2','bb','2015-02-01');
insert into testbzm values('2','bb','2015-02-01');
--��Ϊû�к��������ֶ�,����ֻ��ʹ����ʱ��
select ROW_NUMBER() over(partition by val1,val2  order by dt desc) ID,* into #tp from testbzm 
truncate table testbzm
insert into testbzm(val1,val2,dt) (select val1,val2,dt from #tp where id=2)
select * from testbzm
/*
1	aa	2016-09-01
2	bb	2016-05-01
*/
drop table testbzm
drop table #tp
---------------------oracle
--oracle��row_id���Ա�עÿһ�У������ͺܼ��ˣ���ȻҲ����ʹ���м��������
delete from testbzm where rowid not in (
select rid from (
select ROW_NUMBER() over(partition by val1, val2 order by dt desc) ID,
       rowid rid,
       val1,
       val2,
       dt
  from testbzm )
where ID=2
  );

select * from testbzm;
/*
1	aa	2016-09-01
2	bb	2016-05-01
*/
drop table testbzm purge;

-----------------Mysql
--mysqlҲ���м��/��ʱ���˼·������mysqlû��ROW_NUMBER() over(partition by val1, val2 order by dt desc)��ֻ��ͨ�������ֹ�ʵ��
select val1,val2,dt
from (
select val1,val2,dt,
if(@val1=y.val1,@rank:=@rank+1,@rank:=1) as rank,  
  @val1:=y.val1  
from
(select val1,val2,dt from testbzm order by val1,val2,dt desc ) y,
(select @val1 := null ,@rank:=0) a
) results
where rank=2
/*
1	aa	2016-09-01
2	bb	2016-05-01
*/
drop table testbzm