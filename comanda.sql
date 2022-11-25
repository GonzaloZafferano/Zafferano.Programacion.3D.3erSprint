-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2022 a las 23:41:05
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `comanda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `comentarioId` int(11) NOT NULL,
  `mesaId` int(11) NOT NULL,
  `puntuacionMesa` int(11) NOT NULL,
  `mozoId` int(11) NOT NULL,
  `puntuacionMozo` int(11) NOT NULL,
  `cocineroId` int(11) NOT NULL,
  `puntuacionCocinero` int(11) NOT NULL,
  `puntuacionRestaurante` int(11) NOT NULL,
  `comentarios` varchar(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`comentarioId`, `mesaId`, `puntuacionMesa`, `mozoId`, `puntuacionMozo`, `cocineroId`, `puntuacionCocinero`, `puntuacionRestaurante`, `comentarios`) VALUES
(8, 15, 9, 4, 7, 7, 7, 7, 'Buena comida, buena atencion'),
(9, 15, 7, 4, 8, 7, 8, 7, 'Buen servicio'),
(10, 15, 7, 4, 9, 7, 7, 7, 'Buena atencion!'),
(11, 15, 9, 4, 9, 7, 8, 9, 'Muy conforme'),
(12, 15, 1, 4, 5, 7, 8, 7, 'Muy mala la mesa, mala atencion del mozo'),
(13, 15, 8, 4, 5, 7, 2, 7, 'La comida estaba fria'),
(14, 15, 8, 4, 2, 7, 5, 7, 'El mozo nos dejo esperando el menu 30 minutos, la comida estaba fr'),
(15, 15, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!'),
(16, 15, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!'),
(17, 15, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!'),
(18, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!'),
(19, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(20, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(21, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(22, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallespedidos`
--

