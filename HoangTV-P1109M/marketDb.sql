# --------------------------------------------------------
# Host:                         127.0.0.1
# Server version:               5.1.41
# Server OS:                    Win32
# HeidiSQL version:             6.0.0.3603
# Date/time:                    2012-05-14 21:33:58
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

# Dumping database structure for marketdb
CREATE DATABASE IF NOT EXISTS `marketdb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `marketdb`;


# Dumping structure for table marketdb.tblmarkets
DROP TABLE IF EXISTS `tblmarkets`;
CREATE TABLE IF NOT EXISTS `tblmarkets` (
  `mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `mar_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_pro_quantity` int(11) DEFAULT NULL,
  `pro_code` char(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_price_plus` float DEFAULT NULL,
  PRIMARY KEY (`mar_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Dumping data for table marketdb.tblmarkets: 5 rows
/*!40000 ALTER TABLE `tblmarkets` DISABLE KEYS */;
INSERT INTO `tblmarkets` (`mar_id`, `mar_name`, `mar_pro_quantity`, `pro_code`, `mar_price_plus`) VALUES
	(1, 'Maxi', 50, 'HC631', 12),
	(2, '7-Eleven', 200, 'DR017', 18),
	(3, 'Migros', 1000, 'AS255', 15),
	(4, 'Costco', 430, 'AS255', 12),
	(5, 'Coop Norden', 950, 'IB060', 14);
/*!40000 ALTER TABLE `tblmarkets` ENABLE KEYS */;


# Dumping structure for table marketdb.tblproducts
DROP TABLE IF EXISTS `tblproducts`;
CREATE TABLE IF NOT EXISTS `tblproducts` (
  `pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pro_cost` int(11) DEFAULT NULL,
  `pro_quantity` int(11) DEFAULT NULL,
  `pro_date` date DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pro_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Dumping data for table marketdb.tblproducts: 5 rows
/*!40000 ALTER TABLE `tblproducts` DISABLE KEYS */;
INSERT INTO `tblproducts` (`pro_code`, `pro_name`, `pro_cost`, `pro_quantity`, `pro_date`, `sup_id`) VALUES
	('HC631', 'Compaq nx 6310', 750, 150, '2006-10-12', 1),
	('HC415', 'Pavilion 4105TX', 680, 1000, '2008-08-21', 1),
	('DR071', 'Inspiron 17R', 908, 520, '2009-03-15', 2),
	('AS255', 'Aspire One D255', 325, 1650, '2008-11-20', 3),
	('IB060', 'ThikPad T60', 415, 1200, '2009-03-28', 4);
/*!40000 ALTER TABLE `tblproducts` ENABLE KEYS */;


# Dumping structure for table marketdb.tblsupplies
DROP TABLE IF EXISTS `tblsupplies`;
CREATE TABLE IF NOT EXISTS `tblsupplies` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `sup_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sup_addrress` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Dumping data for table marketdb.tblsupplies: 4 rows
/*!40000 ALTER TABLE `tblsupplies` DISABLE KEYS */;
INSERT INTO `tblsupplies` (`sup_id`, `sup_name`, `sup_addrress`) VALUES
	(1, 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA'),
	(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
	(3, 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan'),
	(4, 'IBM', 'Kevin O\'Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');
/*!40000 ALTER TABLE `tblsupplies` ENABLE KEYS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
