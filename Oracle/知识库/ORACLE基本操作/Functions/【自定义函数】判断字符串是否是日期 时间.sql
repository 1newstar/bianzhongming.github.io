/*�ж��ַ����Ƿ������ڸ�ʽ*/ 

CREATE OR REPLACE FUNCTION is_date(parameter VARCHAR2) RETURN NUMBER IS
  val DATE;
BEGIN
  val := TO_DATE(NVL(parameter, 'a'), 'yyyy-mm-dd hh24:mi:ss');
  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END; 

/*����*/ 

select is_date('12000') from dual; /*����0*/
select is_date('1949-10-01') from dual; /*����1*/ 

  

  

/*�ж��ַ����Ƿ������ָ�ʽ*/ 

CREATE OR REPLACE FUNCTION is_number(parameter VARCHAR2) RETURN NUMBER IS
  val NUMBER;
BEGIN
  val := TO_NUMBER(NVL(parameter, 'a'));
  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END; 

/*����*/ 

select is_date('abc') from dual; /*����0*/
select is_date('123') from dual; /*����1*/