CREATE TABLE `detallespedidos` (
  `detallePedidoId` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `codigoAlfanumerico` varchar(5) NOT NULL,
  `empleadoId` int(11) DEFAULT NULL,
  `productoId` int(11) NOT NULL,
  `tiempoPreparacion` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `perfil` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detallespedidos`
--

INSERT INTO `detallespedidos` (`detallePedidoId`, `estado`, `codigoAlfanumerico`, `empleadoId`, `productoId`, `tiempoPreparacion`, `cantidad`, `perfil`) VALUES
(183, 'listo para servir', '25d66', 7, 14, 0, 2, 'cocinero'),
(184, 'listo para servir', '25d66', 5, 10, 0, 2, 'cervecero'),
(185, 'listo para servir', '94164', 7, 12, 1668860320, 1, 'cocinero'),
(186, 'listo para servir', '94164', 6, 16, 1668860340, 2, 'bartender'),
(187, 'listo para servir', '94164', 5, 10, 1668860516, 3, 'cervecero'),
(188, 'listo para servir', 'ee2a0', 7, 12, 1668860320, 1, 'cocinero'),
(189, 'listo para servir', 'ee2a0', 6, 16, 1668860340, 2, 'bartender'),
(190, 'listo para servir', 'ee2a0', 5, 10, 1668860516, 3, 'cervecero'),
(191, 'listo para servir', '8f4be', 7, 12, 1668860767, 1, 'cocinero'),
(192, 'listo para servir', '8f4be', 6, 16, 1668860753, 2, 'bartender'),
(193, 'listo para servir', '8f4be', 5, 10, 1668860750, 3, 'cervecero'),
(194, 'listo para servir', '783a4', 7, 12, 1668860767, 1, 'cocinero'),
(195, 'listo para servir', '783a4', 6, 16, 1668860753, 2, 'bartender'),
(196, 'listo para servir', '783a4', 5, 10, 1668860750, 3, 'cervecero'),
(197, 'listo para servir', 'd654a', 7, 12, 1668861355, 1, 'cocinero'),
(198, 'listo para servir', 'd654a', 6, 16, 1668861364, 2, 'bartender'),
(199, 'listo para servir', 'd654a', 5, 10, 1668861352, 3, 'cervecero'),
(200, 'listo para servir', '5324b', 7, 12, 1668861583, 1, 'cocinero'),
(201, 'listo para servir', '5324b', 6, 16, 1668861568, 2, 'bartender'),
(202, 'listo para servir', '5324b', 5, 10, 1668861562, 3, 'cervecero'),
(203, 'listo para servir', '3607b', 7, 12, 1668862829, 1, 'cocinero'),
(204, 'listo para servir', '3607b', 6, 16, 1668862826, 2, 'bartender'),
(205, 'listo para servir', '3607b', 5, 10, 1668862820, 3, 'cervecero'),
(206, 'listo para servir', '5465f', 7, 12, 1668862829, 1, 'cocinero'),
(207, 'listo para servir', '5465f', 6, 16, 1668862826, 2, 'bartender'),
(208, 'listo para servir', '5465f', 5, 10, 1668862820, 3, 'cervecero'),
(209, 'listo para servir', '3f9fd', 7, 12, 1668864420, 1, 'cocinero'),
(210, 'listo para servir', '3f9fd', 6, 16, 1668864419, 2, 'bartender'),
(211, 'listo para servir', '3f9fd', 5, 10, 1668864419, 3, 'cervecero'),
(212, 'listo para servir', '974f5', 7, 12, 1668864517, 1, 'cocinero'),
(213, 'listo para servir', '974f5', 6, 16, 1668864530, 2, 'bartender'),
(214, 'listo para servir', '974f5', 5, 10, 1668864529, 3, 'cervecero'),
(215, 'listo para servir', 'f167b', 7, 12, 1668864517, 1, 'cocinero'),
(216, 'listo para servir', 'f167b', 6, 16, 1668864530, 2, 'bartender'),
(217, 'listo para servir', 'f167b', 5, 10, 1668864529, 3, 'cervecero'),
(218, 'listo para servir', 'fbf97', 7, 12, 1668864821, 1, 'cocinero'),
(219, 'listo para servir', 'fbf97', 6, 16, 1668864827, 2, 'bartender'),
(220, 'listo para servir', 'fbf97', 5, 10, 1668864820, 3, 'cervecero'),
(221, 'listo para servir', '64a35', 7, 12, 1668864821, 1, 'cocinero'),
(222, 'listo para servir', '64a35', 6, 16, 1668864827, 2, 'bartender'),
(223, 'listo para servir', '64a35', 5, 10, 1668864820, 3, 'cervecero'),
(224, 'listo para servir', 'b1d55', 7, 12, 1668864821, 1, 'cocinero'),
(225, 'listo para servir', 'b1d55', 6, 16, 1668864827, 2, 'bartender'),
(226, 'listo para servir', 'b1d55', 5, 10, 1668864820, 3, 'cervecero'),
(227, 'listo para servir', '5f1d8', 7, 12, 1668864892, 1, 'cocinero'),
(228, 'listo para servir', '5f1d8', 6, 16, 1668864883, 2, 'bartender'),
(229, 'listo para servir', '5f1d8', 5, 10, 1668864868, 3, 'cervecero'),
(230, 'listo para servir', '35833', 7, 12, 1668864961, 1, 'cocinero'),
(231, 'listo para servir', '35833', 6, 16, 1668864967, 2, 'bartender'),
(232, 'listo para servir', '35833', 5, 10, 1668864966, 3, 'cervecero'),
(233, 'listo para servir', 'b34ca', 7, 12, 1668865031, 1, 'cocinero'),
(234, 'listo para servir', 'b34ca', 6, 16, 1668865042, 2, 'bartender'),
(235, 'listo para servir', 'b34ca', 5, 10, 1668865031, 3, 'cervecero'),
(236, 'listo para servir', '9f293', 7, 12, 1668865162, 1, 'cocinero'),
(237, 'listo para servir', '9f293', 6, 16, 1668865153, 2, 'bartender'),
(238, 'listo para servir', '9f293', 5, 10, 1668865162, 3, 'cervecero'),
(239, 'listo para servir', '8e5a4', 7, 12, 1668865529, 1, 'cocinero'),
(240, 'listo para servir', '8e5a4', 6, 16, 1668865548, 2, 'bartender'),
(241, 'listo para servir', '8e5a4', 5, 10, 1668865558, 3, 'cervecero'),
(242, 'listo para servir', '85299', 7, 12, 1668865529, 1, 'cocinero'),
(243, 'listo para servir', '85299', 6, 16, 1668865548, 2, 'bartender'),
(244, 'listo para servir', '85299', 5, 10, 1668865558, 3, 'cervecero'),
(245, 'listo para servir', 'eaa86', 7, 12, 1668866195, 1, 'cocinero'),
(246, 'listo para servir', 'eaa86', 6, 16, 1668866188, 2, 'bartender'),
(247, 'listo para servir', 'eaa86', 5, 10, 1668866191, 3, 'cervecero'),
(248, 'listo para servir', 'a8fd1', 7, 12, 1668866195, 1, 'cocinero'),
(249, 'listo para servir', 'a8fd1', 6, 16, 1668866188, 2, 'bartender'),
(250, 'listo para servir', 'a8fd1', 5, 10, 1668866191, 3, 'cervecero'),
(251, 'listo para servir', '44e87', 7, 12, 1668866195, 1, 'cocinero'),
(252, 'listo para servir', '44e87', 6, 16, 1668866188, 2, 'bartender'),
(253, 'listo para servir', '44e87', 5, 10, 1668866191, 3, 'cervecero'),
(254, 'listo para servir', 'a8b94', 7, 12, 1668868061, 1, 'cocinero'),
(255, 'listo para servir', 'a8b94', 6, 16, 1668868058, 2, 'bartender'),
(256, 'listo para servir', 'a8b94', 5, 10, 1668868050, 3, 'cervecero'),
(257, 'listo para servir', '1f897', 7, 12, 1668993319, 1, 'cocinero'),
(258, 'listo para servir', '1f897', 6, 16, 1668993308, 2, 'bartender'),
(259, 'listo para servir', '1f897', 5, 10, 1668993310, 3, 'cervecero'),
(260, 'listo para servir', '9d3a2', 7, 12, 1668993319, 1, 'cocinero'),
(261, 'listo para servir', '9d3a2', 6, 16, 1668993308, 2, 'bartender'),
(262, 'listo para servir', '9d3a2', 5, 10, 1668993310, 3, 'cervecero'),
(263, 'listo para servir', 'ef42f', 7, 12, 1668993319, 1, 'cocinero'),
(264, 'listo para servir', 'ef42f', 6, 16, 1668993308, 2, 'bartender'),
(265, 'listo para servir', 'ef42f', 5, 10, 1668993310, 3, 'cervecero'),
(266, 'listo para servir', '36a76', 7, 12, 1668993319, 1, 'cocinero'),
(267, 'listo para servir', '36a76', 6, 16, 1668993308, 2, 'bartender'),
(268, 'listo para servir', '36a76', 5, 10, 1668993310, 3, 'cervecero'),
(269, 'listo para servir', '3e340', 7, 12, 1668996468, 1, 'cocinero'),
(270, 'listo para servir', '3e340', 6, 16, 1668996466, 2, 'bartender'),
(271, 'listo para servir', '3e340', 5, 10, 1668996469, 3, 'cervecero'),
(272, 'listo para servir', 'bb438', 7, 12, 1668996468, 1, 'cocinero'),
(273, 'listo para servir', 'bb438', 6, 16, 1668996466, 2, 'bartender'),
(274, 'listo para servir', 'bb438', 5, 10, 1668996469, 3, 'cervecero'),
(275, 'listo para servir', '04e01', 7, 12, 1668997491, 1, 'cocinero'),
(276, 'listo para servir', '04e01', 6, 16, 1668997455, 2, 'bartender'),
(277, 'listo para servir', '04e01', 5, 10, 1668997447, 3, 'cervecero'),
(278, 'listo para servir', 'a0bb5', 7, 12, 1669249557, 1, 'cocinero'),
(279, 'listo para servir', 'a0bb5', 6, 16, 1669249553, 2, 'bartender'),
(280, 'listo para servir', 'a0bb5', 5, 10, 1669249540, 3, 'cervecero'),
(281, 'listo para servir', 'fb42a', 7, 12, 1669249557, 1, 'cocinero'),
(282, 'listo para servir', 'fb42a', 6, 16, 1669249553, 2, 'bartender'),
(283, 'listo para servir', 'fb42a', 5, 10, 1669249540, 3, 'cervecero'),
(284, 'listo para servir', '595b9', 7, 12, 1669249557, 1, 'cocinero'),
(285, 'listo para servir', '595b9', 6, 16, 1669249553, 2, 'bartender'),
(286, 'listo para servir', '595b9', 5, 10, 1669249540, 3, 'cervecero'),
(287, 'listo para servir', '422fd', 7, 12, 1669249921, 1, 'cocinero'),
(288, 'listo para servir', '422fd', 6, 16, 1669249904, 2, 'bartender'),
(289, 'listo para servir', '422fd', 5, 10, 1669249917, 3, 'cervecero'),
(290, 'listo para servir', '9d2d8', 7, 15, 1669412880, 2, 'cocinero'),
(291, 'listo para servir', '9d2d8', 5, 10, 1669412877, 2, 'cervecero'),
(292, 'listo para servir', 'ee388', 7, 15, 1669415843, 2, 'cocinero'),
(293, 'listo para servir', 'ee388', 5, 10, 1669415819, 2, 'cervecero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs`
--

CREATE TABLE `logs` (
  `idLog` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `accion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `logs`
--

INSERT INTO `logs` (`idLog`, `idUsuario`, `fecha`, `accion`) VALUES
(3, 1, '2023-11-22 12:24:12', 'Socio pide lista de logs'),
(4, 4, '2023-11-22 12:24:36', 'Mozo Carga el pedido'),
(5, 4, '2023-11-22 12:24:50', 'Mozo Asocia foto al pedido'),
(6, 7, '2023-11-22 12:24:56', 'Cocinero revisa pedidos pendientes'),
(7, 7, '2023-11-22 12:25:07', 'Cocinero revisa pedidos pendientes'),
(8, 6, '2023-11-22 12:25:12', 'Bartender revisa pedidos pendientes'),
(9, 5, '2023-11-22 12:25:21', 'Cervecero revisa pedidos pendientes'),
(10, 5, '2023-11-22 12:25:30', 'Cervecero levanta pedidos'),
(11, 6, '2023-11-22 12:25:35', 'Bartender levanta pedidos'),
(12, 7, '2023-11-22 12:25:39', 'Cocinero levanta pedidos'),
(13, 6, '2023-11-22 12:25:41', 'Bartender revisa pedidos pendientes'),
(14, 5, '2023-11-22 12:25:50', 'Cervecero revisa pedidos pendientes'),
(15, 1, '2023-11-22 12:25:58', 'Socio pide tiempo y estado de pedidos.'),
(16, 7, '2023-11-22 12:26:04', 'Cocinero revisa pedidos listos para servir'),
(17, 6, '2023-11-22 12:26:08', 'Bartender revisa pedidos listos para servir'),
(18, 6, '2023-11-22 12:26:10', 'Bartender revisa pedidos listos para servir'),
(19, 5, '2023-11-22 12:26:13', 'Cervecero revisa pedidos listos para servir'),
(20, 4, '2023-11-22 12:26:17', 'Mozo verifica si hay pedidos listos para servir'),
(21, 1, '2023-11-22 12:26:20', 'Socio pide mesas y estados'),
(22, 4, '2023-11-22 12:26:28', 'Mozo verifica si hay pedidos listos para servir'),
(23, 4, '2023-11-22 12:26:35', 'Mozo cobra mesa'),
(24, 1, '2023-11-22 12:26:40', 'Socio pide mesas y estados'),
(25, 4, '2023-11-22 12:26:49', 'Mozo cobra mesa'),
(26, 4, '2023-11-22 12:26:52', 'Mozo cobra mesa'),
(27, 1, '2023-11-22 12:26:55', 'Socio cierra mesa'),
(28, 1, '2023-11-22 12:26:58', 'Socio cierra mesa'),
(29, 1, '2023-11-22 12:27:02', 'Socio pide mesas y estados'),
(30, 1, '2023-11-22 12:27:10', 'Socio cierra mesa'),
(31, 1, '2023-11-22 12:27:15', 'Socio pide todos los comentarios'),
(32, 1, '2023-11-22 12:27:19', 'Socio pide mejores comentarios'),
(33, 1, '2023-11-22 12:27:22', 'Socio pide mesa mas usada'),
(34, 1, '2023-11-22 12:27:27', 'Socio pide lista de logs'),
(35, 1, '2023-11-22 12:30:22', 'Socio pide lista de logs'),
(36, 4, '2023-11-22 12:30:47', 'Mozo Carga el pedido'),
(37, 5, '2023-11-22 12:31:27', 'Cervecero levanta pedidos'),
(38, 6, '2023-11-22 12:31:29', 'Bartender levanta pedidos'),
(39, 7, '2023-11-22 12:31:32', 'Cocinero levanta pedidos'),
(40, 4, '2023-11-22 12:31:39', 'Mozo verifica si hay pedidos listos para servir'),
(41, 1, '2023-11-22 12:31:46', 'Socio pide tiempo y estado de pedidos.'),
(42, 1, '2023-11-22 12:31:48', 'Socio pide tiempo y estado de pedidos.'),
(43, 1, '2024-11-22 12:44:05', 'Socio actualiza BBDD con archivo csv.'),
(44, 1, '2024-11-22 12:45:21', 'Socio actualiza BBDD con archivo csv.'),
(45, 1, '2024-11-22 12:45:55', 'Socio actualiza BBDD con archivo csv.'),
(46, 1, '2024-11-22 12:46:36', 'Socio actualiza BBDD con archivo csv.'),
(47, 1, '2024-11-22 12:47:47', 'Socio actualiza BBDD con archivo csv.'),
(48, 1, '2024-11-22 12:48:34', 'Socio actualiza BBDD con archivo csv.'),
(49, 1, '2024-11-22 12:49:14', 'Socio actualiza BBDD con archivo csv.'),
(50, 1, '2024-11-22 12:54:01', 'Socio actualiza BBDD con archivo csv.'),
(51, 1, '2024-11-22 12:54:40', 'Socio actualiza BBDD con archivo csv.'),
(52, 1, '2024-11-22 12:58:53', 'Socio actualiza BBDD con archivo csv.'),
(53, 1, '2024-11-22 13:07:49', 'Socio actualiza BBDD con archivo csv.'),
(54, 1, '2024-11-22 13:08:29', 'Socio actualiza BBDD con archivo csv.'),
(55, 1, '2024-11-22 13:09:02', 'Socio actualiza BBDD con archivo csv.'),
(56, 1, '2025-11-22 09:39:44', 'Socio pide lista de logs'),
(57, 1, '2025-11-22 09:41:32', 'Socio actualiza BBDD con archivo csv.'),
(58, 1, '2025-11-22 09:42:04', 'Socio actualiza BBDD con archivo csv.'),
(59, 4, '2025-11-22 09:45:13', 'Mozo Carga el pedido'),
(60, 4, '2025-11-22 09:45:35', 'Mozo Asocia foto al pedido'),
(61, 4, '2025-11-22 09:45:56', 'Mozo Asocia foto al pedido'),
(62, 7, '2025-11-22 09:46:05', 'Cocinero revisa pedidos pendientes'),
(63, 6, '2025-11-22 09:46:12', 'Bartender revisa pedidos pendientes'),
(64, 5, '2025-11-22 09:46:15', 'Cervecero revisa pedidos pendientes'),
(65, 1, '2025-11-22 09:46:25', 'Socio pide mesas y estados'),
(66, 5, '2025-11-22 09:47:03', 'Cervecero levanta pedidos'),
(67, 7, '2025-11-22 09:47:10', 'Cocinero levanta pedidos'),
(68, 1, '2025-11-22 09:47:58', 'Socio pide tiempo y estado de pedidos.'),
(69, 1, '2025-11-22 09:48:01', 'Socio pide tiempo y estado de pedidos.'),
(70, 1, '2025-11-22 09:48:04', 'Socio pide tiempo y estado de pedidos.'),
(71, 7, '2025-11-22 09:48:09', 'Cocinero revisa pedidos listos para servir'),
(72, 6, '2025-11-22 09:48:13', 'Bartender revisa pedidos listos para servir'),
(73, 5, '2025-11-22 09:48:17', 'Cervecero revisa pedidos listos para servir'),
(74, 4, '2025-11-22 09:48:33', 'Mozo verifica si hay pedidos listos para servir'),
(75, 4, '2025-11-22 09:48:39', 'Mozo verifica si hay pedidos listos para servir'),
(76, 1, '2025-11-22 09:48:42', 'Socio pide mesas y estados'),
(77, 4, '2025-11-22 09:48:52', 'Mozo cobra mesa'),
(78, 4, '2025-11-22 09:48:55', 'Mozo cobra mesa'),
(79, 4, '2025-11-22 09:48:59', 'Mozo cobra mesa'),
(80, 1, '2025-11-22 09:49:05', 'Socio cierra mesa'),
(81, 1, '2025-11-22 09:49:10', 'Socio cierra mesa'),
(82, 1, '2025-11-22 09:49:14', 'Socio cierra mesa'),
(83, 1, '2025-11-22 09:49:22', 'Socio pide mesas y estados'),
(84, 1, '2025-11-22 09:50:04', 'Socio pide todos los comentarios'),
(85, 1, '2025-11-22 09:50:30', 'Socio pide todos los comentarios'),
(86, 1, '2025-11-22 09:50:37', 'Socio pide mejores comentarios'),
(87, 1, '2025-11-22 09:51:11', 'Socio pide mesa mas usada'),
(88, 1, '2025-11-22 09:51:16', 'Socio pide mesa mas usada'),
(89, 1, '2025-11-22 09:51:21', 'Socio pide lista de logs'),
(90, 1, '2025-11-22 09:54:51', 'Socio actualiza BBDD con archivo csv.'),
(91, 1, '2025-11-22 10:31:15', 'Socio pide lista de logs'),
(92, 1, '2025-11-22 10:31:27', 'Socio actualiza BBDD con archivo csv.'),
(93, 4, '2025-11-22 10:35:57', 'Mozo Carga el pedido'),
(94, 4, '2025-11-22 10:36:01', 'Mozo Asocia foto al pedido'),
(95, 7, '2025-11-22 10:36:07', 'Cocinero revisa pedidos pendientes'),
(96, 6, '2025-11-22 10:36:11', 'Bartender revisa pedidos pendientes'),
(97, 5, '2025-11-22 10:36:14', 'Cervecero revisa pedidos pendientes'),
(98, 5, '2025-11-22 10:36:17', 'Cervecero levanta pedidos'),
(99, 7, '2025-11-22 10:36:25', 'Cocinero levanta pedidos'),
(100, 1, '2025-11-22 10:36:32', 'Socio pide tiempo y estado de pedidos.'),
(101, 7, '2025-11-22 10:36:36', 'Cocinero revisa pedidos listos para servir'),
(102, 6, '2025-11-22 10:36:39', 'Bartender revisa pedidos listos para servir'),
(103, 5, '2025-11-22 10:36:42', 'Cervecero revisa pedidos listos para servir'),
(104, 4, '2025-11-22 10:36:44', 'Mozo verifica si hay pedidos listos para servir'),
(105, 1, '2025-11-22 10:36:48', 'Socio pide mesas y estados'),
(106, 4, '2025-11-22 10:36:57', 'Mozo cobra mesa'),
(107, 1, '2025-11-22 10:37:01', 'Socio cierra mesa'),
(108, 1, '2025-11-22 10:37:47', 'Socio pide tiempo y estado de pedidos.'),
(109, 7, '2025-11-22 10:37:50', 'Cocinero revisa pedidos listos para servir'),
(110, 6, '2025-11-22 10:37:53', 'Bartender revisa pedidos listos para servir'),
(111, 5, '2025-11-22 10:37:56', 'Cervecero revisa pedidos listos para servir'),
(112, 4, '2025-11-22 10:37:59', 'Mozo verifica si hay pedidos listos para servir'),
(113, 1, '2025-11-22 10:38:02', 'Socio pide mesas y estados'),
(114, 4, '2025-11-22 10:38:05', 'Mozo cobra mesa'),
(115, 1, '2025-11-22 10:38:12', 'Socio cierra mesa'),
(116, 1, '2025-11-22 10:38:47', 'Socio pide todos los comentarios'),
(117, 1, '2025-11-22 10:38:54', 'Socio pide mejores comentarios'),
(118, 1, '2025-11-22 10:38:58', 'Socio pide mesa mas usada'),
(119, 1, '2025-11-22 10:39:04', 'Socio pide lista de logs'),
(120, 1, '2025-11-22 10:39:35', 'Socio actualiza BBDD con archivo csv.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesas`
--

CREATE TABLE `mesas` (
  `mesaId` int(11) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `codigoMesa` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mesas`
--

INSERT INTO `mesas` (`mesaId`, `estado`, `activo`, `codigoMesa`) VALUES
(14, 'Cerrada', 1, '74ce6'),
(15, 'Cerrada', 1, '6a1dc'),
(16, 'Cerrada', 1, '82ea5'),
(17, 'Cerrada', 1, '4093f'),
(18, 'cerrada', 1, '2a3e7'),
(19, 'cerrada', 1, '770d4'),
(20, 'cerrada', 1, 'd831c'),
(21, 'cerrada', 0, '2686d');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `pedidoId` int(11) NOT NULL,
  `codigoAlfanumerico` varchar(5) NOT NULL,
  `nombreCliente` varchar(25) NOT NULL,
  `mesaId` int(11) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `fotoUrl` varchar(255) DEFAULT NULL,
  `tiempoPreparacion` int(11) DEFAULT NULL,
  `mozoId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`pedidoId`, `codigoAlfanumerico`, `nombreCliente`, `mesaId`, `estado`, `fotoUrl`, `tiempoPreparacion`, `mozoId`) VALUES
(101, '25d66', 'DAn', 17, 'terminado', NULL, 0, 4),
(102, '94164', 'DAn', 17, 'Terminado', NULL, 1668860516, 4),
(103, 'ee2a0', 'DAn', 18, 'Terminado', NULL, 1668860516, 4),
(104, '8f4be', 'DAn', 18, 'Terminado', NULL, 1668860767, 4),
(105, '783a4', 'DAn', 19, 'Terminado', NULL, 1668860767, 4),
(106, 'd654a', 'DAn', 19, 'Terminado', NULL, 1668861364, 4),
(107, '5324b', 'DAn', 19, 'Terminado', NULL, 1668861583, 4),
(108, '3607b', 'DAn', 19, 'terminado', NULL, 1668862829, 4),
(109, '5465f', 'DAn', 20, 'terminado', NULL, 1668862829, 4),
(110, '3f9fd', 'DAn', 20, 'Terminado', NULL, 1668864420, 4),
(111, '974f5', 'DAn', 19, 'Terminado', NULL, 1668864530, 4),
(112, 'f167b', 'DAn', 20, 'Terminado', NULL, 1668864530, 4),
(113, 'fbf97', 'DAn', 20, 'Terminado', NULL, 1668864827, 4),
(114, '64a35', 'DAn', 19, 'Terminado', NULL, 1668864827, 4),
(115, 'b1d55', 'DAn', 18, 'Terminado', NULL, 1668864827, 4),
(116, '5f1d8', 'DAn', 17, 'Terminado', NULL, 1668864892, 4),
(117, '35833', 'DAn', 16, 'Terminado', NULL, 1668864967, 4),
(118, 'b34ca', 'DAn', 15, 'Terminado', NULL, 1668865042, 4),
(119, '9f293', 'DAn', 14, 'Terminado', NULL, 1668865162, 4),
(120, '8e5a4', 'DAn', 20, 'Terminado', NULL, 1668865558, 4),
(121, '85299', 'DAn', 19, 'Terminado', NULL, 1668865558, 4),
(122, 'eaa86', 'DAn', 19, 'Terminado', NULL, 1668866195, 4),
(123, 'a8fd1', 'DAn', 18, 'Terminado', NULL, 1668866195, 4),
(124, '44e87', 'DAn', 17, 'Terminado', './FotosPedidos/DAn-44e87.jpg', 1668866195, 4),
(125, 'a8b94', 'GonFZ', 18, 'Terminado', './FotosPedidos/cliente-GonFZ-codigoAlfanumericoPedido-a8b94.jpg', 1668868061, 4),
(126, '9d3a2', 'GonFZ', 19, 'Terminado', '4', 1668993319, 4),
(127, 'ef42f', 'GonFZ', 20, 'Terminado', NULL, 1668993319, 4),
(128, '36a76', 'GonFZ', 15, 'Terminado', NULL, 1668993319, 4),
(129, '3e340', 'GonFZ', 15, 'Terminado', NULL, 1668996469, 4),
(130, 'bb438', 'GonFZ', 14, 'Terminado', NULL, 1668996469, 4),
(131, '04e01', 'GonFZ', 14, 'Terminado', NULL, 1668997491, 4),
(132, 'a0bb5', 'GonFZ', 14, 'Terminado', NULL, 1669249557, 4),
(133, 'fb42a', 'GonFZ', 15, 'Terminado', NULL, 1669249557, 4),
(134, '595b9', 'GonFZ', 16, 'Terminado', NULL, 1669249557, 4),
(135, '422fd', 'GonFZ', 16, 'Terminado', NULL, 1669249921, 4),
(136, '9d2d8', 'Andres123', 17, 'Terminado', './FotosPedidos/cliente-Andres123-codigoAlfanumericoPedido-9d2d8.jpg', 1669412880, 4),
(137, 'ee388', 'Andres123', 17, 'Terminado', NULL, 1669415843, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `productoId` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `precio` double NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `perfil` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`productoId`, `nombre`, `precio`, `activo`, `perfil`) VALUES
(10, 'Cerveza', 100, 1, 'cervecero'),
(11, 'Daikiri', 95, 1, 'bartender'),
(12, 'pizza', 150, 1, 'cocinero'),
(13, 'milanesa', 130, 1, 'cocinero'),
(14, 'PAPAS con cheddar', 250, 1, 'cocinero'),
(15, 'papas', 13, 1, 'cocinero'),
(16, 'Vino', 195, 1, 'bartender'),
(17, 'milanesa a caballo', 250, 1, 'cocinero'),
(18, 'hamburguesa de garbanzo', 200, 1, 'cocinero'),
(19, 'corona', 95, 1, 'cervecero'),
(22, 'daikiri', 95, 1, 'bartender'),
(23, 'tekila', 105, 1, 'bartender'),
(24, 'quimes', 98, 1, 'cervecero'),
(25, 'Brahma', 95, 1, 'cervecero'),
(31, 'milanesas de pollo', 123, 1, 'cocinero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `empleadoId` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `perfil` varchar(25) NOT NULL,
  `fechaIngreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` varchar(25) NOT NULL,
  `clave` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`empleadoId`, `nombre`, `perfil`, `fechaIngreso`, `estado`, `clave`) VALUES
(1, 'gonza', 'socio', '2022-11-16 23:01:28', 'activo', '$2y$10$E2iMclcX/hDD5.AH4GrIJewF0vBUiLE0vWDLFB2m3ZkZKvFDG.wmi'),
(2, 'daniel', 'socio', '2022-11-16 23:01:38', 'activo', '$2y$10$bMAeSzJMm0K8Sa6J1orjvuGXLBQOHL5U1XzMMGpQWH5PNjzgr667S'),
(3, 'nicolas', 'socio', '2022-11-16 23:01:47', 'activo', '$2y$10$dq3WwGXgX/cb39PX6xrHfeb5W4YLlO/2n1ZO7aCcXwZRd0G5dk8Bm'),
(4, 'pris', 'mozo', '2022-11-16 23:02:14', 'activo', '$2y$10$u8jWAAZZfQLJfRYF902ppe6s17NnKRDqfXbhVF.MpObWAipdzLx02'),
(5, 'fabian', 'cervecero', '2022-11-16 23:02:44', 'activo', '$2y$10$yFCIC/hmb/QF7U6UAsxm7OIOKvmY0XiAcRrwckOPotGBddU6OSTgK'),
(6, 'juan', 'bartender', '2022-11-16 23:03:02', 'activo', '$2y$10$ct6s.dPi9FJ6xtn9cHY.9uWDEcuv7cPg1l9sxdBL9LSa4N6K0t9Du'),
(7, 'graciela', 'cocinero', '2022-11-16 23:12:11', 'activo', '$2y$10$..qr6OSQT0Dxv1/E7Bc3OuaLFJWEkqDpFG0X8Jf9PEiOyXt6BGbp6'),
(8, 'Priscila', 'bartender', '2022-11-16 23:13:07', 'Baja', '$2y$10$LZeUlvFXwyw5T7r98c'),
(9, 'Priscila', 'bartender', '2022-11-16 23:13:14', 'Baja', '$2y$10$u3mPHNrvYIyxmWOBuO'),
(10, 'Priscila', 'bartender', '2022-11-16 23:13:19', 'Baja', '$2y$10$D4gxvrv7IhBOcgnliy'),
(11, 'Sebastian', 'bartender', '2022-11-16 23:13:24', 'Baja', '$2y$10$v6Dsuw23y3QKYfFcfq'),
(12, 'Sebastian', 'bartender', '2022-11-16 23:13:28', 'Baja', '$2y$10$bVQ9K1lnxhV9B/HHga'),
(13, 'gonza2', 'bartender', '2020-12-11 03:00:00', 'activo', '$2y$10$3GiJwMH7G4Bcq1HQJnphT.tz41oO8pf9UvHygY0Gp0n25aE8xIKoy'),
(14, 'Andy', 'cocinero', '2022-11-19 11:29:50', 'Baja', '$2y$10$Gfo/0hUApB0LBV9RgcVtrOKleQF567E0BPDn48rL5r9YoJrriVtyS');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`comentarioId`);

--
-- Indices de la tabla `detallespedidos`
--
ALTER TABLE `detallespedidos`
  ADD PRIMARY KEY (`detallePedidoId`);

--
-- Indices de la tabla `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`idLog`);

--
-- Indices de la tabla `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`mesaId`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`pedidoId`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`productoId`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`empleadoId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `comentarioId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `detallespedidos`
--
ALTER TABLE `detallespedidos`
  MODIFY `detallePedidoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=294;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `idLog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT de la tabla `mesas`
--
ALTER TABLE `mesas`
  MODIFY `mesaId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `pedidoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `productoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `empleadoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
