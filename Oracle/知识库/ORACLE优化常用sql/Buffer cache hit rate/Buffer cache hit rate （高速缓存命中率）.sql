--Buffer Cache Hit rate
select 1 - ((physical.value - direct.value - lobs.value) / logical.value) "Buffer Cache Hit Ratio"
  from v$sysstat physical,
       v$sysstat direct,
       v$sysstat lobs,
       v$sysstat logical
 where physical.name = 'physical reads'
   and direct.name = 'physical reads direct'
   and lobs.name = 'physical reads direct (lob)'
   and logical.name = 'session logical reads';
/*session logical readsΪ��������.
physical reads Ϊ�������ļ���.
physical reads direct Ϊ�ӻ�������(����LOBS).
physical reads direct (LOBS)Ϊ�ӻ�������(��LOBS)*/

--����PGA��SGA
