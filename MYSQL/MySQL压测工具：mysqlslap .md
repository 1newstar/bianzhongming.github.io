>ѡ��slap��ԭ��Mysql�Դ����������ⰲװ���򵥷��㣻
>slap���ƣ���֧��SQL��������ֻ�ܴ洢����ʵ�֣�Ȼ���ȡ�洢���̣���

## 1.����˵����

```
--concurrency��������������������ö��Ÿ�����concurrency=10,50,100, ���������߳����ֱ���10��50��100��������
--engines����Ҫ���Ե����棬�����ж�����÷ָ���������
--iterations����Ҫ������Щ���Զ��ٴΡ�
--auto-generate-sql ������ϵͳ�Լ����ɵ�SQL�ű������ԡ�
--auto-generate-sql-load-type ����Ҫ���Ե��Ƕ�����д�������߻�ϵģ�read,write,update,mixed��
--number-of-queries �����ܹ�Ҫ���ж��ٴβ�ѯ��ÿ���ͻ����еĲ�ѯ���������ò�ѯ����/�����������㡣
--debug-info ����Ҫ�������CPU�Լ��ڴ�������Ϣ��
--number-int-cols ���������Ա�� int ���ֶ�����
--auto-generate-sql-add-autoincrement : ��������ɵı��Զ����auto_increment�У���5.1.18�汾��ʼ
--number-char-cols �������Ա�� char ���ֶ�������
--create-schema ���Ե�schema��MySQL��schemaҲ����database��
--query ʹ���Զ���ű�ִ�в��ԣ�������Ե����Զ����һ���洢���̻���sql�����ִ�в��ԡ�
--delimiter ˵��sql�ļ�������ķָ�����ʲô
--only-print ���ֻ���ӡ����SQL�����ʲô�����������ѡ��
```
## 2.������

```
����ѹ��:
mysqlslap --concurrency=50  --number-of-queries=100 --iterations=1 --create-schema='testdb' --debug-info  --socket=/export/servers/data/my3310/run/mysqld.sock --query="SELECT * FROM TESTTABLE;" 

���ѹ�⣺
mysqlslap  -uUser_NAME -P3310 -hHOSTNAME -p123456 --concurrency=50  --number-of-queries=100 --iterations=1 --create-schema='testdb' --debug-info --query="SELECT * FROM TESTTABLE ;" 

ָ��ִ�нű���
mysqlslap �Cuser=root �Cpassword=111111 �Cconcurrency=20 �Cnumber-of-queries=1000 �Ccreate-schema=employees �Cquery="select_query.sql" �Cdelimiter=";"
```
��ϲ���ϵͳ��Ϣ����ȷ����Ӧ��ϵͳƿ����

## ��

- �ο���http://blog.chinaunix.net/uid-259788-id-2139303.html
- �洢���̰�����

```sql
DELIMITER $$

DROP PROCEDURE IF EXISTS `t_girl`.`sp_get_article`$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_get_article`(IN f_category_id int,
 IN f_page_size int, IN f_page_no int
)
BEGIN
  set @stmt = 'select a.* from article as a inner join ';
  set @stmt = concat(@stmt,'(select a.aid from article as a ');
  if f_category_id != 0 then
    set @stmt = concat(@stmt,' inner join (select cid from category where cid = ',f_category_id,' or parent_id = ',f_category_id,') as b on a.category_id = b.cid');
  end if;
  if f_page_size >0 && f_page_no > 0 then
    set @stmt = concat(@stmt,' limit ',(f_page_no-1)*f_page_size,',',f_page_size);
  end if; 
 
  set @stmt = concat(@stmt,') as b on (a.aid = b.aid)');
  prepare s1 from @stmt;
  execute s1;
  deallocate prepare s1;
  set @stmt = NULL;
END$$

DELIMITER ;
```
```
[root@localhost ~]# mysqlslap --defaults-file=/usr/local/mysql-maria/my.cnf --concurrency=25,50,100 --iterations=1 --query='call t_girl.sp_get_article(2,10,1);' --number-of-queries=5000 --debug-info -uroot -p -S/tmp/mysql50.sock
```