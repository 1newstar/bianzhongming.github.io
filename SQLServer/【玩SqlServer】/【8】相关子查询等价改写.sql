if(object_id('dbo.saleorder','U') is not null) drop table saleorder;
create table saleorder(orderid varchar(50) primary key,orderPrice decimal(20,8) null,orderdate date not null,userid varchar(50) not null);
insert into saleorder values 
('1001',100.23,'2015-01-01','001'),
('1002',140.23,'2015-11-01','001'),
('1003',150.23,'2015-03-01','001'),
('1004',110.23,'2015-09-01','002'),
('1005',160.23,'2015-06-01','002'),
('1006',130.23,'2015-03-01','002');

--ȡ��ÿ��USER���µ�order��Ϣ
select orderid,orderPrice,orderdate,userid from saleorder o 
where orderdate=(select max(i.orderdate) from saleorder i where i.userid=o.userid)
--�������д
select o.orderid,o.orderPrice,o.orderdate,o.userid from saleorder o  join
(select max(orderdate) orderdate,userid from saleorder group by userid) a 
on (a.userid=o.userid and a.orderdate=o.orderdate)

--��ȡ��ǰ�������ռ�ͻ������ܶ�İٷֱ�
select orderid,orderPrice,
100.*orderPrice/(select sum(i.orderPrice) from saleorder i where o.userid=i.userid) percentageOfAllOrderPrice,
orderdate,userid from saleorder o 
--��������COST����
select orderid,orderPrice,
100.*orderPrice/(sum(orderPrice) over(partition by userid)) percentageOfAllOrderPrice,
orderdate,userid from saleorder o 


drop table saleorder;