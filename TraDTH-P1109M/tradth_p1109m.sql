-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 14, 2012 at 10:56 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `tblsupplies`
--

CREATE TABLE IF NOT EXISTS `tblsupplies` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `sup_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sup_address` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`sup_id`, `sup_name`, `sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houseton, Texas 770770 USA'),
(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8F, No.88, Section 1, Hsin Tai Wu Road, Hsichih 221, Taipei Hsien, Taiwan'),
(4, 'IBM', 'Kevin OMalley House, Earlsfort Center, Eaelsfort Terrace, Dublin 2, Ireland');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
