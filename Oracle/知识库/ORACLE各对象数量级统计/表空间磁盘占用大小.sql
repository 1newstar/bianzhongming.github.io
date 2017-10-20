--��ռ����ռ�ô�С
select dbf.tablespace_name "��ռ���",
       dbf.totalspace "ռ���̿ռ�����(GB)",
       --dbf.totalblocks �ܿ���,
       --dfs.freespace "ʣ������(GB)",
       --dfs.freeblocks "ʣ�����",
       dfs.freespace "ʣ����(GB)",
       dbf.totalspace-dfs.freespace "ʹ����(GB)",
       round((dfs.freespace / dbf.totalspace) * 100,2) "����(%)"
  from (select t.tablespace_name,
               sum(t.bytes) / 1024 / 1024 / 1024  totalspace  --,sum(t.blocks) totalblocks
          from dba_data_files t
         group by t.tablespace_name) dbf,
       (select tt.tablespace_name,
               sum(tt.bytes) / 1024 / 1024 / 1024  freespace  --,sum(tt.blocks) freeblocks
          from dba_free_space tt
         group by tt.tablespace_name) dfs
 where trim(dbf.tablespace_name) = trim(dfs.tablespace_name)
--and dbf.tablespace_name like 'NNC%'  --ֻ�鿴NC��ռ�
order by dbf.tablespace_name
