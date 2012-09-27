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
  `Mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `Mar_name` varchar(250) DEFAULT NULL,
  `Mar_pro_quantity` int(11) DEFAULT NULL,
  `Pro_code` char(5) DEFAULT NULL,
  `Mar_price_plus` float DEFAULT NULL,
  PRIMARY KEY (`Mar_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblmarkets`
--

INSERT INTO `tblmarkets` (`Mar_id`, `Mar_name`, `Mar_pro_quantity`, `Pro_code`, `Mar_price_plus`) VALUES
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
  `Pro_code` char(5) NOT NULL,
  `Pro_name` varchar(250) DEFAULT NULL,
  `Pro_cost` int(11) DEFAULT NULL,
  `Pro_quantity` int(11) DEFAULT NULL,
  `Pro_date` date DEFAULT NULL,
  `Sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblproducts`
--

INSERT INTO `tblproducts` (`Pro_code`, `Pro_name`, `Pro_cost`, `Pro_quantity`, `Pro_date`, `Sup_id`) VALUES
('HC631', 'Compaq nx 6310', 750, 150, '2006-10-12', 1),
('HC415', 'Pavilion 4105TX', 680, 1000, '2008-08-21', 1),
('DR017', 'Inspiron 17R', 908, 520, '2009-03-15', 2),
('AS255', 'Aspire One D255', 325, 1650, '2008-11-20', 3),
('IB060', 'ThinkPad T60', 415, 1200, '2009-03-28', 4);

-- --------------------------------------------------------

--
-- Table structure for table `tblsupplies`
--

CREATE TABLE IF NOT EXISTS `tblsupplies` (
  `Sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `Sup_name` varchar(100) DEFAULT NULL,
  `Sup_address` varchar(350) DEFAULT NULL,
  PRIMARY KEY (`Sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`Sup_id`, `Sup_name`, `Sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houston ,Texas 77077 USA'),
(2, 'DELL', 'Dell Way Round Rock ,Texas 78682 USA'),
(3, 'ACER', '8F,No,88 ,Section 1, Hsin Tai Wu Road.,Hsichih 221 , Taipei Hsien,Taiwan'),
(4, 'IBM', 'Kenvin O''Malley House, Earlsfort Centre ,Earlsfort Terrace ,Dublin 2,Irland');

-- --------------------------------------------------------

--
-- Table structure for table `view1`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view1` AS select `marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblproducts`.`Pro_cost` AS `Pro_cost`,`marketdb`.`tblsupplies`.`Sup_name` AS `Sup_name`,`marketdb`.`tblmarkets`.`Mar_name` AS `Mar_name` from ((`marketdb`.`tblmarkets` join `marketdb`.`tblproducts` on((`marketdb`.`tblmarkets`.`Pro_code` = `marketdb`.`tblproducts`.`Pro_code`))) join `marketdb`.`tblsupplies` on((`marketdb`.`tblsupplies`.`Sup_id` = `marketdb`.`tblproducts`.`Sup_id`)));

--
-- Dumping data for table `view1`
--

INSERT INTO `view1` (`Pro_name`, `Pro_cost`, `Sup_name`, `Mar_name`) VALUES
('Compaq nx 6310', 750, 'HP', 'Maxi'),
('Inspiron 17R', 908, 'DELL', '7-Eleven'),
('Aspire One D255', 325, 'ACER', 'Migros'),
('Aspire One D255', 325, 'ACER', 'Costco'),
('ThinkPad T60', 415, 'IBM', 'Coop Norden');

-- --------------------------------------------------------

--
-- Table structure for table `view4`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view4` AS select `marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblmarkets`.`Mar_name` AS `Mar_name`,`marketdb`.`tblmarkets`.`Mar_pro_quantity` AS `Mar_pro_quantity`,`marketdb`.`tblsupplies`.`Sup_name` AS `Sup_name` from ((`marketdb`.`tblmarkets` join `marketdb`.`tblproducts` on((`marketdb`.`tblmarkets`.`Pro_code` = `marketdb`.`tblproducts`.`Pro_code`))) join `marketdb`.`tblsupplies` on((`marketdb`.`tblsupplies`.`Sup_id` = `marketdb`.`tblproducts`.`Sup_id`))) where (`marketdb`.`tblmarkets`.`Mar_pro_quantity` = (select max(`marketdb`.`tblmarkets`.`Mar_pro_quantity`) AS `MAX(tblMarkets.Mar_pro_quantity)` from `marketdb`.`tblmarkets`));

--
-- Dumping data for table `view4`
--

INSERT INTO `view4` (`Pro_name`, `Mar_name`, `Mar_pro_quantity`, `Sup_name`) VALUES
('Aspire One D255', 'Migros', 1000, 'ACER');

-- --------------------------------------------------------

--
-- Table structure for table `view5`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`view5` AS select `marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblproducts`.`Pro_code` AS `Pro_code`,`marketdb`.`tblproducts`.`Pro_quantity` AS `Pro_quantity`,`marketdb`.`tblsupplies`.`Sup_name` AS `Sup_name` from (`marketdb`.`tblproducts` join `marketdb`.`tblsupplies` on((`marketdb`.`tblproducts`.`Sup_id` = `marketdb`.`tblsupplies`.`Sup_id`))) where (`marketdb`.`tblproducts`.`Pro_cost` = (select min(`marketdb`.`tblproducts`.`Pro_cost`) AS `MIN(tblProducts.Pro_cost)` from `marketdb`.`tblproducts`));

--
-- Dumping data for table `view5`
--

INSERT INTO `view5` (`Pro_name`, `Pro_code`, `Pro_quantity`, `Sup_name`) VALUES
('Aspire One D255', 'AS255', 1650, 'ACER');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
