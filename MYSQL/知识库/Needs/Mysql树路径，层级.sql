-- -------------�ڵ���ֻ�������֣��Ҹ��ڵ�Ϊ1�����ڵ�������ӽڵ�֮ǰ���ܳ���ȷ���
CREATE TABLE `treenodes` (
  `id` int , -- �ڵ�ID
  `nodename` varchar (60), -- �ڵ�����
  `pid` int -- �ڵ㸸ID
);

INSERT INTO `treenodes` (`id`, `nodename`, `pid`)
VALUES
	('1', 'A', '0'),
	('2', 'B', '1'),
	('3', 'C', '1'),
	('4', 'D', '2'),
	('5', 'E', '2'),
	('6', 'F', '3'),
	('7', 'G', '6'),
	('8', 'H', '0'),
	('9', 'I', '8'),
	('10', 'J', '8'),
	('11', 'K', '8'),
	('12', 'L', '9'),
	('13', 'M', '9'),
	('14', 'N', '12'),
	('15', 'O', '12'),
	('16', 'P', '15'),
	('17', 'Q', '15'),
	('18', 'R', '3'),
	('19', 'S', '2'),
	('20', 'T', '6'),
	('21', 'U', '8');

SELECT id AS ID,pid AS ��ID ,levels+1 AS ������֮�伶��, concat(paths,',',id) AS ������·�� FROM (
   SELECT id,pid,
   @le:= IF (pid = 0 ,0, 
     IF( LOCATE( CONCAT('|',pid,':'),@pathlevel)  > 0 ,   
         SUBSTRING_INDEX( SUBSTRING_INDEX(@pathlevel,CONCAT('|',pid,':'),-1),'|',1) +1
    ,@le+1) ) levels
   , @pathlevel:= CONCAT(@pathlevel,'|',id,':', @le ,'|') pathlevel
   , @pathnodes:= IF( pid =0,'0', 
      CONCAT_WS(',',
      IF( LOCATE( CONCAT('|',pid,':'),@pathall) > 0 , 
        SUBSTRING_INDEX( SUBSTRING_INDEX(@pathall,CONCAT('|',pid,':'),-1),'|',1)
       ,@pathnodes ) ,pid ) )paths
  ,@pathall:=CONCAT(@pathall,'|',id,':', @pathnodes ,'|') pathall 
    FROM treenodes, 
  (SELECT @le:=0,@pathlevel:='', @pathall:='',@pathnodes:='') vv
  ORDER BY pid,id
  ) src
ORDER BY id;

drop table treenodes;

-- -------------IDΪ��ĸ����
CREATE TABLE `treenodes` (
  `id` varchar(10) , -- �ڵ�ID
  `nodename` varchar (60), -- �ڵ�����
  `pid` varchar(10) -- �ڵ㸸ID
);

INSERT INTO `treenodes` (`id`, `nodename`, `pid`)
VALUES
	('A1', 'A', NULL),
	('A2', 'B', 'A1'),
	('A3', 'C', 'A1'),
	('A4', 'D', 'A2'),
	('A5', 'E', 'A2'),
	('A6', 'F', 'A3'),
	('A7', 'G', 'A6');

SELECT id AS ID,pid AS ��ID ,levels AS ������֮�伶��, concat(paths,',',id) AS ������·�� FROM (
   SELECT id,pid,
   @le:= IF (pid = NULL ,0, 
     IF( LOCATE( CONCAT('|',pid,':'),@pathlevel)  > 0 ,   
         SUBSTRING_INDEX( SUBSTRING_INDEX(@pathlevel,CONCAT('|',pid,':'),-1),'|',1) +1
    ,@le+1) ) levels
   , @pathlevel:= CONCAT(@pathlevel,'|',id,':', @le ,'|') pathlevel
   , @pathnodes:= IF( pid =NULL,'0', 
      CONCAT_WS(',',
      IF( LOCATE( CONCAT('|',pid,':'),@pathall) > 0 , 
        SUBSTRING_INDEX( SUBSTRING_INDEX(@pathall,CONCAT('|',pid,':'),-1),'|',1)
       ,@pathnodes ) ,pid ) )paths
  ,@pathall:=CONCAT(@pathall,'|',id,':', @pathnodes ,'|') pathall 
    FROM treenodes, 
  (SELECT @le:=0,@pathlevel:='', @pathall:='',@pathnodes:='') vv
  ORDER BY pid,id
  ) src
ORDER BY id

drop table treenodes;


-- ���д����
/* 
�淶ID�������򣬰�������
N01 N00
N03 N00
N0101 N01
N0102 N01
N0301 N03
������ʹ���ڵ���ӽڵ���ڹ�����ϵ��������Բ�ѯ�кܶ�ô�
*/
