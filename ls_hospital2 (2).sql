-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2023 at 07:06 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ls_hospital2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_customer` (IN `Customer_Id` INT, IN `first_name` VARCHAR(100), `last_name` VARCHAR(100), IN `phone` INT, IN `birthdate` DATE, IN `gender` VARCHAR(100), IN `city` VARCHAR(100), IN `email` VARCHAR(100), IN `building_name` VARCHAR(100), IN `building_number` INT, IN `street_name` VARCHAR(100))   INSERT INTO customer (Customer_Id,first_name,last_name,phone,birthdate,gender,city,email,building_name,building_number,street_name)
VALUES (Customer_Id=Customer_Id,first_name=first_name,last_name=last_name,phone=phone,birthdate=birthdate,gender=gender,
city=city,email=email,building_name=building_name,building_number=building_number,street_name=street_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_insert` (IN `employee_Id` INT, IN `first_name` VARCHAR(90), IN `last_name` VARCHAR(90), IN `birthdate` DATE, IN `email` VARCHAR(80), IN `phone` INT, IN `warehouse_number` INT)   INSERT INTO employee (employee_Id,first_name,last_name,birthdate,email,phone,warehouse_number)
VALUES (employee_Id,first_name,last_name,birthdate,email,phone,warehouse_number)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_insert_product` (IN `product_id` INT, IN `name` VARCHAR(80), IN `usage_` VARCHAR(90), IN `price` INT, IN `expiration_date` DATE, IN `form` VARCHAR(80), IN `production_date` DATE, IN `weight` INT, IN `stock` INT)   INSERT INTO product(product_id,name,usage_,price,expiration_date,form,production_date,weight,stock)
VALUES(product_id,name,usage_,price,expiration_date,form,production_date,weight,stock)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_product` (IN `employee_ID` INT)   SELECT product.name,product.price,product.usage_,product.expiration_date,product.production_date,product.stock,product.weight,product.form FROM product INNER JOIN warehouse INNER JOIN warehouse_product INNER JOIN employee 
ON warehouse.Warehouse_Number=employee.Warehouse_number and warehouse.Warehouse_Number=warehouse_product.warehouse_number and product.product_Id=warehouse_product.product_id
WHERE employee.employee_Id=employee_ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_update` (IN `employee_Id` INT, IN `first_name` VARCHAR(90), IN `last_name` VARCHAR(90), IN `birthdate` DATE, IN `email` VARCHAR(80), IN `phone` INT, IN `warehouse_number` INT)   UPDATE employee SET first_name=first_name,last_name=last_name,birthdate=birthdate,email=email,phone=phone
WHERE employee.employee_Id=employee_Id AND Warehouse_number=Warehouse_number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_transaction_customer` (IN `TRANSACTION_Id` INT, IN `channel` VARCHAR(100), IN `amount` INT, IN `customer_id` INT)   INSERT INTO transaction (TRANSACTION_Id,channel,amount,customer_id)
VALUES(TRANSACTION_Id,channel,amount,customer_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_delete` (IN `id` INT, IN `number` INT)   DELETE FROM employee WHERE employee.employee_Id=id AND employee.Warehouse_number=number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_insert` (IN `employee_Id` INT, IN `email` VARCHAR(100), IN `phone` INT, IN `salary` INT, IN `first_name` VARCHAR(100), IN `birthdate` DATE, IN `last_name` VARCHAR(100), IN `degree` VARCHAR(100), IN `level` VARCHAR(100), IN `Warehouse_number` INT)   INSERT into employee (employee_Id,email,phone,salary,first_name,birthdate,last_name,degree,level,Warehouse_number)
VALUES (employee_Id,email,phone,salary,first_name,birthdate,last_name,degree,level,Warehouse_number)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_select` (IN `warehouse_number` INT)   select employee.employee_Id,email,salary,degree,level,birthdate,first_name,last_name,phone FROM employee INNER join warehouse
ON warehouse.Warehouse_Number=employee.Warehouse_number
WHERE  warehouse.Warehouse_Number=warehouse_number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_transaction` (IN `warehouse_number` INT)   SELECT warehouse.name , COUNT(*) FROM warehouse INNER JOIN warehouse_product INNER JOIN product INNER JOIN transaction_product INNER JOIN transaction
ON warehouse.Warehouse_Number=warehouse_product.warehouse_number and product.product_Id=warehouse_product.product_id and product.product_Id=transaction_product.product_id and transaction.TRANSACTION_Id=transaction_product.transaction_id
WHERE warehouse.Warehouse_Number=warehouse_number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_update` (IN `employee_Id` INT, IN `salary` INT, IN `degree` VARCHAR(100), IN `level` VARCHAR(100), IN `Warehouse_number` INT)   UPDATE employee SET salary=salary,degree=degree,level=level
WHERE employee.employee_Id=employee_Id and Warehouse_number=Warehouse_number$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `num_transaction_product` (IN `product_Id` INT)   SELECT product.name,  COUNT(*) FROM product INNER JOIN 
transaction INNER JOIN transaction_product
ON product.product_Id=transaction_product.product_id and 
transaction.TRANSACTION_Id=transaction_product.transaction_id
WHERE product.product_Id=product_Id
GROUP BY product.name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `num_warehouse_product` (IN `id` INT)   SELECT product.name,  COUNT(*) FROM product INNER JOIN 
warehouse INNER JOIN warehouse_product
ON product.product_Id=warehouse_product.product_id and 
warehouse.Warehouse_Number=warehouse_product.warehouse_number
WHERE product.product_Id=id
GROUP BY product.name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `product_transaction` (IN `product_id` INT)   SELECT product.name,TRANSACTION.TRANSACTION_Id, transaction.amount FROM product INNER JOIN transaction INNER JOIN transaction_product
ON product.product_Id=transaction_product.product_id and transaction.TRANSACTION_Id=transaction_product.transaction_id
WHERE product.product_Id=product_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_customer` (IN `Customer_Id` INT, IN `phone` INT, IN `email` VARCHAR(100))   UPDATE customer SET phone=phone, email=email WHERE customer.Customer_Id=Customer_Id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `warehouse_stock_product` (IN `id` INT, IN `number` INT)   SELECT product.name, warehouse.Warehouse_Number, product.stock FROM product INNER JOIN 
warehouse INNER JOIN warehouse_product
ON product.product_Id=warehouse_product.product_id and 
warehouse.Warehouse_Number=warehouse_product.warehouse_number
WHERE product.product_Id=id AND warehouse.Warehouse_Number=number$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_Number` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` int(11) NOT NULL,
  `street_name` varchar(100) NOT NULL,
  `city` varchar(30) NOT NULL,
  `building_name` varchar(30) NOT NULL,
  `building_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_Number`, `name`, `phone`, `street_name`, `city`, `building_name`, `building_number`) VALUES
(1, 'Ls_qatar', 784538881, 'ali_street', 'Alkhor', 'ali_building', 11),
(2, 'Ls_jordan', 785566413, 'lama_street', 'irbid', 'lama_building', 22),
(3, 'Ls_kuwait', 774550881, 'rania_street', 'Almanqaf', 'rania_building', 33),
(4, 'Ls_USA', 794552267, 'manar_street', 'Washington', 'manar_building', 44);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ceo_employee`
-- (See below for the actual view)
--
CREATE TABLE `ceo_employee` (
`employee_Id` int(11)
,`email` varchar(100)
,`phone` int(11)
,`salary` int(11)
,`first_name` varchar(300)
,`last_name` varchar(300)
,`birthdate` date
,`degree` varchar(100)
,`level` varchar(100)
,`Warehouse_number` int(11)
,`building_name` varchar(30)
,`building_number` int(11)
,`city` varchar(30)
,`street_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ceo_warehouse`
-- (See below for the actual view)
--
CREATE TABLE `ceo_warehouse` (
`Warehouse_Number` int(11)
,`name` varchar(100)
,`storage_condition` varchar(100)
,`branch_number` int(11)
,`phone` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_Id` int(11) NOT NULL,
  `first_name` varchar(300) NOT NULL,
  `last_name` varchar(300) NOT NULL,
  `phone` int(11) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` varchar(20) NOT NULL DEFAULT 'male',
  `city` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `building_name` varchar(30) NOT NULL,
  `building_number` int(11) NOT NULL,
  `street_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Customer_Id`, `first_name`, `last_name`, `phone`, `birthdate`, `gender`, `city`, `email`, `building_name`, `building_number`, `street_name`) VALUES
(1, 'John', 'Doe', 77777777, '1985-06-01', 'Male', 'New York', 'layanaqell@yaho.com', 'Empire State', 350, '5th Avenue'),
(2, 'Jane', 'Smith', 785050667, '1992-12-05', 'male', 'London', 'jane.smith@example.co.uk', 'The Shard', 32, 'London Bridge'),
(3, 'Michael', 'Brown', 773456740, '1978-03-15', 'Male', 'Los Angeles', 'michael.brown@example.com', 'US Bank Tower', 633, 'West 5th St'),
(4, 'Sarah', 'Lee', 785551210, '1990-09-30', 'Female	', 'Chicago', 'sarah.lee@example.com', 'Willis Tower', 233, 'South Wacker Dr'),
(5, 'Mohammad', 'Khan', 2147483647, '1983-07-12', 'Male', 'Lahore', 'mohammad.khan@example.com', 'Pace Tower', 25, 'MM Alam Road'),
(6, 'Maria', 'Hernandez', 785555550, '1989-02-14', 'Female', 'Miami', 'maria.hernandez@example.com', 'Espirito Santo', 1395, 'Brickell Ave'),
(7, 'David', 'Kim', 755555500, '1980-11-20', 'Male', 'San Francisco', 'david.kim@example.com', 'Salesforce Tower', 415, 'Mission St'),
(8, 'Emily', 'Chen', 775599955, '1995-08-08', 'Female', 'Boston', 'emily.chen@example.com', 'Prudential Tower', 800, 'Boylston St'),
(9, '	Juan', 'Garcia', 755675555, '1987-04-18', 'Male', 'Mexico City', 'juan.garcia@example.com', 'Torre Mayor', 505, 'Paseo de la Reforma'),
(10, 'Sophie', 'Dupont', 723756788, '1982-01-25', 'Female', '	Paris', 'sophie.dupont@example.fr', 'Tour Eiffel', 5, 'Avenue Anatole France'),
(11, 'Jane', 'Smith', 66666, '0000-00-00', 'male', 'London', 'jane.smith@example', 'The Shard', 32, 'London Bridge'),
(30, 'layan', 'said aqel', 785022310, '1990-07-13', 'female', 'amman', 'llaayannnsaid@yahoo.com', 'ali', 2, 'ali_street'),
(45, 'layan', 'said', 789965000, '1990-08-03', 'female', 'amman', 'layannnsaid@yahoo.com', 'ali', 2, 'ali_street');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_select`
-- (See below for the actual view)
--
CREATE TABLE `customer_select` (
`name` varchar(100)
,`usage_` varchar(300)
,`price` float(4,4)
,`production_date` date
,`expiration_date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_Id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(11) NOT NULL,
  `salary` int(11) NOT NULL,
  `first_name` varchar(300) NOT NULL,
  `birthdate` date NOT NULL,
  `last_name` varchar(300) NOT NULL,
  `degree` varchar(100) NOT NULL,
  `level` varchar(100) NOT NULL,
  `Warehouse_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_Id`, `email`, `phone`, `salary`, `first_name`, `birthdate`, `last_name`, `degree`, `level`, `Warehouse_number`) VALUES
(2, 'farahlayan@yahoo.com', 765445678, 2450, 'layan', '2003-09-01', 'ali', 'master', 'b', 1),
(3, 'ayaaa', 1233454, 2222, 'layan', '0000-00-00', 'ali', 'masterrr', 'bbbb', 1),
(4, 'tom.jones@example.com	', 78111222, 2450, 'Tom	', '1985-05-20', 'Jones', 'master', 'b', 3),
(5, 'emma.wilson@example.com', 7944455, 2450, 'Emma', '1995-12-31', 'Wilson', 'master', 'b', 1),
(6, 'john.smith@example.com', 77123456, 2450, 'John', '1980-08-01', 'Smith', 'master', 'b', 1),
(7, 'jason.ng@example.com', 799966, 2450, 'Jason', '1992-04-18', 'Ng	', 'master', 'b', 4),
(8, 'lana@yahoo.com', 12332156, 4000, 'lana', '2008-09-13', 'saeed', 'doctor', 'd', 1),
(9, 'jane.doe@example.com', 77876543, 2450, 'Jane', '1990-03-15', 'Doe	', 'master', 'b', 2),
(10, '	alex.hernandez@example.com', 7855555, 2450, 'Alex', '1988-07-12', 'Hernandez', 'master', 'b', 4),
(11, '	chris.nguyen@example.com', 75555511, 2450, 'Chris', '1995-01-23', 'Nguyen', 'master', 'b', 2),
(12, 'lisa.patel@example.com', 7966677, 2450, 'Lisa	', '1987-11-30', 'Patel', 'master', 'b', 3),
(13, 'david.lee@example.com', 785551, 2450, 'David', '1983-09-01', 'Lee	', 'master', 'b', 2),
(14, 'sarah.garcia@example.com', 7556555, 2450, 'Sarah', '2000-02-14', 'Garcia', 'master', 'b', 1),
(23, 'layannsaeed@yahoo.com', 2147483647, 0, 'layan', '2023-06-23', 'aqel', '', '', 3),
(945859, 'johnlayan.smith@example.com', 77188856, 50000, 'John', '1980-01-01', 'Smith', 'Bachelors', 'C', 1),
(945861, 'johnfarah.smith@example.com', 788222856, 50000, 'John', '1980-01-01', 'Smith', 'Bachelors', 'C', 1),
(945862, 'lanaalilana@yahoo.com', 12332234, 0, 'ali', '2023-06-28', 'lana', '', '', 4),
(945864, 'layannsaeeddddd@yahoo.com', 278501777, 0, 'lll', '2003-05-06', 'lamana', '', '', 3);

-- --------------------------------------------------------

--
-- Table structure for table `employee_address`
--

CREATE TABLE `employee_address` (
  `employee_id` int(11) NOT NULL,
  `street_name` varchar(100) NOT NULL,
  `city` varchar(30) NOT NULL,
  `building_number` int(11) NOT NULL,
  `building_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee_address`
--

INSERT INTO `employee_address` (`employee_id`, `street_name`, `city`, `building_number`, `building_name`) VALUES
(2, 'Cedar Street', 'Los Angeles', 25, 'Building D'),
(2, 'Pine Street', '	Chicago', 20, 'Building C'),
(3, 'Walnut Street', 'Miami', 35, 'Building F'),
(4, 'Birch Street', 'Seattle', 40, 'Building G'),
(4, 'Cherry Street', 'Austin', 45, 'Building H'),
(5, 'Magnolia Street', 'Portland', 50, 'Building I'),
(6, 'Jasmine Street', 'Phoenix', 65, 'Building L'),
(7, 'Tulip Street', 'Nashville', 70, 'Building M'),
(8, '	Daffodil Street', 'Detroit', 80, 'Building O'),
(8, 'Sunflower Street', 'Memphis', 75, 'Building N'),
(9, 'Lily Street', 'Indianapolis', 90, 'Building Q'),
(9, 'Peony Street', 'Charlotte', 85, 'Building P'),
(10, 'Gardenia Street', 'San Diego', 100, 'Building S'),
(10, 'Orchid Street', 'Philadelphia', 105, 'Building T'),
(23, 'Elm Street', 'New York', 10, 'Building A'),
(23, 'Oak Street', 'San Francisco	', 15, 'Building B');

-- --------------------------------------------------------

--
-- Stand-in structure for view `employee_select`
-- (See below for the actual view)
--
CREATE TABLE `employee_select` (
`employee_Id` int(11)
,`email` varchar(100)
,`phone` int(11)
,`salary` int(11)
,`first_name` varchar(300)
,`birthdate` date
,`last_name` varchar(300)
,`degree` varchar(100)
,`level` varchar(100)
,`Warehouse_number` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_Id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `usage_` varchar(300) NOT NULL,
  `price` float(4,4) NOT NULL,
  `expiration_date` date NOT NULL,
  `form` varchar(40) NOT NULL,
  `production_date` date NOT NULL,
  `weight` float(2,2) DEFAULT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_Id`, `name`, `usage_`, `price`, `expiration_date`, `form`, `production_date`, `weight`, `stock`) VALUES
(1, 'Aspirin', 'Pain relief', 0.9999, '2024-12-31', 'Tablet', '2022-01-01', 0.02, 500),
(2, 'Ibuprofen', 'Pain relief and fever reduction', 0.9999, '2025-06-30', 'Capsule', '2022-05-01', 0.03, 250),
(3, 'Acetaminophen', 'Pain relief and fever reduction', 0.9999, '2023-12-31', 'Liquid', '2021-07-01', 0.05, 750),
(4, 'Amoxicillin', 'Antibiotic for bacterial infections', 0.9999, '2024-09-30', 'Capsule', '2022-03-15', 0.04, 300),
(5, 'Omeprazole', 'Antacid and heartburn relief', 0.9999, '2025-03-31', 'Tablet', '2022-09-01', 0.02, 200),
(6, 'Hydrochlorothiazide', '	High blood pressure medication', 0.9999, '2023-06-30', 'Tablet', '2021-12-01', 0.02, 100),
(7, 'Atorvastatin', '	Cholesterol-lowering medication	', 0.9999, '2024-10-31', 'Tablet', '2022-02-01', 0.02, 400),
(8, 'Metformin', 'Diabetes medication', 0.9999, '2023-08-31', 'Tablet', '2021-11-01', 0.03, 350),
(9, 'Warfarin', 'Blood thinner for preventing clots', 0.9999, '2022-12-31', 'Tablet', '2021-01-01', 0.02, 150),
(10, 'Albuterol inhaler', 'Asthma medication in inhaler form', 0.9999, '2025-01-31', 'Inhalation', '2022-04-01', 0.01, 50),
(11, 'aspirin', 'in the morning for children', 0.9999, '2024-01-17', 'tablet', '2023-06-30', 0.60, 200),
(100, 'aspiren02', 'for children', 0.9999, '2009-09-08', 'lolo', '2006-05-07', 0.99, 100);

-- --------------------------------------------------------

--
-- Stand-in structure for view `product_transaction02`
-- (See below for the actual view)
--
CREATE TABLE `product_transaction02` (
`name` varchar(100)
,`TRANSACTION_Id` int(11)
,`amount` decimal(7,5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `stock_product_ceo`
-- (See below for the actual view)
--
CREATE TABLE `stock_product_ceo` (
`name` varchar(100)
,`stock` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `TRANSACTION_Id` int(11) NOT NULL,
  `channel` varchar(100) NOT NULL DEFAULT 'cash',
  `amount` decimal(7,5) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`TRANSACTION_Id`, `channel`, `amount`, `customer_id`) VALUES
(1, 'Online', '50.00000', 1),
(2, 'In-store', '20.00000', 2),
(3, 'Mobile app', '75.50000', 1),
(4, 'Online', '99.99999', 3),
(5, 'In-store', '15.75000', 1),
(6, 'Online', '45.00000', 2),
(7, 'Mobile app', '30.25000', 4),
(8, 'In-store', '55.50000', 5),
(9, 'Online', '85.00000', 3),
(10, 'In-store', '10.00000', 2),
(11, 'In-store', '25.00000', 6),
(12, 'Online	', '60.50000', 7),
(13, 'Mobile app', '40.00000', 6),
(14, 'In-store', '75.25000', 8),
(15, 'Online', '20.00000', 9),
(16, 'In-store', '35.75000', 7),
(17, 'Mobile app', '50.00000', 10),
(18, 'In-store', '10.50000', 6),
(19, 'Online	', '30.00000', 8),
(20, 'In-store', '65.00000', 9),
(45, 'lllllllll', '99.99999', 2);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_product`
--

CREATE TABLE `transaction_product` (
  `product_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction_product`
--

INSERT INTO `transaction_product` (`product_id`, `transaction_id`, `date`, `time`) VALUES
(1, 1, '2022-03-01', '08:30:00'),
(1, 7, '2022-03-07', '10:45:00'),
(2, 2, '2022-03-02', '15:45:40'),
(2, 3, '2022-03-03', '11:20:10'),
(2, 6, '2022-03-06', '17:30:00'),
(3, 1, '2022-03-01', '08:30:20'),
(3, 2, '2022-03-02', '15:45:50'),
(3, 5, '2022-03-05', '09:00:00'),
(3, 7, '2022-03-07', '10:45:30'),
(4, 4, '2022-03-04', '13:10:00'),
(4, 5, '2022-03-05', '09:10:00'),
(4, 6, '2022-03-06', '17:40:00'),
(5, 1, '2022-03-01', '08:30:30'),
(5, 4, '2022-03-04', '13:10:40'),
(5, 5, '2022-03-05', '09:40:00'),
(5, 7, '2022-03-07', '10:00:00'),
(6, 3, '2022-03-03', '11:20:00'),
(6, 4, '2022-03-04', '13:10:50'),
(6, 6, '2022-03-06', '17:30:40'),
(7, 1, '0000-00-00', '10:10:10');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `Warehouse_Number` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `storage_condition` varchar(100) NOT NULL,
  `branch_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warehouse`
--

INSERT INTO `warehouse` (`Warehouse_Number`, `name`, `storage_condition`, `branch_number`) VALUES
(1, 'warehouse_qatar', 'room_temperature', 1),
(2, 'warehouse_jordan', 'low_temperature', 2),
(3, 'warehouse_kuwait', 'high_temperature', 3),
(4, 'warehouse_USA', 'room_temperature', 4);

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_phone`
--

CREATE TABLE `warehouse_phone` (
  `Warehouse_number` int(11) NOT NULL,
  `phone` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warehouse_phone`
--

INSERT INTO `warehouse_phone` (`Warehouse_number`, `phone`) VALUES
(1, 5551234),
(1, 5555678),
(1, 5559012),
(2, 5553456),
(2, 5557890),
(3, 5552345),
(3, 5556789),
(4, 5550123),
(4, 5554567),
(4, 5558901);

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_product`
--

CREATE TABLE `warehouse_product` (
  `product_id` int(11) NOT NULL,
  `warehouse_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warehouse_product`
--

INSERT INTO `warehouse_product` (`product_id`, `warehouse_number`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(4, 3),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(6, 2),
(7, 4),
(8, 3),
(9, 1),
(9, 2),
(10, 3),
(10, 4);

-- --------------------------------------------------------

--
-- Structure for view `ceo_employee`
--
DROP TABLE IF EXISTS `ceo_employee`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ceo_employee`  AS SELECT `employee`.`employee_Id` AS `employee_Id`, `employee`.`email` AS `email`, `employee`.`phone` AS `phone`, `employee`.`salary` AS `salary`, `employee`.`first_name` AS `first_name`, `employee`.`last_name` AS `last_name`, `employee`.`birthdate` AS `birthdate`, `employee`.`degree` AS `degree`, `employee`.`level` AS `level`, `employee`.`Warehouse_number` AS `Warehouse_number`, `employee_address`.`building_name` AS `building_name`, `employee_address`.`building_number` AS `building_number`, `employee_address`.`city` AS `city`, `employee_address`.`street_name` AS `street_name` FROM (`employee` join `employee_address` on(`employee`.`employee_Id` = `employee_address`.`employee_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `ceo_warehouse`
--
DROP TABLE IF EXISTS `ceo_warehouse`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ceo_warehouse`  AS SELECT `warehouse`.`Warehouse_Number` AS `Warehouse_Number`, `warehouse`.`name` AS `name`, `warehouse`.`storage_condition` AS `storage_condition`, `warehouse`.`branch_number` AS `branch_number`, `warehouse_phone`.`phone` AS `phone` FROM (`warehouse` join `warehouse_phone` on(`warehouse`.`Warehouse_Number` = `warehouse_phone`.`Warehouse_number`))  ;

-- --------------------------------------------------------

--
-- Structure for view `customer_select`
--
DROP TABLE IF EXISTS `customer_select`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_select`  AS SELECT `product`.`name` AS `name`, `product`.`usage_` AS `usage_`, `product`.`price` AS `price`, `product`.`production_date` AS `production_date`, `product`.`expiration_date` AS `expiration_date` FROM `product``product`  ;

-- --------------------------------------------------------

--
-- Structure for view `employee_select`
--
DROP TABLE IF EXISTS `employee_select`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employee_select`  AS SELECT `employee`.`employee_Id` AS `employee_Id`, `employee`.`email` AS `email`, `employee`.`phone` AS `phone`, `employee`.`salary` AS `salary`, `employee`.`first_name` AS `first_name`, `employee`.`birthdate` AS `birthdate`, `employee`.`last_name` AS `last_name`, `employee`.`degree` AS `degree`, `employee`.`level` AS `level`, `employee`.`Warehouse_number` AS `Warehouse_number` FROM `employee``employee`  ;

-- --------------------------------------------------------

--
-- Structure for view `product_transaction02`
--
DROP TABLE IF EXISTS `product_transaction02`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_transaction02`  AS SELECT `product`.`name` AS `name`, `transaction`.`TRANSACTION_Id` AS `TRANSACTION_Id`, `transaction`.`amount` AS `amount` FROM ((`product` join `transaction`) join `transaction_product` on(`product`.`product_Id` = `transaction_product`.`product_id` and `transaction`.`TRANSACTION_Id` = `transaction_product`.`transaction_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `stock_product_ceo`
--
DROP TABLE IF EXISTS `stock_product_ceo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stock_product_ceo`  AS SELECT `product`.`name` AS `name`, `product`.`stock` AS `stock` FROM `product``product`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_Number`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_Id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_Id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `employee_fk1` (`Warehouse_number`);

--
-- Indexes for table `employee_address`
--
ALTER TABLE `employee_address`
  ADD PRIMARY KEY (`employee_id`,`street_name`,`city`,`building_number`,`building_name`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_Id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`TRANSACTION_Id`),
  ADD KEY `TRANSACTION_fk1` (`customer_id`);

--
-- Indexes for table `transaction_product`
--
ALTER TABLE `transaction_product`
  ADD PRIMARY KEY (`product_id`,`transaction_id`,`date`,`time`),
  ADD UNIQUE KEY `time` (`time`),
  ADD KEY `transaction_product_fk2` (`transaction_id`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`Warehouse_Number`),
  ADD KEY `Warehouse_fk1` (`branch_number`);

--
-- Indexes for table `warehouse_phone`
--
ALTER TABLE `warehouse_phone`
  ADD PRIMARY KEY (`Warehouse_number`,`phone`);

--
-- Indexes for table `warehouse_product`
--
ALTER TABLE `warehouse_product`
  ADD PRIMARY KEY (`product_id`,`warehouse_number`),
  ADD KEY `warehouse_product_fk2` (`warehouse_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=945865;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_fk1` FOREIGN KEY (`Warehouse_number`) REFERENCES `warehouse` (`Warehouse_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_address`
--
ALTER TABLE `employee_address`
  ADD CONSTRAINT `employee_address_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `TRANSACTION_fk1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`Customer_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction_product`
--
ALTER TABLE `transaction_product`
  ADD CONSTRAINT `transaction_product_fk1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_product_fk2` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`TRANSACTION_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD CONSTRAINT `Warehouse_fk1` FOREIGN KEY (`branch_number`) REFERENCES `branch` (`branch_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouse_phone`
--
ALTER TABLE `warehouse_phone`
  ADD CONSTRAINT `warehouse_phone_fk1` FOREIGN KEY (`Warehouse_number`) REFERENCES `warehouse` (`Warehouse_Number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouse_product`
--
ALTER TABLE `warehouse_product`
  ADD CONSTRAINT `warehouse_product_fk1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_product_fk2` FOREIGN KEY (`warehouse_number`) REFERENCES `warehouse` (`Warehouse_Number`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
