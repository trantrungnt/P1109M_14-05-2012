-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 14, 2012 at 11:06 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `marketdb`
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
(1, 'Maxi', 50, 'HC631', 12),
(2, '7-Eleven', 200, 'DR017', 18),
(3, 'Migros', 1000, 'AS255', 15),
(4, 'Costco', 430, 'AS255', 12),
(5, 'Coop Norden', 950, 'IB060', 14);

-- --------------------------------------------------------

--
-- Table structure for table `tblproducts`
--

CREATE TABLE IF NOT EXISTS `tblproducts` (
  `pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `pro_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
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
('HC631', 'Compaq nx 6310', 750, 150, '2006-10-12', 1),
('HC415', 'Pavilion 4105TX', 680, 1000, '2008-08-21', 1),
('DR071', 'Inspiron 17R', 908, 520, '2009-03-15', 2),
('AS255', 'Aspire One D255', 325, 1650, '2008-11-20', 3),
('IB060', 'ThikPad T60', 415, 1200, '2009-03-28', 4);

--
-- Triggers `tblproducts`
--
DROP TRIGGER IF EXISTS `marketdb_productUpdate`;
DELIMITER //
CREATE TRIGGER `marketdb_productUpdate` AFTER UPDATE ON `tblproducts`
 FOR EACH ROW BEGIN
INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `marketdb_product`;
DELIMITER //
CREATE TRIGGER `marketdb_product` AFTER DELETE ON `tblproducts`
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
  `sup_addrress` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`sup_id`, `sup_name`, `sup_addrress`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA'),
(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan'),
(4, 'IBM', 'Kevin O''Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `view_31`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_31` AS select `p`.`pro_name` AS `Pro_name`,`p`.`pro_cost` AS `Pro_price`,`s`.`sup_name` AS `Sup_name`,`m`.`mar_name` AS `Mar_name` from ((`marketdb`.`tblproducts` `p` join `marketdb`.`tblsupplies` `s`) join `marketdb`.`tblmarkets` `m`) where ((`p`.`pro_code` = `m`.`pro_code`) and (`p`.`sup_id` = `s`.`sup_id`));

--
-- Dumping data for table `view_31`
--

INSERT INTO `view_31` (`Pro_name`, `Pro_price`, `Sup_name`, `Mar_name`) VALUES
('Compaq nx 6310', 750, 'HP', 'Maxi'),
('Aspire One D255', 325, 'ACER', 'Migros'),
('Aspire One D255', 325, 'ACER', 'Costco'),
('ThikPad T60', 415, 'IBM', 'Coop Norden');

-- --------------------------------------------------------

--
-- Table structure for table `view_32`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_32` AS select `marketdb`.`tblproducts`.`pro_code` AS `Pro_code`,`marketdb`.`tblproducts`.`pro_name` AS `Pro_name`,`marketdb`.`tblproducts`.`pro_cost` AS `Pro_price`,`marketdb`.`tblproducts`.`pro_quantity` AS `Pro_quantity` from `marketdb`.`tblproducts` where (not(`marketdb`.`tblproducts`.`pro_code` in (select `marketdb`.`tblmarkets`.`pro_code` AS `pro_code` from `marketdb`.`tblmarkets`)));

--
-- Dumping data for table `view_32`
--

INSERT INTO `view_32` (`Pro_code`, `Pro_name`, `Pro_price`, `Pro_quantity`) VALUES
('HC415', 'Pavilion 4105TX', 680, 1000),
('DR071', 'Inspiron 17R', 908, 520);

-- --------------------------------------------------------

--
-- Table structure for table `view_35`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_35` AS select `a`.`pro_name` AS `Pro_name`,`a`.`pro_code` AS `Pro_code`,`a`.`pro_quantity` AS `Pro_quantity`,`b`.`sup_name` AS `Sup_name` from (`marketdb`.`tblproducts` `a` join `marketdb`.`tblsupplies` `b` on((`a`.`sup_id` = `b`.`sup_id`))) where (`a`.`pro_cost` = (select min(`a`.`pro_cost`) AS `min(a.pro_cost)` from `marketdb`.`tblproducts` `a`));

--
-- Dumping data for table `view_35`
--

INSERT INTO `view_35` (`Pro_name`, `Pro_code`, `Pro_quantity`, `Sup_name`) VALUES
('Aspire One D255', 'AS255', 1650, 'ACER');

-- --------------------------------------------------------

--
-- Table structure for table `view_pro_max_cost`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_pro_max_cost` AS select max(`marketdb`.`tblproducts`.`pro_cost`) AS `max_cost` from `marketdb`.`tblproducts` limit 1;

--
-- Dumping data for table `view_pro_max_cost`
--

INSERT INTO `view_pro_max_cost` (`max_cost`) VALUES
(908);

-- --------------------------------------------------------

--
-- Table structure for table `view_pro_max_quantity`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view_pro_max_quantity` AS select max(`marketdb`.`tblproducts`.`pro_quantity`) AS `max_quantity` from `marketdb`.`tblproducts` limit 1;

--
-- Dumping data for table `view_pro_max_quantity`
--

INSERT INTO `view_pro_max_quantity` (`max_quantity`) VALUES
(1650);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
