---����
0.�ȱ��ݣ����������в��ֱ��ݣ�ע�ⱸ��pk����һһ��Ӧ���л�ԭ��
1.�漰���㴦��
    (1)ע���null���е���������ٽ���(NULL���м���/in ������ΪNULL/FALSE)  ��������nvl(a.x,0)/no in�ĳ�not exists
    (2)����ע��0  decode(nvl(a.x,0),0,'',A/nvl(a.x,0))
    (3)ע�⸺����С��
2.���ظ�������©�����е����ݣ�select�������ֶζ�Ҫ����ɸ�飩
3.�����߼���ϵ������һ��Ҫ��У�飬����ȫ�������߼�У�����������Ҫ���в�����֤
4.not in��Ŀ���������ڿո���ƥ�䲻�����
5.Excel����Ǩ�Ƶ���淶������-->txtճ������-->���õ�Ԫ���ı���ʽ-->ճ��-->���CSV
-----------------

drop table tmpbzm purge;
--������ʱ��
create table tmpBZM
(
  vbatchcode          VARCHAR2(30),
    vdef25              VARCHAR2(100)
);

--������֤
select count(*) from tmpBZM;

--��������
create index tmpBZM_i_10 on tmpBZM(vbatchcode) parallel nologging;
alter index tmpBZM_i_10  noparallel;

--��ѯ�ظ���¼
Select t.rowid, t.vbatchcode
  From tmpBZM t
 Where vbatchcode In
       (Select vbatchcode From tmpBZM Group By vbatchcode Having Count(*) > 1)
 order by t.vbatchcode;
/*--����һ��(ȥ�ظ�)
Delete tmpBZM t  --����rowid����
 Where t.rowid in ('AAYGORABiAABvfYACv');*/
 ----------------
 ɾ�����ж�����ظ���¼���ظ���¼�Ǹ��ݵ����ֶΣ�Id�����жϣ�ֻ����rowid��С�ļ�¼
DELETE from �� WHERE (id) IN ( SELECT id FROM �� GROUP BY id HAVING COUNT(id) > 1) AND ROWID NOT IN (SELECT MIN(ROWID) FROM �� GROUP BY id HAVING COUNT(*) > 1);
 -----------------
 
--ȷ�����ݲ���©
select a.allnum, b.innum
  from (select count(*) allnum from tmpBZM) a,
       (select count(*) innum
          from tmpBZM
         where vbatchcode in (select vbatchcode from ts_batchcode)) b;
--485	484  �޸ĺ�485	485
/*--�鿴���ڲ�������
select a.vbatchcode from tmpBZM a
where a.vbatchcode not in (select b.vbatchcode from ts_batchcode b where a.vbatchcode=b.vbatchcode) for update*/

--��������  20150107zppl.tsv
select vbatchcode,vdef25
  from ts_batchcode
 where vbatchcode in (select vbatchcode from tmpBZM);

--��������
UPDATE ts_batchcode a
 SET a.vdef25 = (select b.vdef25 from tmpBZM b where b.vbatchcode=a.vbatchcode)
where a.vbatchcode in (select vbatchcode
                from tmpBZM );
--��֤
select b.docname,a.vdef25 from ts_batchcode a,bd_defdoc b where vbatchcode = '601130103090' and a.vdef25=b.PK_DEFDOC;
--�ύ
commit;
drop table tmpBZM purge;

