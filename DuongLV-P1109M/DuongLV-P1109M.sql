-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 14, 2012 at 11:01 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `MarketDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblmarkets`
--

CREATE TABLE IF NOT EXISTS `tblmarkets` (
  `mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `mar_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_pro_quantity` int(11) DEFAULT NULL,
  `pro_code` char(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mar_price_plus` float DEFAULT NULL,
  PRIMARY KEY (`mar_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblmarkets`
--

INSERT INTO `tblmarkets` (`mar_id`, `mar_name`, `mar_pro_quantity`, `pro_code`, `mar_price_plus`) VALUES
(1, 'Maxi', 50, 'HC631', 0.12),
(2, '7-Eleven', 200, 'DR017', 0.18),
(3, 'Migros', 1000, 'AS255', 0.15),
(4, 'Costco', 430, 'AS255', 0.12),
(5, 'Coop Norden', 950, 'IB060', 0.14);

-- --------------------------------------------------------

--
-- Table structure for table `tblproducts`
--

CREATE TABLE IF NOT EXISTS `tblproducts` (
  `pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pro_cost` int(11) DEFAULT NULL,
  `pro_quantity` int(11) DEFAULT NULL,
  `pro_date` date DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pro_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblproducts`
--

INSERT INTO `tblproducts` (`pro_code`, `pro_name`, `pro_cost`, `pro_quantity`, `pro_date`, `sup_id`) VALUES
('HC631', 'Compaq nx 6310', 750, 150, '0000-00-00', 1),
('HC415', 'Pavilion 4105TX', 680, 1000, '0000-00-00', 1),
('DR017', 'Inspiron 17R', 908, 520, '0000-00-00', 2),
('AS255', 'Aspire One D255', 325, 1650, '0000-00-00', 3),
('IB060', 'ThinkPad T60', 415, 1200, '0000-00-00', 4);

--
-- Triggers `tblproducts`
--
DROP TRIGGER IF EXISTS `m_productUpdate`;
DELIMITER //
CREATE TRIGGER `m_productUpdate` AFTER UPDATE ON `tblproducts`
 FOR EACH ROW BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblsupplies`
--

CREATE TABLE IF NOT EXISTS `tblsupplies` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `sup_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sup_address` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`sup_id`, `sup_name`, `sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houseton, Texas 770770 USA'),
(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8F, No.88, Section 1, Hsin Tai Wu Road, Hsichih 221, Taipei Hsien, Taiwan'),
(4, 'IBM', 'Kevin OMalley House, Earlsfort Center, Eaelsfort Terrace, Dublin 2, Ireland'),
(5, 'HP', '1145 Compad Center Driver,Houston,Texas 770770 USA'),
(6, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(7, 'ACER', '8F,No. 88,Section 1,Hsin Tai Wu Road.,Hsichih 221,Taipei Hsien'),
(8, 'IBM', 'Kevin O''Malley House,Earlsfort Center,Earlsfort Terrace,Dublin 2,Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `view_1`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_1` AS select `p`.`pro_name` AS `pro_name`,`p`.`pro_cost` AS `pro_cost`,`s`.`sup_name` AS `sup_name`,`m`.`mar_name` AS `mar_name` from ((`marketdb`.`tblmarkets` `m` join `marketdb`.`tblproducts` `p` on((`m`.`pro_code` = `p`.`pro_code`))) join `marketdb`.`tblsupplies` `s` on((`p`.`sup_id` = `s`.`sup_id`)));

--
-- Dumping data for table `view_1`
--

INSERT INTO `view_1` (`pro_name`, `pro_cost`, `sup_name`, `mar_name`) VALUES
('Compaq nx 6310', 750, 'HP', 'Maxi'),
('Inspiron 17R', 908, 'DELL', '7-Eleven'),
('Aspire One D255', 325, 'ACER', 'Migros'),
('Aspire One D255', 325, 'ACER', 'Costco'),
('ThinkPad T60', 415, 'IBM', 'Coop Norden');

-- --------------------------------------------------------

--
-- Table structure for table `view_2`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_2` AS select `p`.`pro_code` AS `pro_code`,`p`.`pro_name` AS `pro_name`,`p`.`pro_cost` AS `pro_cost`,`p`.`pro_quantity` AS `pro_quantity` from `marketdb`.`tblproducts` `p` where (not(`p`.`pro_code` in (select `marketdb`.`tblmarkets`.`pro_code` AS `pro_code` from `marketdb`.`tblmarkets` where (1 = 1))));

--
-- Dumping data for table `view_2`
--

INSERT INTO `view_2` (`pro_code`, `pro_name`, `pro_cost`, `pro_quantity`) VALUES
('HC415', 'Pavilion 4105TX', 680, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `view_4`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_4` AS select `p`.`pro_name` AS `pro_name`,`m`.`mar_name` AS `mar_name`,`m`.`mar_pro_quantity` AS `mar_pro_quantity`,`s`.`sup_name` AS `sup_name` from ((`marketdb`.`tblmarkets` `m` join `marketdb`.`tblproducts` `p` on((`m`.`pro_code` = `p`.`pro_code`))) join `marketdb`.`tblsupplies` `s` on((`s`.`sup_id` = `p`.`sup_id`))) where (`m`.`mar_pro_quantity` = (select max(`m`.`mar_pro_quantity`) AS `MAX(m.mar_pro_quantity)` from `marketdb`.`tblmarkets` `m`));

--
-- Dumping data for table `view_4`
--

INSERT INTO `view_4` (`pro_name`, `mar_name`, `mar_pro_quantity`, `sup_name`) VALUES
('Aspire One D255', 'Migros', 1000, 'ACER');

-- --------------------------------------------------------

--
-- Table structure for table `view_5`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_5` AS select `p`.`pro_name` AS `pro_name`,`p`.`pro_code` AS `pro_code`,`p`.`pro_quantity` AS `pro_quantity`,`s`.`sup_name` AS `sup_name` from (`marketdb`.`tblproducts` `p` join `marketdb`.`tblsupplies` `s` on((`p`.`sup_id` = `s`.`sup_id`))) where (`p`.`pro_cost` = (select min(`marketdb`.`tblproducts`.`pro_cost`) AS `MIN(pro_cost)` from `marketdb`.`tblproducts`));

--
-- Dumping data for table `view_5`
--

INSERT INTO `view_5` (`pro_name`, `pro_code`, `pro_quantity`, `sup_name`) VALUES
('Aspire One D255', 'AS255', 1650, 'ACER');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
