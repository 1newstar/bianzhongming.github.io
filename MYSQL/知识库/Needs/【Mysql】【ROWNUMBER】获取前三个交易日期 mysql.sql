-- ��ȡǰ������������ mysql
select a.EXCHANGE_CD,a.CALENDAR_DATE,a.IS_OPEN,a.PREV_TRADE_DATE,
c.PREV_TRADE_DATE ǰ3������
 from vsec_trade_cal a,
(
select @x:=null rownum,''PREV_TRADE_DATE
union all
select 
@x:=ifnull(@x,0)+1 as rownum,PREV_TRADE_DATE
 from vsec_trade_cal group by PREV_TRADE_DATE
) b,
(
select @x:=null rownum,''PREV_TRADE_DATE
union all
select 
@x:=ifnull(@x,0)+1 as rownum,PREV_TRADE_DATE
 from vsec_trade_cal group by PREV_TRADE_DATE
) c
where a.PREV_TRADE_DATE=b.PREV_TRADE_DATE
and b.rownum=c.rownum+2  -- ǰ3������

and a.CALENDAR_DATE='2016-03-14'
and a.EXCHANGE_CD='XSHE'


--Check
select EXCHANGE_CD,CALENDAR_DATE,IS_OPEN,PREV_TRADE_DATE from vsec_trade_cal 
where CALENDAR_DATE like '2016-03-1%'
 and EXCHANGE_CD='XSHE'
order by  2


-- �޲��߼�©�������ӱ������塣
-- �߼���ȡ�õ����ǰ@i-1���ʱ�䣬��ȡ��ʱ���Ӧ����һ��������
-- VALUE��ǰ@i�������գ�@i=0ֱ��ȡ���죬@i<0ʱΪ�����ǰһ��������
set @i=2,  
@sc='XSHG',
@date='2016-09-20';

SELECT
	a.CALENDAR_DATE,
	case when @i=0 then a.CALENDAR_DATE else c.PREV_TRADE_DATE end PREV_TRADE_DATE
FROM
	vsec_trade_cal a,
	(
		SELECT
			@x := NULL rownum,
			'' AS PREV_TRADE_DATE
		UNION ALL
			SELECT
				@x := ifnull(@x, 0) + 1 AS rownum,
				PREV_TRADE_DATE
			FROM
			(select PREV_TRADE_DATE from vsec_trade_cal
      where EXCHANGE_CD=@sc
			GROUP BY
				PREV_TRADE_DATE ) a
	) b,
	(
		SELECT
			@x := NULL rownum,
			'' AS PREV_TRADE_DATE
		UNION ALL
			SELECT
				@x := ifnull(@x, 0) + 1 AS rownum,
				PREV_TRADE_DATE
			FROM
				(select PREV_TRADE_DATE from vsec_trade_cal
      where EXCHANGE_CD=@sc
			GROUP BY
				PREV_TRADE_DATE ) a
	) c
WHERE
	a.PREV_TRADE_DATE = b.PREV_TRADE_DATE
AND b.rownum = c.rownum +( case when @i>1 then @i-1 else 0 end)
AND a.CALENDAR_DATE = @date
AND a.EXCHANGE_CD = @sc;
 

