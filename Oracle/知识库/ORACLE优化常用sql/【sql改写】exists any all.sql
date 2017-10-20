/*--�������Ա�
create table TT
( ta VARCHAR2(10),
  tb VARCHAR2(10) );

create table TT1
( ta VARCHAR2(10),
  tb VARCHAR2(10) );

insert into TT (ta, tb)
values ('1', '11');
insert into TT (ta, tb)
values ('2', '22');
insert into TT (ta, tb)
values ('3', '33');
insert into TT (ta, tb)
values ('4', '44');
commit;
prompt 4 records loaded
prompt Loading TT1...
insert into TT1 (ta, tb)
values ('1', 'A');
insert into TT1 (ta, tb)
values ('2', 'B');
insert into TT1 (ta, tb)
values ('3', 'C');
insert into TT1 (ta, tb)
values (null, 'D');
commit;
*/
1.(NOT) EXISTS / (NOT) IN
�﷨�� (NOT) EXISTS subquery
������ subquery ��һ�����޵� SELECT ��� (�������� COMPUTE �Ӿ�� INTO �ؼ���)��
������ͣ� Boolean ����Ӳ�ѯ�����У��򷵻� TRUE �����򷵻� FLASE �����еĽ��ΪNULL��Ҳ�����ڰ����еģ�
����
(1)��������/�ֶ�����ͬ: in (select ta from tt)/ exist (select ta,tb from tt)
(2)������ͬ(ִ��˳��ͬ��Ч�ʲ�ͬ)��in�ڱ�������exists�������
(3)ͨ������²���existsҪ��inЧ�ʸߣ���ΪIN����������
(4)�����not in�Ӳ�ѯ����nullֵ��ʱ��,�򲻻᷵�����ݡ�not exists�᷵����ȷ��ֵ
select * from tt where ta not in (select ta from tt1 ); --û���
select * from tt a where not exists (select null from tt1 b where a.ta=b.ta);--4	44
(5)exists���й���
���������ҵ��ؼ���SELECT������FROM�ؼ��ֽ�������ڴ棬��ͨ��ָ���ҵ���һ����¼
�������ҵ�WHERE�ؼ��ּ��������������ʽ�����Ϊ����ô��������¼װ��һ������У�ָ����ָ����һ����¼��
���Ϊ����ôָ��ֱ��ָ����һ����¼��������������������һֱ���������������Ѽ���������������ظ��û���
EXISTS���������ʽ��һ���֣���Ҳ��һ������ֵ(true��false)��

2.����
(1)SQL��д����
    ��in<=>exists IN�ʺ���������ڱ�С��ö�ٳ����������EXISTS�ʺ������С���ڱ��������
    ��distinct<=>exists exists�����ж�����distinct--��ע�⣺����ȫ�ȼۡ�
    select distinct tt.ta from tt,tt1 where tt.ta=tt1.ta;--�ȼ�ǰ��Ϊtt.ta��Ϊ��tt1.ta����(һ�Զ�)�����ظ���tt.ta���������ظ�
    select ta from tt where exists(select 1 from tt1 where tt1.ta=tt.ta);--better
    ���ñ������滻exists��ͨ����˵�����ñ����ӵķ�ʽ��exists����Ч�ʡ� --��ע�⣺����ȫ�ȼۡ�
    select a.ta from tt a where exists (select 1 from tt1 b where a.ta=b.ta)--��a.ta���������ظ���ȥ�ظ���ԭ��ͬ2
    select a.ta from tt a,tt1 b where a.ta=b.ta--better
(2)����not in����(ʹ�� not exists���)

3.�����ȼ����(�Ƚ���û�п�ֵ�������)
delete from tt1 where ta is null;
--ALL<>MAX()
SELECT * FROM TT WHERE TA > ALL(SELECT ta FROM tt1);
SELECT * FROM TT WHERE TA > (SELECT MAX(ta) FROM tt1);

--ANY<>MIN()
SELECT * FROM TT WHERE TA > ANY(SELECT ta FROM tt1);
SELECT * FROM TT WHERE TA > (SELECT MIN(ta) FROM tt1);

--=ANY<>IN
SELECT * FROM TT WHERE TA = ANY(SELECT ta FROM tt1);
SELECT * FROM TT WHERE TA IN (SELECT ta FROM tt1);

