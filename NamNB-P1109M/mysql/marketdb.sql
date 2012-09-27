/*
Navicat MySQL Data Transfer

Source Server         : namnguyen
Source Server Version : 50141
Source Host           : localhost:3306
Source Database       : marketdb

Target Server Type    : MYSQL
Target Server Version : 50141
File Encoding         : 65001

Date: 2012-05-14 22:08:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `tblbk_product`
-- ----------------------------
DROP TABLE IF EXISTS `tblbk_product`;
CREATE TABLE `tblbk_product` (
  `bkpro_id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pro_cost` int(11) DEFAULT NULL,
  `pro_quantity` int(11) DEFAULT NULL,
  `pro_date` date DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bkpro_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tblbk_product
-- ----------------------------
INSERT INTO tblbk_product VALUES ('1', 'HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
INSERT INTO tblbk_product VALUES ('2', 'HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
INSERT INTO tblbk_product VALUES ('3', 'HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '2');

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
INSERT INTO tblMarkets VALUES ('1', 'Maxi', '50', 'HC631', '12');
INSERT INTO tblMarkets VALUES ('2', '7-Eleven', '200', 'DR017', '18');
INSERT INTO tblMarkets VALUES ('3', 'Migros', '1000', 'AS255', '15');
INSERT INTO tblMarkets VALUES ('4', 'Costco', '430', 'AS255', '12');
INSERT INTO tblMarkets VALUES ('5', 'Coop Norden', '950', 'IB060', '14');

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
INSERT INTO tblProducts VALUES ('HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
INSERT INTO tblProducts VALUES ('HC415', 'Pavilion 4105TX', '680', '1000', '2008-08-21', '1');
INSERT INTO tblProducts VALUES ('DR071', 'Inspiron 17R', '908', '520', '2009-03-15', '2');
INSERT INTO tblProducts VALUES ('AS255', 'Aspire One D255', '325', '1650', '2008-11-20', '3');
INSERT INTO tblProducts VALUES ('IB060', 'ThikPad T60', '415', '1200', '2009-03-28', '4');

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
INSERT INTO tblSupplies VALUES ('1', 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA');
INSERT INTO tblSupplies VALUES ('2', 'DELL', 'Dell Way Round Rock, Texas 78682 USA');
INSERT INTO tblSupplies VALUES ('3', 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan');
INSERT INTO tblSupplies VALUES ('4', 'IBM', 'Kevin O\'Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');

-- ----------------------------
-- View structure for `marketdb_product`
-- ----------------------------
DROP VIEW IF EXISTS `marketdb_product`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb_product` AS select `tblproducts`.`pro_name` AS `pro_name`,`tblproducts`.`pro_cost` AS `pro_cost`,`tblsupplies`.`sup_name` AS `sup_name`,`tblmarkets`.`mar_name` AS `mar_name` from ((`tblsupplies` join `tblproducts`) join `tblmarkets`) where ((`tblproducts`.`sup_id` = `tblsupplies`.`sup_id`) and (`tblproducts`.`pro_code` = `tblmarkets`.`pro_code`));

-- ----------------------------
-- View structure for `marketdb_product4`
-- ----------------------------
DROP VIEW IF EXISTS `marketdb_product4`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb_product4` AS select `tblproducts`.`pro_name` AS `pro_name`,`tblmarkets`.`mar_name` AS `mar_name`,`tblmarkets`.`mar_pro_quantity` AS `mar_pro_quantity`,`tblsupplies`.`sup_name` AS `sup_name` from ((`tblproducts` join `tblmarkets`) join `tblsupplies` on(((`tblproducts`.`pro_code` = `tblmarkets`.`pro_code`) and (`tblproducts`.`sup_id` = `tblsupplies`.`sup_id`)))) where (`tblmarkets`.`mar_pro_quantity` = (select max(`tblmarkets`.`mar_pro_quantity`) AS `MAX(tblmarkets.mar_pro_quantity)` from `tblmarkets`));

-- ----------------------------
-- View structure for `marketdb_product5`
-- ----------------------------
DROP VIEW IF EXISTS `marketdb_product5`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb_product5` AS select `tblproducts`.`pro_name` AS `pro_name`,`tblproducts`.`pro_code` AS `pro_code`,`tblproducts`.`pro_quantity` AS `pro_quantity`,`tblsupplies`.`sup_name` AS `sup_name` from (`tblproducts` join `tblsupplies` on((`tblproducts`.`sup_id` = `tblsupplies`.`sup_id`))) where (`tblproducts`.`pro_cost` = (select min(`tblproducts`.`pro_cost`) AS `MIN(tblproducts.pro_cost)` from `tblproducts`));

-- ----------------------------
-- Procedure structure for `marketdb_product`
-- ----------------------------
DROP PROCEDURE IF EXISTS `marketdb_product`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marketdb_product`(ppro_date date)
BEGIN
	SELECT pro_name,pro_code,sup_name,pro_quantity 
	FROM tbl_product
	INNER JOIN (SELECT MAX(pro_quantity) FROM tblproducts WHERE pro_date=ppro_date ORDER BY pro_code) 
	AS p
	INNER JOIN tblsupplies 
	WHERE tblproducts.sup_id=tblsupplies.sup_id AND tblproducts.pro_code=p.pro_code;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `marketdb_product_a`
-- ----------------------------
DROP PROCEDURE IF EXISTS `marketdb_product_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marketdb_product_a`()
BEGIN
CREATE VIEW marketdb_productMax_quantity AS
SELECT max(pro_quanity) as pro_max_quantily
FROM tblproducts LIMIT 1;
SELECT pro_name, pro_code, sup_name, pro_quanity
FROM tblproducts INNER JOIN tblsupplies INNER JOIN marketdb_productMax_quantity
WHERE tblproducts.sup_id = tblsupplies.sup_id AND pro_quanity = 
(SELECT pro_max_quantily FROM marketdb_productMax_quantity );
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `marketdb_product_b`
-- ----------------------------
DROP PROCEDURE IF EXISTS `marketdb_product_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marketdb_product_b`()
BEGIN
CREATE VIEW marketdb_productMax_cost as
SELECT MAX(pro_cost) AS pro_max_cost
FROM tblproducts limit 1;
SELECT pro_name, pro_code, pro_date
FROM tblproducts INNER JOIN marketdb_productMax_cost
WHERE pro_cost = (SELECT pro_max_cost FROM marketdb_productMax_cost);
END
;;
DELIMITER ;
DELIMITER ;;
CREATE TRIGGER `marketdb_productUpdate` AFTER UPDATE ON `tblproducts` FOR EACH ROW BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END
;;
DELIMITER ;
DELIMITER ;;
CREATE TRIGGER `marketdb_product` AFTER DELETE ON `tblproducts` FOR EACH ROW BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END
;;
DELIMITER ;
