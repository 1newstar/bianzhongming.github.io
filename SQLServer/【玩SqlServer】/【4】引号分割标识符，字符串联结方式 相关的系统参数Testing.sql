-------------���ŷָ��ʶ��
select '1223' nn,"1233445" mm;
--��Ϣ 207������ 16��״̬ 1���� 1 ��
--Invalid column name '1233445'.

set QUOTED_IDENTIFIER OFF;
select '1223' nn,"1233445" mm
--1223	1233445

set QUOTED_IDENTIFIER ON; --���ϱ�׼SQL�涨��default��


---------------�ַ������᷽ʽ��NULL��
select NULL+'aa' --NULL

set CONCAT_NULL_YIELDS_NULL OFF; --NULL���տմ�����

select NULL+'aa' --aa

set CONCAT_NULL_YIELDS_NULL ON;  --ANSI SQL�涨��default��