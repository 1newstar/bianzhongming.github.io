�����塿Oracle�ַ�����һ���ֽ����ݵĽ��͵ķ��ż���,�д�С֮��,���໥�İ��ݹ�ϵ��

 

Ӱ��Oracle���ݿ��ַ�������Ҫ�Ĳ�����NLS_LANG������

���ĸ�ʽ����: NLS_LANG = language_territory.charset

����������ɲ���(���ԡ�������ַ���)��ÿ���ɷֿ�����NLS�Ӽ������ԡ�

����:

Language�� ָ����������Ϣ�����ԣ� Ӱ����ʾ��Ϣ�����Ļ���Ӣ��

Territory�� ָ�������������ں����ָ�ʽ��

Charset��  ָ���ַ�����

��:AMERICAN _ AMERICA. ZHS16GBK

��NLS_LANG��������ǿ��Կ���������Ӱ�����ݿ��ַ�������ʵ�ǵ������֡�

�����������ݿ�֮����ַ���ֻҪ��������һ���Ϳ����໥���뵼�����ݣ�ǰ��Ӱ���ֻ����ʾ��Ϣ�����Ļ���Ӣ�ġ�

��

 

����. �鿴���ݿ��ַ���

���ݿ�������ַ���select * from nls_database_parameters������Դ��props$���Ǳ�ʾ���ݿ���ַ�����
����
�����ͻ����ַ�������select * from nls_instance_parameters,����Դ��v$parameter��
����
������ʾ�ͻ��˵��ַ��������ã������ǲ����ļ�����������������ע���
����
�����Ự�ַ������� select * from nls_session_parameters������Դ��v$nls_parameters����ʾ�Ự�Լ������ã������ǻỰ�Ļ�������������alter session��ɣ�����Ựû����������ã�����nls_instance_parametersһ�¡�
����
�����ͻ��˵��ַ���Ҫ���������һ�£�������ȷ��ʾ���ݿ�ķ�Ascii�ַ������������ô��ڵ�ʱ��alter session>��������>ע���>�����ļ�
����
�����ַ���Ҫ��һ�£�������������ȴ���Բ�ͬ���������ý�����Ӣ�ġ����ַ�����zhs16gbk����nls_lang������American_America.zhs16gbk��


�漰��������ַ�����

1. oracel server�˵��ַ���;

2. oracle client�˵��ַ���;

3. dmp�ļ����ַ�����

 

�������ݵ����ʱ����Ҫ�������ַ�����һ�²�����ȷ���롣

 

2.1 ��ѯoracle server�˵��ַ���

�кܶ��ַ������Բ��oracle server�˵��ַ������Ƚ�ֱ�۵Ĳ�ѯ��������������:

SQL> select userenv('language') from dual;

USERENV('LANGUAGE')

----------------------------------------------------

SIMPLIFIED CHINESE_CHINA.ZHS16GBK

 

SQL>select userenv(��language��) from dual;

AMERICAN _ AMERICA. ZHS16GBK

 

2.2 ��β�ѯdmp�ļ����ַ���

��oracle��exp���ߵ�����dmp�ļ�Ҳ�������ַ�����Ϣ��dmp�ļ��ĵ�2�͵�3���ֽڼ�¼��dmp�ļ����ַ��������dmp�ļ����󣬱���ֻ�м�M��ʮM��������UltraEdit��(16���Ʒ�ʽ)������2��3���ֽڵ����ݣ���0354��Ȼ��������SQL�������Ӧ���ַ���:

SQL> select nls_charset_name(to_number('0354','xxxx')) from dual;

ZHS16GBK

 

���dmp�ļ��ܴ󣬱�����2G����(��Ҳ����������)�����ı��༭���򿪺���������ȫ�򲻿�����������������(��unix������):

cat exp.dmp |od -x|head -1|awk '{print $2 $3}'|cut -c 3-6

Ȼ��������SQLҲ���Եõ�����Ӧ���ַ�����

 

2.3 ��ѯoracle client�˵��ַ���

��windowsƽ̨�£�����ע���������ӦOracleHome��NLS_LANG����������dos���������Լ����ã�

����: set nls_lang=AMERICAN_AMERICA.ZHS16GBK

������ֻӰ�������������Ļ���������

 

��unixƽ̨�£����ǻ�������NLS_LANG��

$echo $NLS_LANG

AMERICAN_AMERICA.ZHS16GBK

 

������Ľ������server����client���ַ�����һ�£���ͳһ�޸�Ϊͬserver����ͬ���ַ�����

 

���䣺

(1).���ݿ�������ַ���

select * from nls_database_parameters

��Դ��props$���Ǳ�ʾ���ݿ���ַ�����

 

(2).�ͻ����ַ�������

select * from nls_instance_parameters

����Դ��v$parameter����ʾ�ͻ��˵��ַ��������ã������ǲ����ļ�����������������ע���

 

(3).�Ự�ַ�������

select * from nls_session_parameters

��Դ��v$nls_parameters����ʾ�Ự�Լ������ã������ǻỰ�Ļ�������������alter session��ɣ�����Ựû����������ã�����nls_instance_parametersһ�¡�

 

(4).�ͻ��˵��ַ���Ҫ���������һ�£�������ȷ��ʾ���ݿ�ķ�Ascii�ַ���

���������ô��ڵ�ʱ��NLS�������ȼ���Sql function > alter session > ����������ע��� > �����ļ� > ���ݿ�Ĭ�ϲ���

 

�ַ���Ҫ��һ�£�������������ȴ���Բ�ͬ���������ý�����Ӣ�ġ����ַ�����zhs16gbk����nls_lang������American_America.zhs16gbk��
