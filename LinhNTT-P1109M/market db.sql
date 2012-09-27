-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 14, 2012 at 10:49 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `market db`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `display`
--
CREATE TABLE IF NOT EXISTS `display` (
`pro_name` varchar(250)
,`pro_cost` int(11)
,`sup_name` varchar(100)
,`mar_name` varchar(200)
);
-- --------------------------------------------------------

--
-- Table structure for table `notsold`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market db`.`notsold` AS select `p`.`Pro_code` AS `pro_code`,`p`.`Pro_name` AS `pro_name`,`p`.`Pro_cost` AS `pro_cost`,`p`.`Pro_Quantity` AS `pro_quantity` from `market db`.`tblproducts` `p` where (not(`p`.`Pro_code` in (select `market db`.`tblmarkets`.`Pro_code` AS `pro_code` from `market db`.`tblmarkets` where (1 = 1))));

--
-- Dumping data for table `notsold`
--

INSERT INTO `notsold` (`pro_code`, `pro_name`, `pro_cost`, `pro_quantity`) VALUES
('HC415', 'Pavilion 4105TX', 680, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `tblmarkets`
--

CREATE TABLE IF NOT EXISTS `tblmarkets` (
  `Mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `Mar_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Mar_pro_quantity` int(11) NOT NULL,
  `Pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `Mar_price_plus` float NOT NULL,
  PRIMARY KEY (`Mar_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tblmarkets`
--

INSERT INTO `tblmarkets` (`Mar_id`, `Mar_name`, `Mar_pro_quantity`, `Pro_code`, `Mar_price_plus`) VALUES
(2, 'Maxi', 50, 'HC631', 12),
(3, '7-Eleven', 200, 'DR017', 18),
(4, 'Migros', 1000, 'AS255', 15),
(5, 'Costco', 430, 'AS255', 12),
(6, 'Coop Norden ', 950, 'IB060', 14);

-- --------------------------------------------------------

--
-- Table structure for table `tblproducts`
--

CREATE TABLE IF NOT EXISTS `tblproducts` (
  `Pro_code` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `Pro_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Pro_cost` int(11) NOT NULL,
  `Pro_Quantity` int(11) NOT NULL,
  `Pro_date` date NOT NULL,
  `Sup_id` int(11) NOT NULL,
  PRIMARY KEY (`Pro_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblproducts`
--

INSERT INTO `tblproducts` (`Pro_code`, `Pro_name`, `Pro_cost`, `Pro_Quantity`, `Pro_date`, `Sup_id`) VALUES
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
  `Sup_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Sup_address` varchar(350) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`Sup_id`, `Sup_name`, `Sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houston, Texas 770770 USA'),
(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien');

-- --------------------------------------------------------

--
-- Structure for view `display`
--
DROP TABLE IF EXISTS `display`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `display` AS select `p`.`Pro_name` AS `pro_name`,`p`.`Pro_cost` AS `pro_cost`,`s`.`Sup_name` AS `sup_name`,`m`.`Mar_name` AS `mar_name` from ((`tblproducts` `p` join `tblsupplies` `s` on((`p`.`Sup_id` = `s`.`Sup_id`))) join `tblmarkets` `m` on((`p`.`Pro_code` = `m`.`Pro_code`)));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
