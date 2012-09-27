/*
Navicat MySQL Data Transfer

Source Server         : namnguyen
Source Server Version : 50141
Source Host           : localhost:3306
Source Database       : marketdb

Target Server Type    : MYSQL
Target Server Version : 50141
File Encoding         : 65001

Date: 2012-05-14 20:05:30
*/

SET FOREIGN_KEY_CHECKS=0;
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
