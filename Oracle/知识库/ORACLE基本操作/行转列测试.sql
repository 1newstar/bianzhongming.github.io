----�������Ա�
create table student_score(
       name varchar2(20),
       subject varchar2(20),
       score number(4,1)
       );
 
  
 
-----�����������
 
insert into student_score (name,subject,score)values('����','����',78);
insert into student_score (name,subject,score)values('����','��ѧ',88);
insert into student_score (name,subject,score)values('����','Ӣ��',98);
insert into student_score (name,subject,score)values('����','����',89);
insert into student_score (name,subject,score)values('����','��ѧ',76);
insert into student_score (name,subject,score)values('����','Ӣ��',90);
insert into student_score (name,subject,score)values('����','����',99);
 
  
 
insert into student_score (name,subject,score)values('����','��ѧ',66);
 
  
 
insert into student_score (name,subject,score)values('����','Ӣ��',91);
 
  
 select * from student_score
-----decode��ת��
 
select name "����",
 
       sum(decode(subject, '����', nvl(score, 0), 0)) "����",
 
       sum(decode(subject, '��ѧ', nvl(score, 0), 0)) "��ѧ",
 
       sum(decode(subject, 'Ӣ��', nvl(score, 0), 0)) "Ӣ��"
 
  from student_score
 
 group by name;
 
  
 
----�������Ա�
 

create table student_score(
 
       name varchar2(20),
 
       subject varchar2(20),
 
       score number(4,1)

);
 
  
 
-----�����������
 
insert into student_score (name,subject,score)values('����','����',78);
 
  
 
insert into student_score (name,subject,score)values('����','��ѧ',88);
 
  
 
insert into student_score (name,subject,score)values('����','Ӣ��',98);
 
  
 
  
 
insert into student_score (name,subject,score)values('����','����',89);
 
  
 
insert into student_score (name,subject,score)values('����','��ѧ',76);
 
  
 
insert into student_score (name,subject,score)values('����','Ӣ��',90);
 
  
 
  
 
insert into student_score (name,subject,score)values('����','����',99);
 
  
 
insert into student_score (name,subject,score)values('����','��ѧ',66);
 
  
 
insert into student_score (name,subject,score)values('����','Ӣ��',91);
 
  
 select * from student_score
-----decode��ת��
 
select name "����",
 
       sum(decode(subject, '����', nvl(score, 0), 0)) "����",
 
       sum(decode(subject, '��ѧ', nvl(score, 0), 0)) "��ѧ",
 
       sum(decode(subject, 'Ӣ��', nvl(score, 0), 0)) "Ӣ��"
 
  from student_score
 
 group by name;
 
 ------ case when ��ת��
select name "����",
 
       sum(case when subject='����'
 
       then nvl(score,0)
 
       else 0
 
       end) "����",
 
       sum(case when subject='��ѧ'
 
       then nvl(score,0)
 
       else 0
 
       end) "��ѧ",
 
       sum(case when subject='Ӣ��'
 
       then nvl(score,0)
 
       else 0
 
       end) "Ӣ��"
 
      from student_score
 
       group by name;
 
 
 --���������ն��ŷ��� 
 
 select a.name,wmsys.wm_concat(a.subject||','||a.score) from student_score a
 group by a.name --for update
 
 --wmsys.wm_concat(tableA.t1) :1,2,3
 select * from student_score for update
 
 drop table student_score purge;
