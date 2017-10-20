--���ݱ��������У�
select table_name,num_rows from dba_tables where num_rows>1000000 order by num_rows desc;

--�����ݣ������������������
--��ע�����ܹ�ռ�ÿռ�=��������ռ�ռ�+����������ռ�ռ�
select a.table_name ����,
       a.num_rows   ����,sum(b.bytes) / 1024 / 1024 MB
  from dba_tables a, user_segments b
  where a.table_name=b.segment_name
  group by a.table_name,a.num_rows
 order by a.table_name;

--===�����ݣ������������ͳ�Ʒ���
select /*+ Parallel(6) */
table_name,sum(MB) MB from (
--��ϸ
select b.table_name,a.segment_name, sum(a.bytes)/1024/1024 MB
  from dba_segments a,(select table_name from user_tables) b
 where a.segment_name in (select INDEX_NAME from user_indexes where table_name =b.table_name)--�ɱ���ƥ��������
 or segment_name = b.table_name --����
 group by a.segment_name,b.table_name
--====
)group by table_name
order by  MB desc
