--���մ洢�������Ʋ�ѯjob
select * from dba_jobs where what like '%Tbzm20141212%';

--��ѯ�洢���̻�����Ϣ
select * from DBA_objects where object_type='PROCEDURE' and object_name='T3';

--�ɱ�����ѯ��ش洢����
SELECT * FROM ALL_SOURCE  where TEXT LIKE '%TS_CORP_SALE_KPI%';
XP_TMP_PKG
WJ_UTITOOL_PKG
--�������ѯ�����û�д洢����ֻ�а������ٴβ�ѯ�ð���صĴ洢���̼���
SELECT * FROM ALL_SOURCE  where TYPE='PROCEDURE'  AND TEXT LIKE '%XP_TMP_PKG%';