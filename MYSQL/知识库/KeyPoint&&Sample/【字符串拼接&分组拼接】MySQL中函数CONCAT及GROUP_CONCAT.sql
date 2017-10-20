һ��CONCAT��������
CONCAT�����������ڽ�����ַ������ӳ�һ���ַ�����
ʹ�����ݱ�Info��Ϊʾ��������SELECT id,name FROM info LIMIT 1;�ķ��ؽ��Ϊ
+----+--------+
| id | name   |
+----+--------+
|  1 | BioCyc |
+----+--------+
1���﷨��ʹ���ص㣺
CONCAT(str1,str2,��)                       
���ؽ��Ϊ���Ӳ����������ַ����������κ�һ������ΪNULL ���򷵻�ֵΪ NULL��������һ������������

2��ʹ��ʾ����
SELECT CONCAT(id, ������, name) AS con FROM info LIMIT 1;���ؽ��Ϊ
+----------+
| con      |
+----------+
| 1,BioCyc |
+----------+

SELECT CONCAT(��My��, NULL, ��QL��);���ؽ��Ϊ
+--------------------------+
| CONCAT('My', NULL, 'QL') |
+--------------------------+
| NULL                     |
+--------------------------+

3�����ָ������֮��ķָ���
ʹ�ú���CONCAT_WS������ʹ���﷨Ϊ��CONCAT_WS(separator,str1,str2,��)
CONCAT_WS() ���� CONCAT With Separator ����CONCAT()��������ʽ����һ�����������������ķָ������ָ�����λ�÷���Ҫ���ӵ������ַ���֮�䡣�ָ���������һ���ַ�����Ҳ��������������������ָ���Ϊ NULL������Ϊ NULL������������κηָ���������� NULL ֵ������CONCAT_WS()��������κο��ַ����� (Ȼ����������е� NULL����

��SELECT CONCAT_WS('_',id,name) AS con_ws FROM info LIMIT 1;���ؽ��Ϊ
+----------+
| con_ws   |
+----------+
| 1_BioCyc |
+----------+

SELECT CONCAT_WS(',','First name',NULL,'Last Name');���ؽ��Ϊ
+----------------------------------------------+
| CONCAT_WS(',','First name',NULL,'Last Name') |
+----------------------------------------------+
| First name,Last Name                         |
+----------------------------------------------+

����GROUP_CONCAT��������
GROUP_CONCAT��������һ���ַ���������ý���ɷ����е�ֵ������϶��ɡ�
ʹ�ñ�info��Ϊʾ�����������SELECT locus,id,journal FROM info WHERE locus IN('AB086827','AF040764');�ķ��ؽ��Ϊ
+----------+----+--------------------------+
| locus    | id | journal                  |
+----------+----+--------------------------+
| AB086827 |  1 | Unpublished              |
| AB086827 |  2 | Submitted (20-JUN-2002)  |
| AF040764 | 23 | Unpublished              |
| AF040764 | 24 | Submitted (31-DEC-1997)  |
+----------+----+--------------------------+

1��ʹ���﷨���ص㣺
GROUP_CONCAT([DISTINCT] expr [,expr ...]
[ORDER BY {unsigned_integer | col_name | formula} [ASC | DESC] [,col ...]]
[SEPARATOR str_val])
�� MySQL �У�����Եõ����ʽ����������ֵ��ͨ��ʹ�� DISTINCT �����ų��ظ�ֵ�����ϣ���Խ���е�ֵ�������򣬿���ʹ�� ORDER BY �Ӿ䡣
SEPARATOR ��һ���ַ���ֵ���������ڲ��뵽���ֵ�С�ȱʡΪһ������ (",")������ͨ��ָ�� SEPARATOR "" ��ȫ���Ƴ�����ָ�����
����ͨ������ group_concat_max_len ����һ�����ĳ��ȡ�������ʱִ�еľ䷨���£� SET [SESSION | GLOBAL] group_concat_max_len = unsigned_integer;
�����󳤶ȱ����ã����ֵ�����е������󳤶ȡ����������ַ����������Զ�ϵͳ�����������ã�SET @@global.group_concat_max_len=40000;

2��ʹ��ʾ����
��� SELECT locus,GROUP_CONCAT(id) FROM info WHERE locus IN('AB086827','AF040764') GROUP BY locus; �ķ��ؽ��Ϊ
+----------+------------------+
| locus    | GROUP_CONCAT(id) |
+----------+------------------+
| AB086827 | 1,2              |
| AF040764 | 23,24            |
+----------+------------------+

��� SELECT locus,GROUP_CONCAT(distinct id ORDER BY id DESC SEPARATOR '_') FROM info WHERE locus IN('AB086827','AF040764') GROUP BY locus;�ķ��ؽ��Ϊ
+----------+----------------------------------------------------------+
| locus    | GROUP_CONCAT(distinct id ORDER BY id DESC SEPARATOR '_') |
+----------+----------------------------------------------------------+
| AB086827 | 2_1                                                      |
| AF040764 | 24_23                                                    |
+----------+----------------------------------------------------------+

���SELECT locus,GROUP_CONCAT(concat_ws(', ',id,journal) ORDER BY id DESC SEPARATOR '. ') FROM info WHERE locus IN('AB086827','AF040764') GROUP BY locus;�ķ��ؽ��Ϊ
+----------+--------------------------------------------------------------------------+
| locus    | GROUP_CONCAT(concat_ws(', ',id,journal) ORDER BY id DESC SEPARATOR '. ') |
+----------+--------------------------------------------------------------------------+
| AB086827 | 2, Submitted (20-JUN-2002). 1, Unpublished                               |
| AF040764 | 24, Submitted (31-DEC-1997) . 23, Unpublished                            |
+----------+--------------------------------------------------------------------------+