/*
Navicat MySQL Data Transfer

Source Server         : Ngocthuy
Source Server Version : 50141
Source Host           : localhost:3306
Source Database       : marketdb

Target Server Type    : MYSQL
Target Server Version : 50141
File Encoding         : 65001

Date: 2012-05-14 21:38:56
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `bk_product`
-- ----------------------------
DROP TABLE IF EXISTS `bk_product`;
CREATE TABLE `bk_product` (
  `pro_code` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pro_cost` int(11) DEFAULT NULL,
  `pro_quantity` int(11) DEFAULT NULL,
  `pro_date` date DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bk_product
-- ----------------------------
INSERT INTO bk_product VALUES ('HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
INSERT INTO bk_product VALUES ('HC415', 'Pavilion 4105TX', '680', '1000', '2008-08-21', '1');
INSERT INTO bk_product VALUES ('DR071', 'Inspiron 17R', '908', '520', '2009-03-15', '2');
INSERT INTO bk_product VALUES ('AS255', 'Aspire One D255', '325', '1650', '2008-11-20', '3');
INSERT INTO bk_product VALUES ('IB060', 'ThikPad T60', '415', '1200', '2009-03-28', '4');

-- ----------------------------
-- Table structure for `tblmarkets`
-- ----------------------------
DROP TABLE IF EXISTS `tblmarkets`;
CREATE TABLE `tblmarkets` (
  `mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `mar_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_pro_quantity` int(11) DEFAULT NULL,
  `pro_code` char(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_price_plus` float DEFAULT NULL,
  PRIMARY KEY (`mar_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tblmarkets
-- ----------------------------
INSERT INTO tblmarkets VALUES ('1', 'Maxi', '50', 'HC631', '12');
INSERT INTO tblmarkets VALUES ('2', '7-Eleven', '200', 'DR017', '18');
INSERT INTO tblmarkets VALUES ('3', 'Migros', '1000', 'AS255', '15');
INSERT INTO tblmarkets VALUES ('4', 'Costco', '430', 'AS255', '12');
INSERT INTO tblmarkets VALUES ('5', 'Coop Norden', '950', 'IB060', '14');

-- ----------------------------
-- Table structure for `tblproducts`
-- ----------------------------
DROP TABLE IF EXISTS `tblproducts`;
CREATE TABLE `tblproducts` (
  `pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pro_cost` int(11) DEFAULT NULL,
  `pro_quantity` int(11) DEFAULT NULL,
  `pro_date` date DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pro_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tblproducts
-- ----------------------------
INSERT INTO tblproducts VALUES ('HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
INSERT INTO tblproducts VALUES ('HC415', 'Pavilion 4105TX', '680', '1000', '2008-08-21', '1');
INSERT INTO tblproducts VALUES ('DR071', 'Inspiron 17R', '908', '520', '2009-03-15', '2');
INSERT INTO tblproducts VALUES ('AS255', 'Aspire One D255', '325', '1650', '2008-11-20', '3');
INSERT INTO tblproducts VALUES ('IB060', 'ThikPad T60', '415', '1200', '2009-03-28', '4');

-- ----------------------------
-- Table structure for `tblsupplies`
-- ----------------------------
DROP TABLE IF EXISTS `tblsupplies`;
CREATE TABLE `tblsupplies` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `sup_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sup_addrress` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tblsupplies
-- ----------------------------
INSERT INTO tblsupplies VALUES ('1', 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA');
INSERT INTO tblsupplies VALUES ('2', 'DELL', 'Dell Way Round Rock, Texas 78682 USA');
INSERT INTO tblsupplies VALUES ('3', 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan');
INSERT INTO tblsupplies VALUES ('4', 'IBM', 'Kevin O\'Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');
3.1
CREATE view 31 AS
SELECT p.pro_name,p.pro_cost,s.sup_name,m.mar_name
FROM tblproducts as p INNER JOIN tblmarkets as m
INNER JOIN tblsupplies as s
ON p.pro_code = m.pro_code and p.sup_id = s.sup_id;
3.2
CREATE view 32 AS
SELECT tblproducts.pro_code,tblproducts.pro_cost,tblproducts.pro_name,tblproducts.pro_quantity
FROM tblproducts
WHERE Not EXISTS
  (select *
    from tblmarkets
    where tblproducts.pro_code = tblmarkets.pro_code);
3.3
Create view 33
AS
Select p.Pro_name,m.mar_name,m.mar_pro_quantity,s.sup_name
from tblProducts p inner join tblSupplies s on p.sup_id=s.sup_id inner join tblMarkets m on m.pro_code=p.pro_code
Where p.pro_cost=(select max(p.pro_cost*(1+m.mar_price_plus)/100));
3.4
CREATE VIEW view34(pro_name, mar_name, mar_pro_quantity, sup_name ) AS
SELECT pro_name, mar_name, mar_pro_quantity, sup_name 
FROM tblmarkets AS a INNER JOIN tblproducts AS b ON a.pro_code=b.pro_code
INNER JOIN tblsupplies AS c ON c.sup_id=b.sup_id
WHERE a.mar_pro_quantity = ( SELECT MAX(a.mar_pro_quantity) FROM tblmarkets AS a);
3.5
CREATE VIEW view35 AS
SELECT p.pro_code,p.pro_cost,p.pro_quantity,s.sup_name,p.pro_name
FROM tblproducts as p  INNER JOIN tblsupplies  as s ON 
p.sup_id = s.sup_id
WHERE p.pro_cost = (SELECT min(p.pro_cost) FROM tblproducts); 
4.1
delimiter //
CREATE PROCEDURE pro41()
begin
drop view if exists view_pro_max_quantily ;
create view view_pro_max_quantily  as
select max(pro_quanity) as max_quantily
from tblproducts
limit 1;
select pro_name, pro_code, sup_name, pro_quanity
from tblproducts, tblsupplies, view_pro_max_quantily
where tblproducts.sup_id = tblsupplies.sup_id and pro_quanity = (select max_quantily from view_pro_max_quantily );
end //
 
4.2
delimiter //
CREATE PROCEDURE pro42()
begin
drop view if exists view_pro_max_cost;
create view view_pro_max_cost as
select max(pro_cost) as max_cost
from tblproducts
limit 1;
select pro_name, pro_code, pro_date
from tblproducts, view_pro_max_cost
where pro_cost = (select max_cost from view_pro_max_cost);
end //
4.3
CREATE PROCEDURE pro43()
begin
drop view if exists view_pro_most_sold;
create view view_pro_most_sold as
select count(mar_id) as most_sold, pro_code as pro_max_code
from tblmarkets
where 1 = 1
group by pro_code
order by most_sold desc
limit 1;
select pro_name, tblproducts.pro_code, mar_name
from tblproducts, tblmarkets
where tblproducts.pro_code = tblmarkets.pro_code and tblproducts.pro_code = (select pro_max_code from view_pro_most_sold);
end //
5.1

CREATE TRIGGER del
AFTER DELETE ON tblproducts
FOR EACH ROW
BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END;
5.2
CREATE TRIGGER productUpdate
AFTER UPDATE ON tblproducts
FOR EACH ROW
BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END;

