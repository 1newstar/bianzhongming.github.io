sql*loader  ��һ������,  ������  �ı��ļ����������,   ���뵽 Oracle ���ݿ����档

������һ���򵥵����ӣ�

SQL*Loader

������Ҫһ�� �����ļ�test_main.ctl���������£�
LOAD DATA
INFILE *
INTO TABLE test_main
FIELDS TERMINATED BY ','
(ID, VALUE)
BEGINDATA
1,Test

���У�
��һ��LOAD DATA��˼�Ǹ���SQL*Loader��Ҫ��ɶ? �����Ǽ������ݡ�
�ڶ���INFILE *��˼�����ݴ�������? �����ǰ����ڿ����ļ��С�
������INTO TABLE ��˼������Ҫ������� ������Ҫ�� test_main ��
������FIELDS TERMINATED BY��˼������֮����ʲô���ŷָ��� �������� ���� �ָ���
������������Ҫ��ʲô˳��д��������
������BEGINDATA�Ǹ���SQL*Loader������Ķ��������ˡ�

Ȼ��ʼ���� sqlldr ����

D:\temp>sqlldr userid=test/test123 control=test_main.ctl
SQL*Loader: Release 10.2.0.1.0 - Production on ������ 3�� 13 14:58:22 2011
Copyright (c) 1982, 2005, Oracle.  All rights reserved.
SQL*Loader-601:  ���� INSERT ѡ��, �����Ϊ�ա��� TEST_MAIN �ϳ���

�� SQL Plus �У�
SQL> truncate table test_main;
���ضϡ�
�Ժ��ٴβ���ִ��

D:\temp>sqlldr userid=test/test123 control=test_main.ctl
SQL*Loader: Release 10.2.0.1.0 - Production on ������ 3�� 13 14:58:56 2011
Copyright (c) 1982, 2005, Oracle.  All rights reserved.
�ﵽ�ύ�� - �߼���¼���� 1