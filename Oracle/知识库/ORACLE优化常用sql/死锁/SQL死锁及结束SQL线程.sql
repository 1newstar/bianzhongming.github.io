---------------lock--------------------
SELECT l.session_id      sid,
       s.serial#,
       l.locked_mode     ��ģʽ,
       l.oracle_username ��¼�û�,
       s.username,
       l.os_user_name    ��¼�����û���,
       s.machine         ������,
       s.terminal        �ն��û���,
       o.object_name     ����������,
       --l.PROCESS,      --v$process��addr�ֶΣ�ͨ��������Բ�ѯ�����̶�Ӧ��session
       s.logon_time      ��¼���ݿ�ʱ��,
       a.SQL_TEXT,
        'alter system kill session '''||l.Session_ID||','||s.SERIAL#||''';' killSQL
  FROM v$locked_object l, all_objects o, v$session s, v$sql A
 WHERE l.object_id = o.object_id
   AND l.session_id = s.sid
   and S.SQL_HASH_VALUE= A.HASH_VALUE(+)
 ORDER BY sid, s.serial#;

-------------Runing SQL-------
----���ղ�ѯ����sid,serial#����PLSQL session�鿴SQL TEXT��Ҳ��ֱ�ӽ���session��
----NC����NMC�û���/���� ȷ��SQL��Ӧ�÷������ڵ����IP��ȷ���������������PLSQL session�鿴SQL TEXTȷ��sid,serial#��
--SID-->SQL
select a.username, a.sid, b.SQL_TEXT, b.SQL_FULLTEXT
  from v$session a, v$sqlarea b
 where a.sql_address = b.address
   and sid = '485'
--��ע�⡿session��sql����Ϊ�գ����ڲ�������
 

--------------Kill-------------
/*sid ��ͬһ��instance�ĵ�ǰsession����һ��unique key, ��sid ,serial#����������instance�������ڵ�����session����unique key
���Ե�����ִ����kill session����֮���ܹ�׼ȷ�����kill��ĳ��session��������ɱ*/
---�鿴�û�������Session��kill�����ɾ���û���
select sid,serial# from v$session where username='NCV502';   --ע���û�����ĸ���ô�д
--select 'alter system kill session '''||sid||','||serial#||''';' from v$session where username='NCV502';--�����û�����

--sys ��½(RAC��½��̨����)��kill
--alter system kill session '609,5447';

--SID ,SPID ����(ͨ��OS PID=ora SPID�Ų��Ч������SQL)
select a.SID, a.USERNAME, a.status, a.process, b.SPID from v$session a, v$process b where a.PADDR = b.ADDR
and a.sid = '938'
--and b.SPID='20755';
--OS  KILL -9 SPID

--------------�ֹ�����PMONִ��,����killed���̣��ͷ���Դ-------------
/*Oracle��kill session֮��oracleֻ�Ǽ򵥵İ���ص�session��paddrָ��һ�������ַ��
��ʱ��v$session��v$processʧȥ��ϵ�����̾ʹ��жϣ�Ȼ��oracle�͵ȴ�pmon����ȥ�����Щ�����Ϊkilled��session��
����ͨ���ȴ�һ�������Ϊkilled��session��Դ���ͷţ���Ҫ�ȴ��ܳ�ʱ�䡣
�����ʱ��kill�Ľ��̣���������ִ�в�������ô�������յ������жϵ���ʾ��process�������˳���
��ʱOracle����������PMON�����������session��ʹ�õ���Դ��������̱�����һ���쳣�жϴ���*/
--1.ȷ��PMON����PID
select pid,spid from v$process p,v$bgprocess b where b.paddr=p.addr and name='PMON';
--2.WAKEUP PMON     
SQL> conn / as sysdba
SQL> oradebug wakeup <orapid(oracle���̵�PID)>

--------��
/*�鿴���޸�_pkt_pmon_interval��PMON�������ڲ�����������β������ӿ�������ΪKilled��Session
��ѯ���β����������£�
--conn / as sysdba
select a.ksppinm name,b.ksppstvl value,a.ksppdesc description
from x$ksppi a,x$ksppcv b
where a.inst_id = USERENV ('Instance') --�����޸�Ϊʵ����
and b.inst_id = USERENV ('Instance')
and a.indx = b.indx
and  a.ksppinm = '_pkt_pmon_interval';
--��ѯ�����
_pkt_pmon_interval             50         PMON process clean-up interval (cs)   --cs��ʾ�ٷ�֮һ��
--�޸����
ALTER SYSTEM SET "_pkt_pmon_interval"=5;  --��ʱ��Ч
_pkt_pmon_interval    5          PMON process clean-up interval (cs)
*/
