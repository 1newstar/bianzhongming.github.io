--客户最新的三个订单(1:N关系)
select * from sales.orders where custid =85 order by orderdate desc;
--select * from Sales.Customers where custid=85;

--CROSS ALPPLY
SELECT C.custid, d.*
  FROM Sales.Customers AS C
       CROSS APPLY (SELECT TOP 3
                           *
                      FROM sales.orders o
                     WHERE c.custid = o.custid
                    ORDER BY orderdate DESC) AS D;

--子查询实现
--因为1：N，子查询只能1:1，除非写3个SQL UNION ALL，否则实现不了。

--派生表实现(winsows function/子查询)
SELECT C.custid, o.*
  FROM Sales.Customers AS C join (
SELECT row_number () OVER (PARTITION BY o.custid ORDER BY o.orderdate DESC) sid,
       *
  FROM sales.orders o
  ) O on c.custid = o.custid
  where o.sid<=3
