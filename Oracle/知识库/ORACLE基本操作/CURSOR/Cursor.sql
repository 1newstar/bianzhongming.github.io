--�α�
/*open_cursors:ÿ��session����ͬʱ�򿪵��α�����ȱʡ300 �������1000 
 session_cached_cursors:ÿ��session���Է����ڴ��е��α�������
 ����java������˵��ÿ��һ��ResultSet���ͻ������ݿ��д�һ���α꣬cached cursors�ͻ�����һ���� 
 ���Զ���һ��java��������ݿ���˵������ڴ��㹻�Ļ����������Ӧ�����õĴ�һЩ�����ó�2000�ȽϺ��ʡ�  
*/
--��ѯ
SQL>show parameter open_cursors;
select count(1) from v$open_cursor;

--����
SQL>alter system set open_cursors = 10000;  
SQL>commit;   

--��λ���α�����SQL�������룬�Ƿ����α�й¶�Ĵ��롣
select count(*) ,sql_text from v$open_cursor group by sql_text order by count(*) desc;






�������ܽ���α����������


����2���α�ֵ���ݿ�������ԭ
show parameter spfile;
