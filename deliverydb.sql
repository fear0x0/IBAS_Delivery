-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 19, 2024 at 08:50 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deliverydb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndAddAdmin` (IN `log` VARCHAR(100))   INSERT INTO admins (login) VALUES (log)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndAddOrder` (IN `log` VARCHAR(100))   INSERT INTO orders (login, date_get) 
VALUES (log, CURRENT_DATE)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndAddProduct` (IN `mename` VARCHAR(80), IN `prc` FLOAT)   INSERT INTO products (menu_name, price)
VALUES (mename, prc)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndAdmins` ()   SELECT login FROM admins$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndApartment` (IN `log` VARCHAR(255))   BEGIN
SELECT apartment FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndAuth` (IN `log` VARCHAR(255), IN `pass` VARCHAR(255))   SELECT * FROM customersaccounts 
WHERE login = log AND passwd like pass$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndChangeData` (IN `nam` VARCHAR(255), IN `surnam` VARCHAR(255), IN `phon` VARCHAR(255), IN `distric` VARCHAR(255), IN `stree` VARCHAR(255), IN `hous` VARCHAR(255), IN `apart` VARCHAR(255), IN `log` VARCHAR(255))   UPDATE customers
SET first_name = nam,
last_name = surnam,
phone_number = phon,
district = distric,
street = stree,
house = hous,
apartment = apart
WHERE login = log$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndCheck` (IN `log` VARCHAR(100))   SELECT * FROM `customersaccounts` WHERE `login` = log$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndCustomersOrders` ()   select * from customers_orders$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndDeleteAdmin` (IN `log` VARCHAR(100))   DELETE FROM admins
WHERE login = log$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndDelProduct` (IN `mename` VARCHAR(80))   DELETE FROM products WHERE menu_name = mename$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndDistrict` (IN `log` VARCHAR(255))   BEGIN
SELECT district FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndGetProducts` ()   SELECT menu_name FROM products$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndHouse` (IN `log` VARCHAR(255))   BEGIN
SELECT house FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndLastOrder` (IN `log` VARCHAR(255))   SELECT m.menu_name, m.amount                    
FROM customers_orders m                 
    LEFT JOIN customers_orders b        
        ON m.login = b.login  
        AND m.order_id < b.order_id  
        WHERE b.order_id IS NULL AND m.login = log$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndName` (IN `log` VARCHAR(255))   BEGIN
SELECT first_name FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndOrderId` ()   SELECT * FROM `lastorder_id`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndOrderProducts` (IN `orid` INT, IN `prodid` INT, IN `amnt` INT)   INSERT INTO orders_products (order_id, product_id, amount) VALUES (orid, prodid, amnt)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndPhone` (IN `log` VARCHAR(255))   BEGIN
SELECT phone_number FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndRegister` (IN `log` VARCHAR(255), IN `pass` VARCHAR(255))   INSERT INTO `customers`(`login`, `passwd`) VALUES (log, pass)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndStreet` (IN `log` VARCHAR(255))   BEGIN
SELECT street FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndSur` (IN `log` VARCHAR(255))   BEGIN
SELECT last_name FROM aboutcustomers WHERE login = log;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndUsers` ()   SELECT * 
FROM customersaccounts 
WHERE NOT EXISTS 
	(SELECT login
     FROM admins
     WHERE login = customersaccounts.login)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cmndUsersInfo` ()   SELECT * FROM aboutcustomers$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `aboutcustomers`
