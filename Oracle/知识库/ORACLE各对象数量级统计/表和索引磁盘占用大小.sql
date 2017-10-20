--��ע������������������������INDEX/TABLE����һ��Ҫ��д

--ĳ������
select segment_name, sum(bytes) / 1024 / 1024 "MB" from dba_segments
 where segment_name = 'BD_CORP'  --��������������
    -- ��ռ� and tablespace_name='NNC_INDEX03'
 group by segment_name
 --order by sum(bytes) desc;

--ĳ�����
select segment_name, sum(bytes) / 1024 / 1024 "MB"
  from dba_segments
where SEGMENT_TYPE = 'TABLE' -- ���б�����������'INDEX'
 group by segment_name
 --order by sum(bytes) desc;
 
--������ռ�ÿռ��С����
Select S.SEGMENT_NAME ,DECODE(SUM(BYTES), NULL, 0, SUM(BYTES) / 1024 / 1024) Mbytes
  From DBA_SEGMENTS S
 Where S.SEGMENT_TYPE = 'TABLE PARTITION'
 Group By S.SEGMENT_NAME

--ALL
select owner,segment_name,segment_type,tablespace_name,sum(bytes) / 1024 / 1024 "MB"
  from dba_segments
 group by owner,segment_name,segment_type,tablespace_name
 order by sum(bytes) desc;
 
