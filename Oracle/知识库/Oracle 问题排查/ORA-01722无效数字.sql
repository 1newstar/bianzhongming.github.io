��ԭ��ɸѡ�������ͺ����ݿ��������Ͳ���
�������where������һ�Ų飬�鿴�Ƿ�����������ͣ��������϶�����÷����������Ų�ķ���
   
   select *
  from workflow_requestlog
 where workflowid = 5085
   and logtype = '3' -- and logtype = 3 logtype��char(1)
   and nodeid in ('11173', '11168')
   and OPERATEDATE > '2014-01-01'
