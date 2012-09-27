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
  `Mar_name` varchar(200) NOT NULL,
  `Mar_pro_quantity` int(11) NOT NULL,
  `Pro_code` char(5) NOT NULL,
  `Mar_price_plus` float NOT NULL,
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
  `Pro_name` varchar(250) NOT NULL,
  `Pro_cost` int(11) NOT NULL,
  `Pro_quantity` int(11) NOT NULL,
  `Pro_date` date NOT NULL,
  `Sup_id` int(11) NOT NULL,
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
  `Sup_name` varchar(100) NOT NULL,
  `Sup_address` varchar(350) NOT NULL,
  PRIMARY KEY (`Sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`Sup_id`, `Sup_name`, `Sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houston, Texas 770770 USA'),
(2, 'DELL', 'DELL Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8f, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan'),
(4, 'IBM', 'Kevin O''Malley House, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `v1`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`v1` AS select `marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblproducts`.`Pro_cost` AS `Pro_cost`,`marketdb`.`tblsupplies`.`Sup_name` AS `Sup_name`,`marketdb`.`tblmarkets`.`Mar_name` AS `Mar_name` from ((`marketdb`.`tblproducts` join `marketdb`.`tblmarkets`) join `marketdb`.`tblsupplies`) where ((`marketdb`.`tblproducts`.`Sup_id` = `marketdb`.`tblsupplies`.`Sup_id`) and (`marketdb`.`tblproducts`.`Pro_code` = `marketdb`.`tblmarkets`.`Pro_code`));

--
-- Dumping data for table `v1`
--

INSERT INTO `v1` (`Pro_name`, `Pro_cost`, `Sup_name`, `Mar_name`) VALUES
('Compaq nx 6310', 750, 'HP', 'Maxi'),
('Inspiron 17R', 908, 'DELL', '7-Eleven'),
('Aspire One D255', 325, 'ACER', 'Migros'),
('Aspire One D255', 325, 'ACER', 'Costco'),
('ThinkPad T60', 415, 'IBM', 'Coop Norden');

-- --------------------------------------------------------

--
-- Table structure for table `v2`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`v2` AS select `marketdb`.`tblproducts`.`Pro_code` AS `Pro_code`,`marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblproducts`.`Pro_cost` AS `Pro_cost`,`marketdb`.`tblproducts`.`Pro_quantity` AS `Pro_quantity` from `marketdb`.`tblproducts` where (not(`marketdb`.`tblproducts`.`Pro_code` in (select `marketdb`.`tblmarkets`.`Pro_code` AS `Pro_code` from `marketdb`.`tblmarkets`)));

--
-- Dumping data for table `v2`
--

INSERT INTO `v2` (`Pro_code`, `Pro_name`, `Pro_cost`, `Pro_quantity`) VALUES
('HC415', 'Pavilion 4105TX', 680, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `v4`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`v4` AS select `marketdb`.`tblproducts`.`Pro_name` AS `Pro_name`,`marketdb`.`tblmarkets`.`Mar_name` AS `Mar_name`,`marketdb`.`tblmarkets`.`Mar_pro_quantity` AS `Mar_pro_quantity`,`marketdb`.`tblsupplies`.`Sup_name` AS `Sup_name` from ((`marketdb`.`tblproducts` join `marketdb`.`tblmarkets`) join `marketdb`.`tblsupplies`) where (`marketdb`.`tblproducts`.`Sup_id` = (select max(`marketdb`.`tblproducts`.`Sup_id`) AS `max(Sup_id)` from `marketdb`.`tblproducts`));

--
-- Dumping data for table `v4`
--

INSERT INTO `v4` (`Pro_name`, `Mar_name`, `Mar_pro_quantity`, `Sup_name`) VALUES
('ThinkPad T60', 'Maxi', 50, 'HP'),
('ThinkPad T60', 'Maxi', 50, 'DELL'),
('ThinkPad T60', 'Maxi', 50, 'ACER'),
('ThinkPad T60', 'Maxi', 50, 'IBM'),
('ThinkPad T60', '7-Eleven', 200, 'HP'),
('ThinkPad T60', '7-Eleven', 200, 'DELL'),
('ThinkPad T60', '7-Eleven', 200, 'ACER'),
('ThinkPad T60', '7-Eleven', 200, 'IBM'),
('ThinkPad T60', 'Migros', 1000, 'HP'),
('ThinkPad T60', 'Migros', 1000, 'DELL'),
('ThinkPad T60', 'Migros', 1000, 'ACER'),
('ThinkPad T60', 'Migros', 1000, 'IBM'),
('ThinkPad T60', 'Costco', 430, 'HP'),
('ThinkPad T60', 'Costco', 430, 'DELL'),
('ThinkPad T60', 'Costco', 430, 'ACER'),
('ThinkPad T60', 'Costco', 430, 'IBM'),
('ThinkPad T60', 'Coop Norden', 950, 'HP'),
('ThinkPad T60', 'Coop Norden', 950, 'DELL'),
('ThinkPad T60', 'Coop Norden', 950, 'ACER'),
('ThinkPad T60', 'Coop Norden', 950, 'IBM');

-- --------------------------------------------------------

--
-- Table structure for table `vmax_pro_cost`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`vmax_pro_cost` AS select max(`marketdb`.`tblproducts`.`Pro_cost`) AS `max_cost` from `marketdb`.`tblproducts` limit 1;

--
-- Dumping data for table `vmax_pro_cost`
--

INSERT INTO `vmax_pro_cost` (`max_cost`) VALUES
(908);

-- --------------------------------------------------------

--
-- Table structure for table `vmax_pro_quantity`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`vmax_pro_quantity` AS select max(`marketdb`.`tblproducts`.`Pro_quantity`) AS `max_quantity` from `marketdb`.`tblproducts` limit 1;

--
-- Dumping data for table `vmax_pro_quantity`
--

INSERT INTO `vmax_pro_quantity` (`max_quantity`) VALUES
(1650);

-- --------------------------------------------------------

--
-- Table structure for table `vmost_sold`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `marketdb`.`vmost_sold` AS select count(`marketdb`.`tblmarkets`.`Mar_id`) AS `most_sold`,`marketdb`.`tblmarkets`.`Pro_code` AS `Pro_max_code` from `marketdb`.`tblmarkets` where (1 = 1) group by `marketdb`.`tblmarkets`.`Pro_code` order by count(`marketdb`.`tblmarkets`.`Mar_id`) desc limit 1;

--
-- Dumping data for table `vmost_sold`
--

INSERT INTO `vmost_sold` (`most_sold`, `Pro_max_code`) VALUES
(2, 'AS255');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
