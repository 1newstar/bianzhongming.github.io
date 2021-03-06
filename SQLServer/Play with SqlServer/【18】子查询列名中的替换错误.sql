create table #T (id int);
create table #B (id int,iid int);

insert into #T values(1),(2),(3);
insert into #B values(1,4),(2,5),(4,6);

select * from #T where id in (select id from #B);
/*
1
2
*/

alter table #B drop column id;

select * from #T where id in (select id from #B);
/*
1
2
3
*/

/*
小结：
1.子查询列名解析顺序从内到外（优先内部查询，内查询内有该列在到外部查询表中进行解析）
2.问题避免：（1）避免易混淆列名(统一列名)；（2）所有表习惯性别名。
*/