-- (See below for the actual view)
--
CREATE TABLE `aboutcustomers` (
`login` varchar(100)
,`first_name` varchar(255)
,`last_name` varchar(255)
,`phone_number` varchar(255)
,`district` varchar(255)
,`street` varchar(255)
,`house` varchar(11)
,`apartment` varchar(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id_admin` int(11) NOT NULL,
  `login` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id_admin`, `login`) VALUES
(1, 'admin'),
(6, 'user123'),
(8, 'apol');

-- --------------------------------------------------------

--
-- Table structure for table `courier_info`
--

CREATE TABLE `courier_info` (
  `courier_id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `hours_per_shift` smallint(6) DEFAULT '8',
  `rate` int(11) DEFAULT '250'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `courier_info`
--

INSERT INTO `courier_info` (`courier_id`, `first_name`, `last_name`, `phone_number`, `hours_per_shift`, `rate`) VALUES
(1, 'Олег', 'Раздватрин', '+ 7 922 655 0954', 8, 250),
(2, 'Антон', 'Кочерыгин', '+ 7 952 743 0146', 8, 250),
(3, 'Даниил', 'Пустяков', '+ 7 908 107 7798', 8, 250),
(4, 'Михаил', 'Седатин', '+ 7 922 566 5516', 8, 250);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `login` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `passwd` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `house` varchar(11) DEFAULT NULL,
  `apartment` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `login`, `passwd`, `phone_number`, `district`, `street`, `house`, `apartment`) VALUES
(4, NULL, NULL, 'admin', 'admin', NULL, NULL, NULL, NULL, NULL),
(1, 'Андрейка', '', 'apol', 'apol', '+7 952 677 2252', '', '5 0 лет октября', '29', ''),
(NULL, NULL, NULL, 'ares', 'ares', NULL, NULL, NULL, NULL, NULL),
(NULL, 'bobo', '', 'bogdan', '1234', '+2 311 231 2312', '', '50 лет деду', '212', ''),
(7, 'Ильнур', 'Калимулли', 'ilnur', 'ilnur', '+7 952 677 2252', 'Восточный', 'Широтная', '11', '111'),
(NULL, 'Екат', '', 'kat', '1234', '+7 123 123 1234', '', 'Перекопская', '15', ''),
(2, 'Михаил', 'Пискун', 'mihpis', 'mihpis', '+7 777 568 8452', 'Заречный', 'Тихий пр-д', '2', '35'),
(3, 'Степан', 'Никитин', 'stepnik', 'stepnik', '+7 123 782 5648', 'КПД', 'Тульская', '77', '14'),
(NULL, NULL, NULL, 'test', 'test', NULL, NULL, NULL, NULL, NULL),
(NULL, 'Андрей', '', 'test1', 'test1', '+7 123 456 7890', '', 'Перекопская', '12', ''),
(NULL, 'test', '', 'user123', '1234', '+0 000 000 0000', '', 'qwerty', '81', '');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `insertCustomers` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
INSERT INTO logs (login, operation, create_at)
VALUES(
    NEW.login,
	
        "Зарегистрирован пользователь ",
	CURRENT_DATE);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateCustomerInfo` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
INSERT INTO logs (login, operation, create_at)
VALUES(
    NEW.login,
    "Обновлена личная информация",
	CURRENT_DATE);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `customersaccounts`
-- (See below for the actual view)
--
CREATE TABLE `customersaccounts` (
`login` varchar(100)
,`passwd` varchar(32)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `customers_orders`
-- (See below for the actual view)
--
CREATE TABLE `customers_orders` (
`order_id` int(11)
,`login` varchar(100)
,`menu_name` varchar(80)
,`amount` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_info`
--

CREATE TABLE `delivery_info` (
  `id_type` int(11) NOT NULL,
  `delivery_type` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_info`
--

INSERT INTO `delivery_info` (`id_type`, `delivery_type`) VALUES
(1, 'Авто'),
(2, 'Вело'),
(3, 'Пеший');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_list`
--

CREATE TABLE `delivery_list` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `courier_id` int(11) UNSIGNED NOT NULL,
  `date_arrived` date DEFAULT NULL,
  `taken` varchar(5) DEFAULT NULL,
  `id_type` int(11) DEFAULT NULL,
  `id_payment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_list`
--

INSERT INTO `delivery_list` (`delivery_id`, `order_id`, `courier_id`, `date_arrived`, `taken`, `id_type`, `id_payment`) VALUES
(1, 1, 1, '2023-03-09', 'Да', 1, 1),
(2, 2, 1, '2023-03-09', 'Да', 2, 1),
(3, 3, 3, '2023-03-09', 'Да', 3, 2),
(4, 4, 2, '2023-03-10', 'Нет', 1, NULL),
(5, 5, 4, '2023-03-10', 'Да', 3, 2),
(6, 6, 4, '2023-03-10', 'Нет', 3, NULL),
(7, 7, 3, '2023-03-10', 'Да', 1, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lastorder_id`
-- (See below for the actual view)
--
CREATE TABLE `lastorder_id` (
`order_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `operation` varchar(255) NOT NULL DEFAULT 'GETDATE()',
  `create_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `login`, `operation`, `create_at`) VALUES
(2, 'apol', '{\"Добавлен заказ№\": 39}', '2023-05-24'),
(3, 'apol', 'Обновлена личная информация', '2023-05-24'),
(4, 'user123', 'Обновлена личная информация', '2023-05-25'),
(5, 'user123', '{\"Добавлен заказ№\": 40}', '2023-05-25'),
(6, 'user123', '{\"Добавлен заказ№\": 41}', '2023-05-25'),
(7, 'apol', '{\"Добавлен заказ№\": 42}', '2023-05-25'),
(8, 'kat', 'Обновлена личная информация', '2023-05-25'),
(9, 'kat', '{\"Добавлен заказ№\": 43}', '2023-05-25'),
(10, 'kat', '{\"Добавлен заказ№\": 44}', '2023-05-25'),
(11, 'kat', '{\"Добавлен заказ№\": 45}', '2023-05-25'),
(12, 'kat', '{\"Добавлен заказ№\": 46}', '2023-05-25'),
(13, 'bogdan', 'Обновлена личная информация', '2023-05-25'),
(14, 'bogdan', '{\"Добавлен заказ№\": 47}', '2023-05-25'),
(15, 'bogdan', '{\"Добавлен заказ№\": 48}', '2023-05-25'),
(16, 'bogdan', '{\"Добавлен заказ№\": 49}', '2023-05-25'),
(17, 'bogdan', '{\"Добавлен заказ№\": 50}', '2023-05-25'),
(18, 'bogdan', '{\"Добавлен заказ№\": 51}', '2023-05-25'),
(20, 'test', 'Зарегистрирован пользователь ', '2023-05-25'),
(21, 'test1', 'Зарегистрирован пользователь ', '2023-05-27'),
(22, 'test1', 'Обновлена личная информация', '2023-05-27'),
(23, 'test1', '{\"Добавлен заказ№\": 52}', '2023-05-27'),
(24, 'apol', '{\"Добавлен заказ№\": 53}', '2023-05-27'),
(25, 'apol', '{\"Добавлен заказ№\": 54}', '2023-05-27'),
(26, 'apol', '{\"Добавлен заказ№\": 55}', '2023-05-27'),
(27, 'apol', '{\"Добавлен заказ№\": 56}', '2023-05-27'),
(28, 'apol', '{\"Добавлен заказ№\": 57}', '2023-05-27');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `login` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `date_get` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `login`, `date_get`) VALUES
(1, 'apol', '2023-03-09'),
(2, 'mihpis', '2023-03-09'),
(3, 'stepnik', '2023-03-09'),
(4, 'apol', '2023-03-09'),
(5, 'mihpis', '2023-03-09'),
(6, 'stepnik', '2023-03-09'),
(7, 'apol', '2023-03-10'),
(32, 'apol', '2023-05-24'),
(35, 'mihpis', '2023-05-24'),
(39, 'apol', '2023-05-24'),
(40, 'user123', '2023-05-25'),
(41, 'user123', '2023-05-25'),
(42, 'apol', '2023-05-25'),
(43, 'kat', '2023-05-25'),
(46, 'kat', '2023-05-25'),
(47, 'bogdan', '2023-05-25'),
(48, 'bogdan', '2023-05-25'),
(49, 'bogdan', '2023-05-25'),
(50, 'bogdan', '2023-05-25'),
(51, 'bogdan', '2023-05-25'),
(52, 'test1', '2023-05-27'),
(53, 'apol', '2023-05-27'),
(54, 'apol', '2023-05-27'),
(55, 'apol', '2023-05-27'),
(56, 'apol', '2023-05-27'),
(57, 'apol', '2023-05-27');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `insertOrders` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
INSERT INTO logs (login, operation, create_at)
VALUES(
    NEW.login,
	JSON_OBJECT(
        "Добавлен заказ№",NEW.order_id),
	CURRENT_DATE);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_products`
--

CREATE TABLE `orders_products` (
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders_products`
--

INSERT INTO `orders_products` (`order_id`, `product_id`, `amount`) VALUES
(2, 1, 2),
(2, 2, 1),
(3, 5, 2),
(3, 10, 1),
(4, 4, 2),
(5, 5, 1),
(6, 7, 2),
(6, 8, 1),
(7, 1, 1),
(7, 4, 2),
(7, 1, 1),
(30, 3, 1),
(30, 4, 1),
(32, 1, 12),
(32, 3, 13),
(32, 5, 15),
(35, 7, 2),
(39, 3, 3),
(39, 4, 4),
(41, 1, 1),
(41, 3, 2),
(41, 6, 5),
(42, 1, 3),
(42, 4, 5),
(43, 1, 1),
(43, 4, 2),
(44, 2, 4),
(44, 7, 1),
(45, 2, 1),
(45, 7, 1),
(46, 1, 1),
(47, 1, 1),
(47, 3, 1),
(47, 4, 1),
(48, 6, 1),
(49, 7, 2),
(49, 9, 4),
(50, 3, 2),
(50, 6, 1),
(51, 3, 3),
(52, 1, 2),
(52, 3, 1),
(54, 1, 2),
(55, 2, 2),
(56, 4, 2),
(56, 7, 2),
(57, 6, 2);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id_payment` int(11) NOT NULL,
  `payment_method` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id_payment`, `payment_method`) VALUES
(1, 'Наличные'),
(2, 'Карта');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `menu_name` varchar(80) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `menu_name`, `price`) VALUES
(1, 'Сёмга', 229.5),
(2, 'Муравейник', 269.99),
(3, 'Молоко', 59.01),
(4, 'Творог', 165),
(5, 'Сметана', 59),
(6, 'Сливочное масло', 109),
(7, 'Сок', 65),
(8, 'Творожный сыр', 105),
(9, 'Пирог', 175),
(10, 'Икра красная', 165);

-- --------------------------------------------------------

--
-- Table structure for table `year_statistics`
--

CREATE TABLE `year_statistics` (
  `id_month` int(11) NOT NULL,
  `month_name` varchar(10) NOT NULL,
  `amount_of_orders` int(11) NOT NULL,
  `couriers_shifts_per_month` int(11) NOT NULL,
  `average_check` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view `aboutcustomers`
--
DROP TABLE IF EXISTS `aboutcustomers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aboutcustomers`  AS SELECT `customers`.`login` AS `login`, `customers`.`first_name` AS `first_name`, `customers`.`last_name` AS `last_name`, `customers`.`phone_number` AS `phone_number`, `customers`.`district` AS `district`, `customers`.`street` AS `street`, `customers`.`house` AS `house`, `customers`.`apartment` AS `apartment` FROM `customers``customers`  ;

-- --------------------------------------------------------

--
-- Structure for view `customersaccounts`
--
DROP TABLE IF EXISTS `customersaccounts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customersaccounts`  AS SELECT `customers`.`login` AS `login`, `customers`.`passwd` AS `passwd` FROM `customers``customers`  ;

-- --------------------------------------------------------

--
-- Structure for view `customers_orders`
--
DROP TABLE IF EXISTS `customers_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customers_orders`  AS SELECT `orders`.`order_id` AS `order_id`, `customers`.`login` AS `login`, `products`.`menu_name` AS `menu_name`, `orders_products`.`amount` AS `amount` FROM (((`customers` join `orders` on((`customers`.`login` = `orders`.`login`))) join `orders_products` on((`orders`.`order_id` = `orders_products`.`order_id`))) join `products` on((`orders_products`.`product_id` = `products`.`product_id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `lastorder_id`
--
DROP TABLE IF EXISTS `lastorder_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lastorder_id`  AS SELECT `orders`.`order_id` AS `order_id` FROM `orders` ORDER BY `orders`.`order_id` DESC LIMIT 0, 11  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `courier_info`
--
ALTER TABLE `courier_info`
  ADD PRIMARY KEY (`courier_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`login`) USING BTREE;

--
-- Indexes for table `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD PRIMARY KEY (`id_type`);

--
-- Indexes for table `delivery_list`
--
ALTER TABLE `delivery_list`
  ADD PRIMARY KEY (`delivery_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `fk_id_type` (`id_type`),
  ADD KEY `fk_id_payment` (`id_payment`),
  ADD KEY `fk_courier_id` (`courier_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `login` (`login`);

--
-- Indexes for table `orders_products`
--
ALTER TABLE `orders_products`
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id_payment`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `year_statistics`
--
ALTER TABLE `year_statistics`
  ADD PRIMARY KEY (`id_month`),
  ADD UNIQUE KEY `month_name` (`month_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `courier_info`
--
ALTER TABLE `courier_info`
  MODIFY `courier_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `year_statistics`
--
ALTER TABLE `year_statistics`
  MODIFY `id_month` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery_list`
--
ALTER TABLE `delivery_list`
  ADD CONSTRAINT `delivery_list_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_courier_id` FOREIGN KEY (`courier_id`) REFERENCES `courier_info` (`courier_id`),
  ADD CONSTRAINT `fk_id_payment` FOREIGN KEY (`id_payment`) REFERENCES `payments` (`id_payment`),
  ADD CONSTRAINT `fk_id_type` FOREIGN KEY (`id_type`) REFERENCES `delivery_info` (`id_type`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_login` FOREIGN KEY (`login`) REFERENCES `customers` (`login`);

--
-- Constraints for table `orders_products`
--
ALTER TABLE `orders_products`
  ADD CONSTRAINT `orders_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
