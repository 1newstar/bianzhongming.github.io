--���ļ�����ռ��
select a.file_name "�ļ�ȫ��",
       a.tablespace_name "��Ӧ��ռ�",
       a.bytes / 1024 / 1024 "ռ���̿ռ�����(MB)",
       --  b.sb /1024/1024 FREE,
       (a.bytes - b.sb) / 1024 / 1024 "ʹ�ÿռ�����(MB)",
       100 * (a.bytes - b.sb) / a.bytes "ʹ����%"
  from dba_data_files a,
       (select file_id, sum(BYTES) sb from dba_free_space group by file_id) b
 where a.file_id = b.file_id
 --  and a.tablespace_name in ('NNC_INDEX01' /*,'NNC_INDEX02'*/)
 order by a.file_name;
 
/*
--��������
ALTER DATABASE DATAFILE 'C:\ORADATA\NNC_INDEX03_6.DBF.ORAORA ' RESIZE 100M;

--���������ļ�
alter tablespace NNC_DATA01 add datafile 'E:\oracle\oradata\orcl\nnc_data01_11.dbf' size 100M;

--undo��ռ䣺��չ��10GB
select 'ALTER DATABASE DATAFILE '||''''||file_name||''''||' RESIZE 5000M;' ,tablespace_name "��Ӧ��ռ�" from dba_data_files  where tablespace_name like 'UNDOTBS%'

--���б�ռ��Զ���չ����
select 'ALTER DATABASE DATAFILE ' || '''' || file_name || '''' || ' AUTOEXTEND ON NEXT 100M MAXSIZE 32000M;' from dba_data_files;
*/