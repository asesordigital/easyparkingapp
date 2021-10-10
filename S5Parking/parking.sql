-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-10-2021 a las 01:56:08
-- Versión del servidor: 5.7.9
-- Versión de PHP: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parking`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
  `no_factura` int(11) NOT NULL AUTO_INCREMENT,
  `id_ticket` int(11) NOT NULL,
  `cost_hora` float DEFAULT NULL,
  `fecha_hor_fact` datetime DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `tipo_id` varchar(20) DEFAULT NULL,
  `no_id` int(11) DEFAULT NULL,
  `iva` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`no_factura`),
  KEY `fk-ticket10` (`id_ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plaza`
--

DROP TABLE IF EXISTS `plaza`;
CREATE TABLE IF NOT EXISTS `plaza` (
  `plaza_id` int(11) NOT NULL,
  `tipo_plaza` varchar(30) NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`plaza_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `Fech_hora_ent` datetime NOT NULL,
  `Fech_hora_sal` datetime NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `no_placa` varchar(30) NOT NULL,
  `id_plaza` int(11) NOT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `fk-ticket1` (`id_plaza`),
  KEY `fk-ticket2` (`id_usuario`),
  KEY `fk-ticket3` (`no_placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `passw` varchar(30) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE IF NOT EXISTS `vehiculo` (
  `no_placa` varchar(10) NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`no_placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`no_placa`, `color`) VALUES
('abc123', NULL),
('vgt435', 'verde'),
('xyz123', 'negro');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk-ticket10` FOREIGN KEY (`id_ticket`) REFERENCES `ticket` (`id_ticket`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `fk-ticket1` FOREIGN KEY (`id_plaza`) REFERENCES `plaza` (`plaza_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk-ticket2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk-ticket3` FOREIGN KEY (`no_placa`) REFERENCES `vehiculo` (`no_placa`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
