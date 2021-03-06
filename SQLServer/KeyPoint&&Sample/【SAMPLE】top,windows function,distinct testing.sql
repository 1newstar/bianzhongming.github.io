---IMP basic data
--创建成绩表
if(object_id('Tgrade') is not null) drop table Tgrade;
GO
create table Tgrade(
grade_stuno varchar(3) ,
grade_lessonno varchar(3) ,
grade  decimal(5,2)
)

--插入成绩数据
insert into Tgrade values('001','yw',98)
insert into Tgrade values('001','yy',93)
insert into Tgrade values('001','sx',94)
insert into Tgrade values('002','yw',93)
insert into Tgrade values('002','yy',95)
insert into Tgrade values('002','sx',96)
insert into Tgrade values('001','yw',98)
insert into Tgrade values('001','yy',93)
insert into Tgrade values('001','sx',94)
insert into Tgrade values('002','yw',93)
insert into Tgrade values('002','yy',95)
insert into Tgrade values('002','sx',96)
insert into Tgrade values('001','yw',98)
insert into Tgrade values('001','yy',93)
insert into Tgrade values('001','sx',94)
insert into Tgrade values('002','yw',93)
insert into Tgrade values('002','yy',95)
insert into Tgrade values('002','sx',96)


--check
select * from Tgrade

-------------------------------------
--test windows function
select *,
sum(grade) over() "sum",
sum(grade) over(partition by grade_stuno) "sum partition",
row_number() over(order by grade) "row number", 
rank() over(order by grade) "rank",
dense_rank() over(order by grade) "dense_rank",
ntile(5) over(order by grade) "ntile"
from  tgrade

--test distinct+order by
select grade_stuno from tgrade order by grade
select distinct grade_stuno from tgrade order by grade --ERROR
/*SQL Server Database Error: ORDER BY items must appear in the select list if SELECT DISTINCT is specified.*/
select distinct grade_stuno,grade from tgrade order by grade
/*order by 的字段必须在distinct的字段中
RUN Steps:distinct -> order by -> top -> order by(show data) */

--test top
select top 1 grade_stuno from tgrade order by grade
select distinct top 2 grade_stuno,grade from tgrade order by grade desc
select * from (select grade_stuno,grade from tgrade order by grade desc) t --ERROR （∵result set不是集合，可能是超集或者是包）
/*The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.*/
--用top 100 percent 绕过报错
select * from (select top 100 percent grade_stuno,grade from tgrade order by grade desc) t
--小众用法
select top 4 * from tgrade order by grade desc
select top 4 with ties * from tgrade order by grade desc --top最后一行的排序字段的值相等的行都会出来

--test windows function+distinct+order by
select distinct row_number() over(order by grade) as ID,
grade_stuno,grade
from tgrade
order by grade_stuno,grade
--distinct 失效（先开窗，后distinct）
--上面需求的正确实现方法
select distinct row_number() over(order by grade) as ID,
grade_stuno,grade
from tgrade
group by grade_stuno,grade
/*SQL执行顺序：
from->where->group by->having->select(over->distinct->top)->order by*/

--clear
drop table Tgrade

