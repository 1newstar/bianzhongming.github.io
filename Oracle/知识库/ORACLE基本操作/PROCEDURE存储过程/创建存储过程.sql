--drop procedure �洢��������;  ɾ���洢����
--����/�޸Ĵ洢����
/*CREATE OR REPLACE PROCEDURE GYLCRKD_TB AS
BEGIN
--SQL���--e.g Update table
end;
/
SQL> show errors --��ʾ�������
*/


--��ʱ����
--ע�⣺PLSQL�鿴�洢���̲�׼ȷ��Ҫ������
/*
�÷�DEMO:  
     DBMS_JOB.SUBMIT(:jobno,//job��   
          'your_procedure;',//Ҫִ�еĹ���   
        trunc(sysdate)+1/24,//�´�ִ��ʱ��  TRUNC(SYSDATE)+�������+����/24 
        'trunc(sysdate)+1/24+1'//ÿ�μ��ʱ��   ��Ӧdba_jobs.INTERVAL:���ڼ�����һ����ʱ��ı��ʽ 
         );   
*/

VARIABLE JOBNO NUMBER;
VARIABLE INSTNO NUMBER;
BEGIN
SELECT INSTANCE_NUMBER INTO :INSTNO FROM V$INSTANCE;
DBMS_JOB.SUBMIT(:JOBNO,'test11;
',TRUNC(SYSDATE)+1/24+1,'TRUNC(SYSDATE)+7+1/24',TRUE,:INSTNO);
COMMIT;
END;
/

--JOBNO 192

---ɾ����ʱ����
select * from dba_jobs where job='192';--user_jobs;
--1       305   2009-3-4 3:10:14                   2009-3-6 2:00:00          "ANALYZE_TB;
--ɾ���洢����
drop procedure NAME;



exec sys.dbms_job.remove('192');

--��ɾ������ע�����й����в��ܴ��ڴ��󣬷�����жϣ�
create or replace procedure Tbzm20141212
as
delTab varchar2(2048);
InsTable varchar2(2048);
grantTable varchar2(2048);
begin
delTab := ' drop table xian_CL purge';
InsTable := q'[create table xian_CL as (SELECT f.INVCODE,f.INVNAME,d.province,d.citycounty,a.VBATCHCODE,a.PINPAI,a.ZIPINPAI,a.CHANGJIAKUANHAO,a.ZHUSHIZHONGLIANG,a.SHOUCUNCHANGDU,
a.YANSE,a.JINGDU,a.QIEGONG,a.ZONGZHONG,a.JIANCEZHENGSHU,a.jiangshangzhengshu,a.vdef37 chicun,a.vdef38 diaogong,
a.vdef39 zhidi,a.vdef40 yuyi,a.XIAOSHOUHANSHUIJIA,
b.nonhandnum,d.unitname
  FROM  IC_ONHANDNUM B, bd_corp d,ts_batchcode a,bd_invcl e,bd_invbasdoc f
 WHERE A.VBATCHCODE = B.VLOT
   and a.pk_invbasdoc=f.pk_invbasdoc
   and f.pk_invcl=e.pk_invcl
   AND NONHANDNUM <> 0
   AND B.DR = 0
   AND substr(e.invclasscode, 1, 1) NOT in ('8', '9')
  and substr(a.vbatchcode,1,2)<>'TL'
   and b.pk_corp=d.pk_corp
   and substr(d.unitcode,1,1) in('E','J')
   and b.pk_corp not in ('1003','1514','1003','1514'))]';
grantTable := 'GRANT SELECT ON "NCV502"."XIAN_CL" TO sqlserconn';
execute immediate delTab;
execute immediate InsTable;
execute immediate grantTable;
commit;
end;
/


exec Tbzm20141212;

--��ʱ����


trunc(sysdate,'d') --(������)���ص�ǰ���ڵĵ�һ��
select  TRUNC(sysdate,'d')+1/24 from dual;

--ÿ������1��
VARIABLE JOBNO NUMBER;
VARIABLE INSTNO NUMBER;
BEGIN
SELECT INSTANCE_NUMBER INTO :INSTNO FROM V$INSTANCE;
DBMS_JOB.SUBMIT(:JOBNO,'Tbzm20141212;
',TRUNC(SYSDATE)+6+1/24,'TRUNC(SYSDATE)+7+1/24',TRUE,:INSTNO);
COMMIT;
END;
/

--dba_jobs��
�ֶΣ��У�               ��������              ����   
JOB                    NUMBER               �����Ψһ��ʾ��   
LOG_USER               VARCHAR2(30)         �ύ������û�   
PRIV_USER              VARCHAR2(30)         ��������Ȩ�޵��û�   
SCHEMA_USER            VARCHAR2(30)         ���������﷨�������û�ģʽ   
LAST_DATE              DATE                 ���һ�γɹ����������ʱ��   
LAST_SEC               VARCHAR2(8)          ��HH24:MM:SS��ʽ��last_date���ڵ�Сʱ�����Ӻ���   
THIS_DATE              DATE                 ������������Ŀ�ʼʱ�䣬���û������������Ϊnull   
THIS_SEC               VARCHAR2(8)          ��HH24:MM:SS��ʽ��this_date���ڵ�Сʱ�����Ӻ���   
NEXT_DATE              DATE                 ��һ�ζ�ʱ���������ʱ��   
NEXT_SEC               VARCHAR2(8)          ��HH24:MM:SS��ʽ��next_date���ڵ�Сʱ�����Ӻ���   
TOTAL_TIME             NUMBER               ��������������Ҫ����ʱ�䣬��λΪ��   
BROKEN                 VARCHAR2(1)          ��־������Y��ʾ�����жϣ��Ժ󲻻�����   
INTERVAL               VARCHAR2(200)        ���ڼ�����һ����ʱ��ı��ʽ   
FAILURES               NUMBER               ������������û�гɹ��Ĵ���   
WHAT                   VARCHAR2(2000)       ִ�������PL/SQL��   
CURRENT_SESSION_LABEL  RAW MLSLABEL         �����������Oracle�Ự��   
CLEARANCE_HI           RAW MLSLABEL         ����������ε�Oracle����϶   
CLEARANCE_LO           RAW MLSLABEL         ����������ε�Oracle��С��϶   
NLS_ENV                VARCHAR2(2000)       �������е�NLS�Ự����   
MISC_ENV               RAW(32)              �������е�����һЩ�Ự����  