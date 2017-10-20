select * into #t1 from (
select 0 num union all
select 1 num union all
select 2 num union all
select 3 num union all
select 4 num union all
select 5 num union all
select 6 num union all
select 7 num union all
select 8 num union all
select 9 num
) T;
select * into #t2 from (
select 0 num union all
select 1 num union all
select 2 num union all
select 3 num union all
select 4 num union all
select 5 num 
) T;

--CROSS JOIN
select * from #t1 a cross join #t2 b;--cartesian product

--JOIN
select a.num as anum ,b.num as bnum from #t1 a join #t2 b on a.num=b.num
--ʵ�ֲ�����
select * from (
select  a.num as anum ,b.num as bnum from #t1 a cross join #t2 b --Step 1 :cartesian product
) T
where anum=bnum --Step2 :filter
;

--outer join
select a.num as anum ,b.num as bnum from #t1 a left outer join #t2 b on a.num=b.num
--ʵ�ֲ�����
select * from (
select  a.num as anum ,b.num as bnum from #t1 a cross join #t2 b --Step 1 :cartesian product
) T
where anum=bnum --Step2 :filter
union all
-- Step3 : add outer column
select A.num anum, NULL bnum from #t1 A where a.num not in ( select anum from (
select  a.num as anum ,b.num as bnum from #t1 a cross join #t2 b --Step 1 :cartesian product
) T
where anum=bnum --Step2 :filter
);


--���������ӵĽ���Լ������߼�
select * from #t1 a left join #t2 b on (a.num=b.num and b.num=1);
select * from #t1 a left join #t2 b on (a.num=b.num and a.num=1);
select * from #t1 a left join #t2 b on (a.num=b.num and a.num=1 and b.num=2);
select * from #t1 a left join #t2 b on (a.num=b.num and a.num=1 and b.num=1);
--��Ϊ��Ҫ����ⲿ�У�����#t1�Ĺ��������޷�������#t1���й��ˣ���Ҫ������Ҫ��where��������������һ�����

select * from #t1 a left join #t2 b on (a.num=b.num and a.num=1 and b.num=1);
--ʵ�ֲ�����
select * from (
select  a.num as anum ,b.num as bnum from #t1 a cross join #t2 b --Step 1 :cartesian product
) T
where anum=bnum and anum=1 and bnum=1--Step2 :filter
union all
-- Step3 : add outer column
select A.num anum, NULL bnum from #t1 A where a.num not in ( select anum from (
select  a.num as anum ,b.num as bnum from #t1 a cross join #t2 b --Step 1 :cartesian product
) T
where anum=bnum and anum=1 and bnum=1--Step2 :filter
);


---------------------�������ⲿ�б���������
select * from #t1 a left join #t2 b on a.num=b.num join #t2 c on c.num=b.num
--ԭSQL�����ں�һ��join�漰����b.num�Ĺ��ˣ���a��ӵ��ⲿ�е�b���ֶε�ռλ����NULL���ᱻ���˵�

select * from #t2 b join #t2 c on c.num=b.num right join #t1 a on a.num=b.num --way1
select * from #t1 a left join (#t2 b join #t2 c on c.num=b.num) on a.num=b.num --way2