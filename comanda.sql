-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-11-2022 a las 03:21:48
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
(22, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(23, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(24, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!!'),
(25, 17, 2, 4, 2, 7, 1, 2, 'No vuelvo mas!!! Horrible');

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
(293, 'listo para servir', 'ee388', 5, 10, 1669415819, 2, 'cervecero'),
(294, 'listo para servir', 'c89dd', 7, 15, 1669502579, 2, 'cocinero'),
(295, 'listo para servir', 'c89dd', 5, 10, 1669502566, 2, 'cervecero'),
(296, 'listo para servir', 'ad4c1', 7, 15, 1669502597, 2, 'cocinero'),
(297, 'listo para servir', 'ad4c1', 5, 10, 1669502585, 2, 'cervecero'),
(298, 'listo para servir', 'ad988', 7, 15, 1669504295, 2, 'cocinero'),
(299, 'listo para servir', 'ad988', 5, 10, 1669504294, 2, 'cervecero'),
(300, 'listo para servir', '743dc', 7, 15, 1669504274, 2, 'cocinero'),
(301, 'listo para servir', '743dc', 5, 10, 1669504280, 2, 'cervecero'),
(302, 'listo para servir', '903dd', 7, 12, 1669504292, 1, 'cocinero'),
(303, 'listo para servir', '903dd', 6, 16, 1669504300, 2, 'bartender'),
(304, 'listo para servir', '903dd', 5, 10, 1669504258, 3, 'cervecero'),
(305, 'listo para servir', '38516', 7, 12, 1669505071, 1, 'cocinero'),
(306, 'listo para servir', '38516', 6, 16, 1669505070, 2, 'bartender'),
(307, 'listo para servir', '38516', 5, 10, 1669505080, 3, 'cervecero'),
(308, 'listo para servir', 'ebbe9', 7, 12, 1669505091, 1, 'cocinero'),
(309, 'listo para servir', 'ebbe9', 6, 16, 1669505097, 2, 'bartender'),
(310, 'listo para servir', 'ebbe9', 5, 10, 1669505109, 3, 'cervecero'),
(311, 'listo para servir', 'c5e65', 7, 12, 1669506131, 1, 'cocinero'),
(312, 'listo para servir', 'c5e65', 6, 16, 1669506107, 2, 'bartender'),
(313, 'listo para servir', 'c5e65', 5, 10, 1669506118, 3, 'cervecero'),
(314, 'listo para servir', '10dbd', 7, 12, 1669506141, 1, 'cocinero'),
(315, 'listo para servir', '10dbd', 6, 16, 1669506129, 2, 'bartender'),
(316, 'listo para servir', '10dbd', 5, 10, 1669506132, 3, 'cervecero'),
(317, 'listo para servir', 'a4c6b', 7, 12, 1669506141, 1, 'cocinero'),
(318, 'listo para servir', 'a4c6b', 6, 16, 1669506145, 2, 'bartender'),
(319, 'listo para servir', 'a4c6b', 5, 10, 1669506122, 3, 'cervecero'),
(320, 'listo para servir', 'af626', 7, 12, 1669506155, 1, 'cocinero'),
(321, 'listo para servir', 'af626', 6, 16, 1669506131, 2, 'bartender'),
(322, 'listo para servir', 'af626', 5, 10, 1669506143, 3, 'cervecero'),
(323, 'listo para servir', 'd6965', 7, 12, 1669506278, 1, 'cocinero'),
(324, 'listo para servir', 'd6965', 6, 16, 1669506275, 2, 'bartender'),
(325, 'listo para servir', 'd6965', 5, 10, 1669506257, 3, 'cervecero'),
(326, 'listo para servir', 'c6f96', 7, 12, 1669508162, 1, 'cocinero'),
(327, 'listo para servir', 'c6f96', 6, 16, 1669508560, 2, 'bartender'),
(328, 'listo para servir', 'c6f96', 5, 10, 1669508534, 3, 'cervecero'),
(329, 'listo para servir', 'f0a27', 7, 12, 1669509454, 1, 'cocinero'),
(330, 'listo para servir', 'f0a27', 6, 16, 1669509455, 2, 'bartender'),
(331, 'listo para servir', 'f0a27', 5, 10, 1669509462, 3, 'cervecero'),
(332, 'listo para servir', 'b889b', 7, 12, 1669512505, 1, 'cocinero'),
(333, 'listo para servir', 'b889b', 6, 16, 1669512507, 2, 'bartender'),
(334, 'listo para servir', 'b889b', 16, 10, 1669512512, 3, 'cervecero'),
(335, 'listo para servir', '1f256', 7, 12, 1669513905, 1, 'cocinero'),
(336, 'listo para servir', '1f256', 17, 16, 1669513909, 2, 'bartender'),
(337, 'listo para servir', '1f256', 16, 10, 1669513859, 3, 'cervecero'),
(338, 'listo para servir', '60804', 7, 15, 1669513929, 2, 'cocinero'),
(339, 'listo para servir', '60804', 16, 10, 1669513892, 2, 'cervecero'),
(340, 'listo para servir', '8db47', 15, 15, 1669514039, 2, 'cocinero'),
(341, 'listo para servir', '8db47', 16, 10, 1669514037, 2, 'cervecero'),
(342, 'listo para servir', '2d045', 15, 15, 1669514202, 2, 'cocinero'),
(343, 'listo para servir', '2d045', 16, 10, 1669514203, 2, 'cervecero'),
(344, 'listo para servir', '240b5', 7, 15, 1669514857, 2, 'cocinero'),
(345, 'listo para servir', '240b5', 16, 10, 1669514835, 2, 'cervecero'),
(346, 'listo para servir', '44302', 7, 12, 1669514863, 1, 'cocinero'),
(347, 'listo para servir', '44302', 17, 16, 1669514845, 2, 'bartender'),
(348, 'listo para servir', '44302', 16, 10, 1669514844, 3, 'cervecero'),
(349, 'listo para servir', '2a1de', 15, 12, 1669514903, 1, 'cocinero'),
(350, 'listo para servir', '2a1de', 6, 16, 1669514905, 2, 'bartender'),
(351, 'listo para servir', '2a1de', 5, 10, 1669514860, 3, 'cervecero'),
(352, 'listo para servir', 'd4904', 15, 12, 1669515326, 1, 'cocinero'),
(353, 'listo para servir', 'd4904', 6, 16, 1669515319, 2, 'bartender'),
(354, 'listo para servir', 'd4904', 5, 10, 1669515308, 3, 'cervecero'),
(355, 'listo para servir', 'c3de1', 15, 12, 1669515321, 1, 'cocinero'),
(356, 'listo para servir', 'c3de1', 6, 16, 1669515335, 2, 'bartender'),
(357, 'listo para servir', 'c3de1', 5, 10, 1669515314, 3, 'cervecero'),
(358, 'listo para servir', '726b7', 15, 12, 1669515349, 1, 'cocinero'),
(359, 'listo para servir', '726b7', 6, 16, 1669515330, 2, 'bartender'),
(360, 'listo para servir', '726b7', 5, 10, 1669515314, 3, 'cervecero'),
(361, 'listo para servir', '1a6de', 15, 12, 1669515325, 1, 'cocinero'),
(362, 'listo para servir', '1a6de', 6, 16, 1669515312, 2, 'bartender'),
(363, 'listo para servir', '1a6de', 5, 10, 1669515327, 3, 'cervecero');

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
(307, 1, '2026-11-22 13:33:56', 'Socio pide lista de logs'),
(308, 4, '2026-11-22 13:47:11', 'Mozo Carga el pedido'),
(309, 4, '2026-11-22 13:48:51', 'Mozo Carga el pedido'),
(310, 4, '2026-11-22 13:49:42', 'Mozo Asocia foto al pedido'),
(311, 7, '2026-11-22 13:49:57', 'Cocinero revisa pedidos pendientes'),
(312, 6, '2026-11-22 13:50:04', 'Bartender revisa pedidos pendientes'),
(313, 5, '2026-11-22 13:50:09', 'Cervecero revisa pedidos pendientes'),
(314, 16, '2026-11-22 13:50:28', 'Cervecero levanta pedidos'),
(315, 17, '2026-11-22 13:50:55', 'Bartender levanta pedidos'),
(316, 7, '2026-11-22 13:51:01', 'Cocinero levanta pedidos'),
(317, 1, '2026-11-22 13:52:10', 'Socio pide tiempo y estado de pedidos.'),
(318, 18, '2026-11-22 13:52:41', 'Mozo Carga el pedido'),
(319, 16, '2026-11-22 13:53:01', 'Cervecero levanta pedidos'),
(320, 15, '2026-11-22 13:53:20', 'Cocinero levanta pedidos'),
(321, 6, '2026-11-22 13:53:26', 'Bartender revisa pedidos pendientes'),
(322, 5, '2026-11-22 13:53:29', 'Cervecero revisa pedidos pendientes'),
(323, 1, '2026-11-22 13:53:56', 'Socio pide tiempo y estado de pedidos.'),
(324, 1, '2026-11-22 13:53:58', 'Socio pide tiempo y estado de pedidos.'),
(325, 1, '2026-11-22 13:54:00', 'Socio pide tiempo y estado de pedidos.'),
(326, 7, '2026-11-22 13:54:07', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(327, 7, '2026-11-22 13:54:09', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(328, 7, '2026-11-22 13:54:11', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(329, 7, '2026-11-22 13:54:14', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(330, 6, '2026-11-22 13:54:16', 'Bartender (id: 6) revisa pedidos listos para servir'),
(331, 6, '2026-11-22 13:54:18', 'Bartender (id: 6) revisa pedidos listos para servir'),
(332, 16, '2026-11-22 13:54:22', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(333, 16, '2026-11-22 13:54:24', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(334, 16, '2026-11-22 13:54:26', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(335, 5, '2026-11-22 13:54:50', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(336, 5, '2026-11-22 13:55:33', 'Cervecero revisa pedidos pendientes'),
(337, 18, '2026-11-22 13:55:43', 'Mozo Carga el pedido'),
(338, 16, '2026-11-22 13:55:48', 'Cervecero levanta pedidos'),
(339, 15, '2026-11-22 13:55:59', 'Cocinero levanta pedidos'),
(340, 1, '2026-11-22 13:56:10', 'Socio pide tiempo y estado de pedidos.'),
(341, 1, '2026-11-22 13:56:14', 'Socio pide tiempo y estado de pedidos.'),
(342, 7, '2026-11-22 13:56:21', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(343, 6, '2026-11-22 13:56:25', 'Bartender (id: 6) revisa pedidos listos para servir'),
(344, 5, '2026-11-22 13:56:29', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(345, 1, '2026-11-22 13:56:46', 'Socio pide mesas y estados'),
(346, 1, '2026-11-22 13:56:56', 'Socio pide tiempo y estado de pedidos.'),
(347, 7, '2026-11-22 13:57:02', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(348, 7, '2026-11-22 13:57:03', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(349, 6, '2026-11-22 13:57:08', 'Bartender (id: 6) revisa pedidos listos para servir'),
(350, 5, '2026-11-22 13:57:11', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(351, 5, '2026-11-22 13:57:12', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(352, 16, '2026-11-22 13:57:21', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(353, 16, '2026-11-22 13:57:23', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(354, 7, '2026-11-22 13:57:32', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(355, 15, '2026-11-22 13:57:38', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(356, 15, '2026-11-22 13:57:42', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(357, 4, '2026-11-22 13:57:50', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(358, 4, '2026-11-22 13:57:52', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(359, 4, '2026-11-22 13:57:54', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(360, 18, '2026-11-22 13:58:07', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(361, 18, '2026-11-22 13:58:10', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(362, 1, '2026-11-22 13:58:22', 'Socio pide mesas y estados'),
(363, 6, '2026-11-22 13:59:21', 'Bartender (id: 6) revisa pedidos listos para servir'),
(364, 17, '2026-11-22 13:59:35', 'Bartender (id: 17) revisa pedidos listos para servir'),
(365, 17, '2026-11-22 13:59:38', 'Bartender (id: 17) revisa pedidos listos para servir'),
(366, 1, '2026-11-22 13:59:48', 'Socio pide mesas y estados'),
(367, 1, '2026-11-22 13:59:56', 'Socio pide tiempo y estado de pedidos.'),
(368, 18, '2026-11-22 14:00:01', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(369, 4, '2026-11-22 14:00:08', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(370, 1, '2026-11-22 14:00:13', 'Socio pide mesas y estados'),
(371, 1, '2026-11-22 14:00:17', 'Socio pide tiempo y estado de pedidos.'),
(372, 1, '2026-11-22 14:00:19', 'Socio pide tiempo y estado de pedidos.'),
(373, 1, '2026-11-22 14:00:33', 'Socio pide tiempo y estado de pedidos.'),
(374, 1, '2026-11-22 14:00:42', 'Socio pide mesas y estados'),
(375, 4, '2026-11-22 14:00:51', 'Mozo (id: 4) cobra mesa'),
(376, 4, '2026-11-22 14:00:55', 'Mozo (id: 4) cobra mesa'),
(377, 18, '2026-11-22 14:01:17', 'Mozo (id: 18) cobra mesa'),
(378, 18, '2026-11-22 14:01:31', 'Mozo (id: 18) cobra mesa'),
(379, 1, '2026-11-22 14:02:06', 'Socio pide mesas y estados'),
(380, 1, '2026-11-22 14:02:18', 'Socio cierra mesa'),
(381, 1, '2026-11-22 14:02:21', 'Socio cierra mesa'),
(382, 1, '2026-11-22 14:02:24', 'Socio cierra mesa'),
(383, 1, '2026-11-22 14:02:28', 'Socio cierra mesa'),
(384, 1, '2026-11-22 14:02:39', 'Socio pide todos los comentarios'),
(385, 1, '2026-11-22 14:02:48', 'Socio pide mejores comentarios'),
(386, 1, '2026-11-22 14:02:53', 'Socio pide mesa mas usada'),
(387, 1, '2026-11-22 14:02:57', 'Socio pide lista de logs'),
(388, 1, '2026-11-22 14:04:50', 'Socio actualiza BBDD con archivo csv.'),
(389, 18, '2026-11-22 14:05:32', 'Mozo Carga el pedido'),
(390, 4, '2026-11-22 14:05:51', 'Mozo Carga el pedido'),
(391, 7, '2026-11-22 14:05:56', 'Cocinero revisa pedidos pendientes'),
(392, 6, '2026-11-22 14:06:04', 'Bartender revisa pedidos pendientes'),
(393, 5, '2026-11-22 14:06:09', 'Cervecero revisa pedidos pendientes'),
(394, 16, '2026-11-22 14:06:23', 'Cervecero levanta pedidos'),
(395, 17, '2026-11-22 14:06:27', 'Bartender levanta pedidos'),
(396, 7, '2026-11-22 14:06:39', 'Cocinero levanta pedidos'),
(397, 4, '2026-11-22 14:06:58', 'Mozo Carga el pedido'),
(398, 5, '2026-11-22 14:07:08', 'Cervecero levanta pedidos'),
(399, 6, '2026-11-22 14:07:16', 'Bartender levanta pedidos'),
(400, 15, '2026-11-22 14:07:26', 'Cocinero levanta pedidos'),
(401, 1, '2026-11-22 14:07:47', 'Socio pide tiempo y estado de pedidos.'),
(402, 1, '2026-11-22 14:07:49', 'Socio pide tiempo y estado de pedidos.'),
(403, 1, '2026-11-22 14:07:52', 'Socio pide tiempo y estado de pedidos.'),
(404, 1, '2026-11-22 14:08:07', 'Socio pide tiempo y estado de pedidos.'),
(405, 1, '2026-11-22 14:08:16', 'Socio pide tiempo y estado de pedidos.'),
(406, 1, '2026-11-22 14:09:24', 'Socio pide tiempo y estado de pedidos.'),
(407, 15, '2026-11-22 14:09:30', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(408, 15, '2026-11-22 14:09:32', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(409, 15, '2026-11-22 14:09:34', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(410, 17, '2026-11-22 14:09:38', 'Bartender (id: 17) revisa pedidos listos para servir'),
(411, 17, '2026-11-22 14:09:39', 'Bartender (id: 17) revisa pedidos listos para servir'),
(412, 16, '2026-11-22 14:09:43', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(413, 16, '2026-11-22 14:09:45', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(414, 16, '2026-11-22 14:09:47', 'Cervecero (id: 16) revisa pedidos listos para servir'),
(415, 4, '2026-11-22 14:09:54', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(416, 4, '2026-11-22 14:09:56', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(417, 1, '2026-11-22 14:10:02', 'Socio pide mesas y estados'),
(418, 18, '2026-11-22 14:10:16', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(419, 7, '2026-11-22 14:10:27', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(420, 7, '2026-11-22 14:10:29', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(421, 6, '2026-11-22 14:10:39', 'Bartender (id: 6) revisa pedidos listos para servir'),
(422, 6, '2026-11-22 14:10:41', 'Bartender (id: 6) revisa pedidos listos para servir'),
(423, 5, '2026-11-22 14:10:49', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(424, 5, '2026-11-22 14:10:51', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(425, 18, '2026-11-22 14:10:55', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(426, 18, '2026-11-22 14:10:57', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(427, 4, '2026-11-22 14:11:04', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(428, 4, '2026-11-22 14:11:06', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(429, 1, '2026-11-22 14:11:12', 'Socio pide mesas y estados'),
(430, 4, '2026-11-22 14:11:57', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(431, 1, '2026-11-22 14:12:07', 'Socio pide mesas y estados'),
(432, 18, '2026-11-22 14:12:36', 'Mozo (id: 18) cobra mesa'),
(433, 4, '2026-11-22 14:12:57', 'Mozo (id: 4) cobra mesa'),
(434, 4, '2026-11-22 14:13:01', 'Mozo (id: 4) cobra mesa'),
(435, 1, '2026-11-22 14:13:09', 'Socio cierra mesa'),
(436, 1, '2026-11-22 14:13:13', 'Socio cierra mesa'),
(437, 1, '2026-11-22 14:13:16', 'Socio cierra mesa'),
(438, 1, '2026-11-22 14:13:20', 'Socio cierra mesa'),
(439, 1, '2026-11-22 14:13:33', 'Socio pide mesas y estados'),
(440, 4, '2026-11-22 14:13:46', 'Mozo Carga el pedido'),
(441, 4, '2026-11-22 14:13:55', 'Mozo Carga el pedido'),
(442, 18, '2026-11-22 14:14:15', 'Mozo Carga el pedido'),
(443, 18, '2026-11-22 14:14:28', 'Mozo Carga el pedido'),
(444, 5, '2026-11-22 14:14:33', 'Cervecero levanta pedidos'),
(445, 6, '2026-11-22 14:14:37', 'Bartender levanta pedidos'),
(446, 15, '2026-11-22 14:14:40', 'Cocinero levanta pedidos'),
(447, 1, '2026-11-22 14:15:21', 'Socio pide tiempo y estado de pedidos.'),
(448, 1, '2026-11-22 14:15:24', 'Socio pide tiempo y estado de pedidos.'),
(449, 1, '2026-11-22 14:15:26', 'Socio pide tiempo y estado de pedidos.'),
(450, 1, '2026-11-22 14:15:28', 'Socio pide tiempo y estado de pedidos.'),
(451, 1, '2026-11-22 14:15:30', 'Socio pide tiempo y estado de pedidos.'),
(452, 1, '2026-11-22 14:15:42', 'Socio pide tiempo y estado de pedidos.'),
(453, 1, '2026-11-22 14:15:44', 'Socio pide tiempo y estado de pedidos.'),
(454, 1, '2026-11-22 14:15:45', 'Socio pide tiempo y estado de pedidos.'),
(455, 1, '2026-11-22 14:15:47', 'Socio pide tiempo y estado de pedidos.'),
(456, 1, '2026-11-22 14:15:49', 'Socio pide tiempo y estado de pedidos.'),
(457, 1, '2026-11-22 14:15:51', 'Socio pide tiempo y estado de pedidos.'),
(458, 1, '2026-11-22 14:15:52', 'Socio pide tiempo y estado de pedidos.'),
(459, 7, '2026-11-22 14:16:01', 'Cocinero (id: 7) revisa pedidos listos para servir'),
(460, 6, '2026-11-22 14:16:05', 'Bartender (id: 6) revisa pedidos listos para servir'),
(461, 5, '2026-11-22 14:16:09', 'Cervecero (id: 5) revisa pedidos listos para servir'),
(462, 15, '2026-11-22 14:16:23', 'Cocinero (id: 15) revisa pedidos listos para servir'),
(463, 4, '2026-11-22 14:16:29', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(464, 4, '2026-11-22 14:16:32', 'Mozo (id: 4) verifica si hay pedidos listos para servir'),
(465, 18, '2026-11-22 14:16:43', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(466, 18, '2026-11-22 14:16:44', 'Mozo (id: 18) verifica si hay pedidos listos para servir'),
(467, 1, '2026-11-22 14:16:47', 'Socio pide mesas y estados'),
(468, 4, '2026-11-22 14:17:03', 'Mozo (id: 4) cobra mesa'),
(469, 4, '2026-11-22 14:17:08', 'Mozo (id: 4) cobra mesa'),
(470, 18, '2026-11-22 14:17:28', 'Mozo (id: 18) cobra mesa'),
(471, 18, '2026-11-22 14:17:32', 'Mozo (id: 18) cobra mesa'),
(472, 1, '2026-11-22 14:17:37', 'Socio cierra mesa'),
(473, 1, '2026-11-22 14:17:41', 'Socio cierra mesa'),
(474, 1, '2026-11-22 14:17:45', 'Socio cierra mesa'),
(475, 1, '2026-11-22 14:17:49', 'Socio cierra mesa'),
(476, 1, '2026-11-22 14:17:54', 'Socio pide mesas y estados'),
(477, 1, '2026-11-22 14:18:24', 'Socio pide todos los comentarios'),
(478, 1, '2026-11-22 14:18:30', 'Socio pide mejores comentarios'),
(479, 1, '2026-11-22 14:18:34', 'Socio pide mesa mas usada'),
(480, 1, '2026-11-22 14:18:37', 'Socio pide lista de logs'),
(481, 1, '2026-11-22 14:18:53', 'Socio actualiza BBDD con archivo csv.');

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
(18, 'Cerrada', 1, '2a3e7'),
(19, 'cerrada', 1, '770d4'),
(20, 'Cerrada', 1, 'd831c'),
(21, 'cerrada', 0, '2686d'),
(22, 'con cliente pagando', 0, 'c8470');

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
(101, '25d66', 'DAn', 17, 'terminado', './FotosPedidos/cliente-DAn-codigoAlfanumericoPedido-25d66.jpg', 0, 4),
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
(137, 'ee388', 'Andres123', 17, 'Terminado', NULL, 1669415843, 4),
(138, 'c89dd', 'Andres123', 17, 'Terminado', NULL, 1669502579, 4),
(139, 'ad4c1', 'Andres123', 18, 'Terminado', NULL, 1669502597, 4),
(140, 'ad988', 'Andres123', 15, 'Terminado', NULL, 1669504295, 4),
(141, '743dc', 'Andres123', 14, 'Terminado', NULL, 1669504280, 4),
(142, '903dd', 'Andres123', 16, 'Terminado', NULL, 1669504300, 4),
(143, '38516', 'Andres123', 16, 'Terminado', NULL, 1669505080, 4),
(144, 'ebbe9', 'Andres123', 17, 'Terminado', NULL, 1669505109, 4),
(145, 'c5e65', 'Andres123', 17, 'Terminado', NULL, 1669506131, 4),
(146, '10dbd', 'Andres123', 16, 'Terminado', NULL, 1669506141, 4),
(147, 'a4c6b', 'Andres123', 15, 'Terminado', NULL, 1669506145, 4),
(148, 'af626', 'Andres123', 14, 'Terminado', NULL, 1669506155, 4),
(149, 'd6965', 'Andres123', 18, 'Terminado', NULL, 1669506278, 4),
(150, 'c6f96', 'Andres123', 20, 'Terminado', NULL, 1669508560, 4),
(151, 'f0a27', 'Andres123', 20, 'Terminado', NULL, 1669509462, 4),
(152, 'b889b', 'Andres123', 20, 'Terminado', NULL, 1669512512, 4),
(153, '1f256', 'Andres22', 20, 'Terminado', './FotosPedidos/Andres22-1f256.jpg', 1669513909, 4),
(154, '60804', 'Mario', 17, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-60804.jpg', 1669513929, 4),
(155, '8db47', 'Mario', 14, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-8db47.jpg', 1669514039, 18),
(156, '2d045', 'Mario', 15, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-2d045.jpg', 1669514203, 18),
(157, '240b5', 'Mario', 15, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-240b5.jpg', 1669514857, 18),
(158, '44302', 'Mario', 14, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-44302.jpg', 1669514863, 4),
(159, '2a1de', 'Mario', 17, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-2a1de.jpg', 1669514905, 4),
(160, 'd4904', 'Mario', 17, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-d4904.jpg', 1669515326, 4),
(161, 'c3de1', 'Mario', 18, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-c3de1.jpg', 1669515335, 4),
(162, '726b7', 'Mario', 14, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-726b7.jpg', 1669515349, 18),
(163, '1a6de', 'Mario', 15, 'Terminado', './FotosPedidos/cliente-Mario-codigoAlfanumericoPedido-1a6de.jpg', 1669515327, 18);

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
(31, 'milanesas de pollo', 123, 1, 'cocinero'),
(33, 'Arroz', 77, 1, 'cocinero');

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
(14, 'Andy', 'cocinero', '2022-11-27 01:43:25', 'Baja', '$2y$10$5rr7pZEJn20KNGXnRzOVmOagpPSRWS0dmXqGCzkVCmTFX6RTIs6pm'),
(15, 'Marcos', 'cocinero', '2020-12-11 03:00:00', 'activo', '$2y$10$TuRxeeo5iyNGwrwqB13mKOyO2Tur3afOlTApi1F6NUJBAHssa6VKW'),
(16, 'Matias', 'cervecero', '2020-12-11 03:00:00', 'activo', '$2y$10$IXTdN0JAtPiEBciX7cbedeTAwDi./S1clNafP9LoAley95qTxLFP.'),
(17, 'Lucas', 'bartender', '2020-12-11 03:00:00', 'activo', '$2y$10$KziZ//AwwRANIR0HMT6hfuUmFEClaV1DkKSCws7.R.jnh65kwGjsS'),
(18, 'Debora', 'mozo', '2020-12-11 03:00:00', 'activo', '$2y$10$b0jkBh0kJC4pdoxjc4AaOe5kQUvK9eoeJEDREc6xUkVBqpxbByYc2');

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
  MODIFY `comentarioId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `detallespedidos`
--
ALTER TABLE `detallespedidos`
  MODIFY `detallePedidoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=364;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `idLog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=482;

--
-- AUTO_INCREMENT de la tabla `mesas`
--
ALTER TABLE `mesas`
  MODIFY `mesaId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `pedidoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `productoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `empleadoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
