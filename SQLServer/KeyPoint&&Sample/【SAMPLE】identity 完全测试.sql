--identity
--include: seed(initial value)，step(increment value)
--usage:surrogate key(代理键，业务无关，系统生成)

--basic table
if(object_id('dbo.t1','U') is not null) drop table t1;
GO
create table dbo.t1(
id int not null identity(1,1) constraint PK_T1 primary key,
datacol varchar(10) not null constraint PK_T1_datacol check(datacol like '[A-Za-z]%')
)

insert into t1(datacol) values
('AAAAAAA'),
('BBBBBBB'),
('CCCCCCC');

select * from dbo.t1;

--引用自增列的通用格式
select $identity /*old version:identitycol*/
from dbo.t1; 
/*
id
1
2
3
*/

--当前作用域内会话生成的止最后一个标识值（当前会话没插入数据到含identity的表则为NULL）
select scope_identity(); /*old version: @@IDENTITY --会话最后生成的标识值*/
--3

--获取表当前的标识值(作用域无关)
--new session
select scope_identity(),ident_current('dbo.t1');
--NULL  3

--rollback test
insert into t1(datacol) values('1AAAAAA');
/* The INSERT statement conflicted with the CHECK constraint "PK_T1_datacol". */
select ident_current('dbo.t1');--4
insert into t1(datacol) values('DDDDDDDD');
select max(id) from t1;--5
--TRAN
begin tran
insert into t1(datacol) values('EEEEEE');
rollback
select ident_current('dbo.t1');--6
insert into t1(datacol) values('EEEEEE');
select * from t1
/*
1	AAAAAAA
2	BBBBBBB
3	CCCCCCC
5	DDDDDDDD
7	EEEEEE
*/
--事务（显式事务/隐式事务）回滚当前标识值的变化不会被撤销。
drop table t1;

--identity column的数据变更：
if(object_id('dbo.ta','U') is not null) drop table ta;
GO
create table ta(id int identity(1,1),val int);
--1.可以非主键，可空（但不能指定为NULL）；
insert into ta(val) values(111);
--identity_insert
set identity_insert dbo.ta on;
insert into ta(id,val) values(NULL,222);
/* DEFAULT or NULL are not allowed as explicit identity values. */
insert into ta(id,val) values(100,222); --1 rows affected
update ta set id=1000 where id=1;
/* Cannot update identity column 'id'.*/
set identity_insert dbo.ta off;
----
select ident_current('dbo.ta') --100
insert into ta(val) values(111);
select ident_current('dbo.ta') --101
select * from ta;
--指定一个不是最大的值
set identity_insert dbo.ta on;
insert into ta(id,val) values(80,222); --1 rows affected
set identity_insert dbo.ta off;
select ident_current('dbo.ta')；--101 没变化
--2.可以指定值（Insert，新的ident_current由新增加的最大值决定），但不能更新值。

--identity column的表结构的变更：
if(object_id('dbo.ta','U') is not null) drop table ta;
GO
create table ta(id int identity(1,1),val int);
alter table ta add valid int not null identity(1,1);
/*Multiple identity columns specified for table 'ta'. 
Only one identity column per table is allowed.	*/
--1.只能有一个identity column
insert into ta(val) values(11),(12),(13);
select * from ta;
--2.变更自增列
sp_rename 'ta.id','iid','column';
insert into ta(val) values(11),(12),(13);
select * from ta;
--重命名:identity属性不受影响
alter table ta drop column iid;
alter table ta add id int not null identity(1,1);
select * from ta;
--可以重建identity column(现有列上增加或删除标识属性不被允许)

--重置ident_current
delete from ta where id%2=0;
select * from ta;
--identity column 重新序列化（重建）
alter table ta drop column id;
alter table ta add id int not null identity(1,1);
select * from ta;

--重置identity seed（新加入的值=seed+step）
select max(id) from ta;--3
set identity_insert dbo.ta on;
insert into ta(id,val) values(100,111);
insert into ta(id,val) values(100,111);
insert into ta(id,val) values(10,11);
set identity_insert dbo.ta off;
--非主键可以identity column的值可以重复
delete from ta where id>=100;
select * from ta;
select ident_current('dbo.ta');--100
--重置SEED（重建 identity column也可以）
DBCC CHECKIDENT ('dbo.ta', RESEED, 3)
GO
insert into ta(val) values(4),(5),(6),(4),(5),(6),(4),(5),(6);
select * from ta;
--一种比较诡异的报错：(以前2008-2012升级时出现过seed的紊乱)
delete from ta where id not in(1,3);
select * from ta;
alter table ta add constraint PK_TA primary key (id);
DBCC checkident('dbo.ta',reseed,1);
insert into ta(val) values(2);--1 rows affected
insert into ta(val) values(3);
/*
Violation of PRIMARY KEY constraint 'PK_TA'. Cannot insert duplicate key in object 'dbo.ta'. The duplicate key value is (3).
*/
--解决
declare @reseed int=(select max(id) from ta);
DBCC checkident('dbo.ta',reseed,@reseed);
insert into ta(val) values(3);



--truncate 会重置seed，delete不会重置seed