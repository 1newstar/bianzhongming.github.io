--���ҵ���Ч����
select 'Alter '||object_type||' '||object_name||' compile;' from user_objects where status = 'INVALID';

--���±���洢���� pro_backup_call ִ������ű�����
alter procedure pro_backup_call compile;