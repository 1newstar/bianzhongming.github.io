--�ӱ������ȡ��¼ ��bd_corp�������ȡ3����¼
select * from (select * from bd_corp order by dbms_random.random) where rownum < 4
     
--�����������������
SELECT DBMS_RANDOM.RANDOM FROM DUAL;  --�����С�������
SELECT ABS(MOD(DBMS_RANDOM.RANDOM,100)) FROM DUAL;  --0��100���ڵ������
select trunc(dbms_random.value(100,1000)) from dual; -- 100��1000֮��������
--����16λ�����
select to_char(trunc(dbms_random.value(1000000000000000,9999999999999999))) from dual; 

--�����������С����
SELECT dbms_random.value FROM dual; --0��1֮��������
SELECT dbms_random.value(10,20) FROM dual;  --10��20֮��������
SELECT dbms_random.normal FROM dual;
--NORMAL�������ط�����̬�ֲ���һ����������̬�ֲ���׼ƫ��Ϊ1������ֵΪ0������������ص���ֵ����68%�ǽ���-1��+1֮�䣬95%����-2��+2֮�䣬99%����-3��+3֮�䡣

--��������ַ���
select dbms_random.string('P',20) from dual;  --P ��ʾprintable�����ַ���������ɴ�ӡ�ַ����ɣ�20Ϊ�ַ�������
select dbms_random.string(opt, length) from dual
      opt��ȡֵ���£�
      'u','U'    :    ��д��ĸ
      'l','L'    :    Сд��ĸ
      'a','A'    :    ��Сд��ĸ
      'x','X'    :    ���֡���д��ĸ
      'p','P'    :    �ɴ�ӡ�ַ�
--e.g.:   select dbms_random.string('x', 5) from dual

--�������
select to_date(2457161+TRUNC(DBMS_RANDOM.VALUE(0,365)),'J') from dual
--ͨ������������ָ�����ڵĻ���
 select to_char(sysdate,'J') from dual
