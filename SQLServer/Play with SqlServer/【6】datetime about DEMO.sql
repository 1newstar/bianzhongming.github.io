--�������ö�ʱ���Ӱ��

set language british;
select cast('02/12/2017' as datetime);
--2017-12-02 00:00:00.000
select cast('20170212' as datetime);
--2017-02-12 00:00:00.000
select cast('2017-02-12' as datetime)
--2017-12-02 00:00:00.000

set language us_english;
select cast('02/12/2017' as datetime);
--2017-12-02 00:00:00.000
select cast('20170212' as datetime);
--2017-02-12 00:00:00.000
select cast('2017-02-12' as datetime)
--2017-12-02 00:00:00.000

--����ʹ��'20170212'����ʱ���ʽ���ܱ����������õ�Ӱ�����⣩

select @@version
/*Microsoft SQL Server 2012 - 11.0.2100.60 (X64) 
	Feb 10 2012 19:39:15 
	Copyright (c) Microsoft Corporation
	Enterprise Edition (64-bit) on Windows NT 6.1 <X64> (Build 7601: Service Pack 1) (Hypervisor)
*/
select cast('20170212 12:15:45.115' as datetime); --2017-02-12 12:15:45.117 �������⣬�������
select cast('20170212 12:15:45.115' as datetime2);  --2017-02-12 12:15:45.1150000

-----------------ʱ���ȡ
select 
getdate(), --2017-04-05 17:21:34.863
CURRENT_TIMESTAMP, --2017-04-05 17:21:34.863  --ANSI SQL��׼���Ƽ�ʹ��
getutcdate(), --2017-04-05 09:21:34.863  --UTCʱ��
sysdatetime(),--2017-04-05 17:21:34.8640435  --datetime2��ʽʱ��
sysutcdatetime(),--2017-04-05 09:21:34.8640435  --datetime2��ʽUTCʱ��
sysdatetimeoffset() --2017-04-05 17:21:34.8640435 +08:00  --datetimeoffset��ʽʱ��
;

-----------------ʱ��ת�� SWITCHOFFSET(datatimeoffset_value,time_zone)
select 
sysdatetimeoffset(), --2017-04-05 17:21:05.0201555 +08:00
SWITCHOFFSET(sysdatetimeoffset() ,'+00:00')--2017-04-05 09:21:05.0201555 +00:00  --UTCʱ��

--datetime��ʽת����datetimeoffset  TODATETIMEOFFSET(data_and_time_value,time_zone)
select 
sysdatetimeoffset(), --2017-04-05 17:25:21.4255765 +08:00
TODATETIMEOFFSET(sysdatetimeoffset(),'+09:00'), --2017-04-05 17:25:21.4255765 +09:00 --ʱ�䲻���κ�ת�����㣬ֻ��ָ��ʱ��
TODATETIMEOFFSET(sysdatetime(),'+08:00') --2017-04-05 17:25:21.4255765 +08:00

-----------------ʱ�����
--DATEADD(part,n,dt_val)
select current_timestamp,
dateadd(year,+1,current_timestamp),
dateadd(quarter,+1,current_timestamp), --����
dateadd(month,-10,current_timestamp),
dateadd(dayofyear,-10,current_timestamp),
dateadd(day,-10,current_timestamp),
dateadd(week,-10,current_timestamp),
dateadd(WEEKDAY,-10,current_timestamp)


-----------------ʱ������
--DATEDIFF(part,dt_val1,dt_val2)
select DATEDIFF(day,'2015-01-01','2016-10-23') --661

-----------------ʱ���ȡ
--DATEPART(part,dt_val)
select DATEPART(yy,'2015-03-01'), --2015
year('2015-03-01'), --2015(�ȼ�)
DATEPART(mm,'2015-03-01'), --3
month('2015-03-01'), --3(�ȼ�)
DATEPART(dd,'2015-03-01'),--1
day('2015-03-01'), --1(�ȼ�)
------DATENAME(part,dt_val) -- ����ֵ��ϵͳ�����й�
DATENAME(month,'2015-03-01'),--March (��ϵͳ�����йأ������·�/��/�յ�����)
DATEPART(week, getdate())/*���������*/,
DATEPART(weekday, getdate())/*ʱ����أ������տ�ʼ*/,
DATENAME(weekday, getdate()) --ʱ�����ܼ�

--ʱ���ж�
select 
ISDATE('20150101'),--1
ISDATE('2015-01-01'),--1
ISDATE('20151845')--0



--�ۺϼ���
select   dateadd(dd,-day('20110210'),dateadd(m,1,'20110210'))
--������ĩ
select   dateadd(dd,-day('20110210')+1,'20110210')  
--���µ�һ��
SELECT CONVERT(datetime,CONVERT(char(8),GETDATE(),120)+'1')
--���µĵ�һ��
select dateadd(d,-day(getdate()),dateadd(m,1,getdate()))
--***���µ����һ�죨���ڱ��������һ���ʱ����ȷ�����������ȡ��һ�죬��ȡ���һ�죩 
select dateadd(d,-day(getdate()),dateadd(m,2,getdate()))
--���µ����һ�� 
SELECT DATEADD(mm,DATEDIFF(mm,0,dateadd(month,-1,getdate())),0)
--���µ�һ��
select dateadd(ms,-3,DATEADD(mm,DATEDIFF(mm,0,getdate()),0))
--�������һ��
select DATEADD(SS,-1,dateadd(day,1,CONVERT(varchar(15) , getdate(), 102 )))
--��ȡ��������һ��
