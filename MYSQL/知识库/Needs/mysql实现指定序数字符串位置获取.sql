-- mysqlʵ��ָ�������ַ���λ�û�ȡ
-- �ַ������ӣ�'test_env_Log_10098'�����󣺻�ȡ�������ֲ���10098

-- 1.Ƕ��ʵ�֣��ȽϷѾ�
set @chr='test_env_Log_10098';
select substr(@chr,instr(@chr,'_')+1) -- һ��һ��Ƕ�ף�substr(@chr,instr(@chr,'_')+1)���ܹ�Ƕ��3�Σ���ʱ����

-- 2.substring_indexʵ��
set @chr='test_env_Log_10098';
select substring_index(@chr,'_',-1)


-- 3.�Զ��庯��ʵ��





