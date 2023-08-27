-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-08-2023 a las 01:49:43
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `project_general`
--
CREATE DATABASE IF NOT EXISTS `project_general` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `project_general`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_insert_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_user` (IN `UserId` INT, IN `UserPassword` VARCHAR(50), IN `UserUser` VARCHAR(20), IN `RoleId` INT, IN `UserStatusId` INT)   BEGIN
IF (SELECT COUNT(*) FROM user WHERE User_user=UserUser)=0 THEN 
    INSERT INTO `user` (`User_id`, `User_password`, `User_user`, `Role_id`, `UserStatus_id`) 
    VALUES (UserId, UserPassword,UserUser,RoleId, UserStatusId); 
    SELECT'USER INSERT' AS errorMessage;
ELSE 
    SELECT 'DUPLICATE KEY ERROR' AS errorMessage;
END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_select_module_user_id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_module_user_id` (IN `UserId` INT)   BEGIN 
SELECT MO.Modules_name, MO.Modules_routes FROM modules_role MR 
INNER JOIN modules MO ON MR.Modules_id=MO.Modules_id
WHERE Role_id=(SELECT Role_id FROM user WHERE User_id=UserId);
END$$

DROP PROCEDURE IF EXISTS `sp_select_user_email`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_user_email` (IN `UserUser` VARCHAR(50))   BEGIN 
SELECT * FROM user WHERE User_user=UserUser AND UserStatus_id=1; 
END$$

DROP PROCEDURE IF EXISTS `sp_select_user_id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_user_id` (IN `UserId` INT)   BEGIN 
SELECT User_password FROM user WHERE User_id=UserId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_name` varchar(10) NOT NULL,
  `Customer_email` varchar(20) NOT NULL,
  `Customer_phone` varchar(10) NOT NULL,
  `Customer_address` varchar(20) NOT NULL,
  `Customer_last_name` varchar(10) NOT NULL,
  `DocumentType_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Customer_id`),
  KEY `customer_document Type` (`DocumentType_id`),
  KEY `customer_user` (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `customer`
--

TRUNCATE TABLE `customer`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documenttype`
--

DROP TABLE IF EXISTS `documenttype`;
CREATE TABLE IF NOT EXISTS `documenttype` (
  `DocumentType_id` int(11) NOT NULL AUTO_INCREMENT,
  `DocumentType_name` varchar(20) NOT NULL,
  `DocumentType_symbol` varchar(10) NOT NULL,
  PRIMARY KEY (`DocumentType_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `documenttype`
--

TRUNCATE TABLE `documenttype`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `Modules_id` int(11) NOT NULL AUTO_INCREMENT,
  `Modules_name` varchar(20) NOT NULL,
  `Modules_routes` varchar(20) NOT NULL,
  PRIMARY KEY (`Modules_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `modules`
--

TRUNCATE TABLE `modules`;
--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`Modules_id`, `Modules_name`, `Modules_routes`) VALUES
(1, 'Home', 'home/index.php'),
(2, 'User', 'user/index.php'),
(3, 'Products', 'products/index.php');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules_role`
--

DROP TABLE IF EXISTS `modules_role`;
CREATE TABLE IF NOT EXISTS `modules_role` (
  `Modules_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `Modules_id` int(11) NOT NULL,
  `Role_id` int(11) NOT NULL,
  PRIMARY KEY (`Modules_role_id`),
  KEY `modules_role_module` (`Modules_id`),
  KEY `modules_role_role` (`Role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `modules_role`
--

TRUNCATE TABLE `modules_role`;
--
-- Volcado de datos para la tabla `modules_role`
--

INSERT INTO `modules_role` (`Modules_role_id`, `Modules_id`, `Role_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 2),
(4, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Product_id` int(11) NOT NULL AUTO_INCREMENT,
  `Product_name` varchar(10) NOT NULL,
  `Product_descriptions` varchar(100) NOT NULL,
  `Product_code` varchar(10) NOT NULL,
  `Product_purchase_cost` double NOT NULL,
  `Product_cost` double NOT NULL,
  `ProductType_id` int(11) NOT NULL,
  `ProductStatus_id` int(11) NOT NULL,
  PRIMARY KEY (`Product_id`),
  KEY `product_product_type` (`ProductType_id`),
  KEY `product_project_general` (`ProductStatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `product`
--

TRUNCATE TABLE `product`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productstatus`
--

DROP TABLE IF EXISTS `productstatus`;
CREATE TABLE IF NOT EXISTS `productstatus` (
  `ProductStatus_id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductStatus_name` varchar(20) NOT NULL,
  PRIMARY KEY (`ProductStatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `productstatus`
--

TRUNCATE TABLE `productstatus`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producttype`
--

DROP TABLE IF EXISTS `producttype`;
CREATE TABLE IF NOT EXISTS `producttype` (
  `ProductType_id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductType_name` varchar(20) NOT NULL,
  PRIMARY KEY (`ProductType_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `producttype`
--

TRUNCATE TABLE `producttype`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quote`
--

DROP TABLE IF EXISTS `quote`;
CREATE TABLE IF NOT EXISTS `quote` (
  `Quote_id` int(11) NOT NULL AUTO_INCREMENT,
  `Quote_date` date NOT NULL,
  `Quote_hour` time NOT NULL,
  `Quote_customer_name` varchar(10) NOT NULL,
  `Quote_customer_last_name` varchar(10) NOT NULL,
  `Quote_customer_email` varchar(20) NOT NULL,
  `Quote_customer_cellphone` varchar(10) NOT NULL,
  `Services_id` int(11) NOT NULL,
  PRIMARY KEY (`Quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `quote`
--

TRUNCATE TABLE `quote`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `Role_id` int(11) NOT NULL AUTO_INCREMENT,
  `Role_name` varchar(20) NOT NULL,
  PRIMARY KEY (`Role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `role`
--

TRUNCATE TABLE `role`;
--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`Role_id`, `Role_name`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `Services_id` int(11) NOT NULL AUTO_INCREMENT,
  `Services_name` varchar(20) NOT NULL,
  `Services_descriptions` varchar(200) NOT NULL,
  `Services_location` varchar(100) NOT NULL,
  `Services_cost` double NOT NULL,
  PRIMARY KEY (`Services_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `services`
--

TRUNCATE TABLE `services`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `User_id` int(11) NOT NULL AUTO_INCREMENT,
  `User_password` varchar(255) NOT NULL,
  `User_user` varchar(50) NOT NULL,
  `Role_id` int(11) NOT NULL,
  `UserStatus_id` int(11) NOT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `User_user` (`User_user`),
  KEY `user_status` (`UserStatus_id`),
  KEY `user_role` (`Role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `user`
--

TRUNCATE TABLE `user`;
--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`User_id`, `User_password`, `User_user`, `Role_id`, `UserStatus_id`) VALUES
(1, '123456', 'diego@gmail.com', 1, 1),
(2, '$2y$10$RJvN33b5.xCUQSuOJ6Akre8gb3DL7N5ItnvZePU27nKTopQPUCCtu', 'diehercasvan@gmail.com', 1, 1),
(3, '$2y$10$RJvN33b5.xCUQSuOJ6Akre8gb3DL7N5ItnvZePU27nKTopQPUCCtu', 'diehercasvansena@gmail.com', 1, 1),
(4, '$2y$10$MpKZlGMkUGB/x7vDikra6exjCpkp72K4e/UtFpSVNTpc3NCrzG0Xq', 'info@sinapsist.com.co', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `userstatus`
--

DROP TABLE IF EXISTS `userstatus`;
CREATE TABLE IF NOT EXISTS `userstatus` (
  `UserStatus_id` int(11) NOT NULL AUTO_INCREMENT,
  `UserStatus_name` varchar(20) NOT NULL,
  PRIMARY KEY (`UserStatus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncar tablas antes de insertar `userstatus`
--

TRUNCATE TABLE `userstatus`;
--
-- Volcado de datos para la tabla `userstatus`
--

INSERT INTO `userstatus` (`UserStatus_id`, `UserStatus_name`) VALUES
(1, 'Activo'),
(2, 'Bloqueado');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_document Type` FOREIGN KEY (`DocumentType_id`) REFERENCES `documenttype` (`DocumentType_id`),
  ADD CONSTRAINT `customer_user` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`);

--
-- Filtros para la tabla `modules_role`
--
ALTER TABLE `modules_role`
  ADD CONSTRAINT `modules_role_module` FOREIGN KEY (`Modules_id`) REFERENCES `modules` (`Modules_id`),
  ADD CONSTRAINT `modules_role_role` FOREIGN KEY (`Role_id`) REFERENCES `role` (`Role_id`);

--
-- Filtros para la tabla `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_product_type` FOREIGN KEY (`ProductType_id`) REFERENCES `producttype` (`ProductType_id`),
  ADD CONSTRAINT `product_project_general` FOREIGN KEY (`ProductStatus_id`) REFERENCES `productstatus` (`ProductStatus_id`);

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_role` FOREIGN KEY (`Role_id`) REFERENCES `role` (`Role_id`),
  ADD CONSTRAINT `user_status` FOREIGN KEY (`UserStatus_id`) REFERENCES `userstatus` (`UserStatus_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
