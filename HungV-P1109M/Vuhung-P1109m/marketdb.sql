-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 14, 2012 at 02:55 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `marketdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tig_promaxcost`()
begin
drop view if exists view_pro_max_cost;
create view view_pro_max_cost as
select max(pro_cost) as max_cost
from tblproducts
limit 1;
select pro_name, pro_code, pro_date
from tblproducts, view_pro_max_cost
where pro_cost = (select max_cost from view_pro_max_cost);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tig_promaxcost_select`()
begin
drop view if exists view_pro_max_cost;
create view view_pro_max_cost as
select max(pro_cost) as max_cost
from tblproducts
limit 1;
select pro_name, pro_code, pro_date
from tblproducts, view_pro_max_cost
where pro_cost = (select max_cost from view_pro_max_cost);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tig_promostquanity_select`()
begin
drop view if exists view_pro_max_quantily ;
create view view_pro_max_quantily  as
select max(pro_quanity) as max_quantily
from tblproducts
limit 1;
select pro_name, pro_code, sup_name, pro_quanity
from tblproducts, tblsupplies, view_pro_max_quantily
where tblproducts.sup_id = tblsupplies.sup_id and pro_quanity = (select max_quantily from view_pro_max_quantily );
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `3.1`
--
CREATE TABLE IF NOT EXISTS `3.1` (
`Pro_name` varchar(250)
,`Pro_cost` int(11)
,`Sup_name` varchar(100)
,`Mar_name` varchar(200)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `3.2`
--
CREATE TABLE IF NOT EXISTS `3.2` (
`pro_name` varchar(250)
,`pro_code` char(5)
,`pro_cost` int(11)
,`pro_quantity` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `3.4`
--
CREATE TABLE IF NOT EXISTS `3.4` (
`pro_name` varchar(250)
,`mar_name` varchar(200)
,`mar_pro_quantity` int(11)
,`sup_name` varchar(100)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `3.5`
--
CREATE TABLE IF NOT EXISTS `3.5` (
`pro_name` varchar(250)
,`pro_code` char(5)
,`pro_quantity` int(11)
,`sup_name` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `tblmarkets`
--

CREATE TABLE IF NOT EXISTS `tblmarkets` (
  `Mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `Mar_name` varchar(200) NOT NULL,
  `Mar_pro_quantity` int(11) NOT NULL,
  `pro_code` char(5) NOT NULL,
  `Mar_price_plus` float NOT NULL,
  PRIMARY KEY (`Mar_id`),
  KEY `pro_code` (`pro_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblmarkets`
--

INSERT INTO `tblmarkets` (`Mar_id`, `Mar_name`, `Mar_pro_quantity`, `pro_code`, `Mar_price_plus`) VALUES
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
  PRIMARY KEY (`Pro_code`),
  KEY `Sup_id` (`Sup_id`),
  KEY `Pro_cost` (`Pro_cost`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblproducts`
--

INSERT INTO `tblproducts` (`Pro_code`, `Pro_name`, `Pro_cost`, `Pro_quantity`, `Pro_date`, `Sup_id`) VALUES
('AS255', 'Aspire One D255', 325, 1650, '2008-11-20', 3),
('DR071', 'Inspiron 17R', 908, 520, '2009-03-15', 2),
('HC415', 'Pavilion 4105TX', 680, 1000, '2008-08-21', 1),
('HC631', 'Compaq nx 6310', 750, 150, '2006-10-12', 1),
('IB060', 'ThikPad T60', 415, 1200, '2009-03-28', 4);

--
-- Triggers `tblproducts`
--
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
  `Sup_id` int(11) NOT NULL AUTO_INCREMENT,
  `Sup_name` varchar(100) NOT NULL,
  `Sup_address` varchar(350) NOT NULL,
  PRIMARY KEY (`Sup_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblsupplies`
--

INSERT INTO `tblsupplies` (`Sup_id`, `Sup_name`, `Sup_address`) VALUES
(1, 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA'),
(2, 'DELL', 'Dell Way Round Rock, Texas 78682 USA'),
(3, 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan'),
(4, 'IBM', 'Kevin O''Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');

-- --------------------------------------------------------

--
-- Structure for view `3.1`
--
DROP TABLE IF EXISTS `3.1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `3.1` AS select `tblproducts`.`Pro_name` AS `Pro_name`,`tblproducts`.`Pro_cost` AS `Pro_cost`,`tblsupplies`.`Sup_name` AS `Sup_name`,`tblmarkets`.`Mar_name` AS `Mar_name` from ((`tblproducts` join `tblmarkets` on((`tblproducts`.`Pro_code` = `tblmarkets`.`pro_code`))) join `tblsupplies` on((`tblproducts`.`Sup_id` = `tblsupplies`.`Sup_id`)));

-- --------------------------------------------------------

--
-- Structure for view `3.2`
--
DROP TABLE IF EXISTS `3.2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `3.2` AS select `tblproducts`.`Pro_name` AS `pro_name`,`tblproducts`.`Pro_code` AS `pro_code`,`tblproducts`.`Pro_cost` AS `pro_cost`,`tblproducts`.`Pro_quantity` AS `pro_quantity` from `tblproducts` where (not(`tblproducts`.`Pro_code` in (select `tblmarkets`.`pro_code` from `tblmarkets`)));

-- --------------------------------------------------------

--
-- Structure for view `3.4`
--
DROP TABLE IF EXISTS `3.4`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `3.4` AS select `tbl2`.`Pro_name` AS `pro_name`,`tbl1`.`Mar_name` AS `mar_name`,`tbl1`.`Mar_pro_quantity` AS `mar_pro_quantity`,`tbl3`.`Sup_name` AS `sup_name` from ((`tblmarkets` `tbl1` join `tblproducts` `tbl2` on((`tbl1`.`pro_code` = `tbl2`.`Pro_code`))) join `tblsupplies` `tbl3` on((`tbl3`.`Sup_id` = `tbl2`.`Sup_id`))) where (`tbl1`.`Mar_pro_quantity` = (select max(`tbl1`.`Mar_pro_quantity`) from `tblmarkets` `tbl1`));

-- --------------------------------------------------------

--
-- Structure for view `3.5`
--
DROP TABLE IF EXISTS `3.5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `3.5` AS select `tbl1`.`Pro_name` AS `pro_name`,`tbl1`.`Pro_code` AS `pro_code`,`tbl1`.`Pro_quantity` AS `pro_quantity`,`tbl2`.`Sup_name` AS `sup_name` from (`tblproducts` `tbl1` join `tblsupplies` `tbl2` on((`tbl1`.`Sup_id` = `tbl2`.`Sup_id`))) where (`tbl1`.`Pro_cost` = (select min(`tbl1`.`Pro_cost`) from `tblproducts` `tbl1`));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
