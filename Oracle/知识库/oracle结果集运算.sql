--oracle���������
--��+�� union(ȥ��ƴ�ӣ�Ĭ�Ϲ�������) ,union all��ֱ��ƴ�ӣ�������
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003') 
union
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003');

select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003') 
union all
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003');

--��-��intersect<ȡ����>(ȥ���ͬ��ȥ�أ�Ĭ�Ϲ�������)��minus<��˳��>(A-B,Ĭ�Ϲ�������)
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003') 
intersect
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J004');

select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J003') 
minus
select d.unitname,  d.unitcode from bd_corp d where d.unitcode in ('J001','J002','J004');
