-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-10-2025 a las 04:26:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `devconnect`
--
CREATE DATABASE IF NOT EXISTS `devconnect` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `devconnect`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas_especializacion`
--

CREATE TABLE `areas_especializacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas_especializacion`
--

INSERT INTO `areas_especializacion` (`id`, `nombre`) VALUES
(2, 'Backend'),
(9, 'Cloud Computing'),
(8, 'Cybersecurity'),
(6, 'Data Science'),
(5, 'DevOps'),
(1, 'Frontend'),
(3, 'Full Stack'),
(7, 'Machine Learning'),
(4, 'Mobile');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conversaciones`
--

CREATE TABLE `conversaciones` (
  `id` int(11) NOT NULL,
  `oferta_id` int(11) DEFAULT NULL,
  `usuario1_id` int(11) NOT NULL,
  `usuario2_id` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_mensaje` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `conversaciones`
--

INSERT INTO `conversaciones` (`id`, `oferta_id`, `usuario1_id`, `usuario2_id`, `fecha_creacion`, `ultimo_mensaje`) VALUES
(1, NULL, 4, 7, '2025-10-13 19:28:37', '2025-10-15 06:47:12'),
(2, 1, 1, 8, '2025-10-13 19:39:29', NULL),
(3, 4, 7, 8, '2025-10-13 19:40:36', '2025-10-13 19:40:41'),
(4, NULL, 7, 8, '2025-10-13 19:41:13', NULL),
(5, NULL, 3, 7, '2025-10-13 19:41:29', '2025-10-15 06:46:21'),
(6, NULL, 2, 7, '2025-10-15 06:46:52', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desarrollador_areas`
--

CREATE TABLE `desarrollador_areas` (
  `id` int(11) NOT NULL,
  `desarrollador_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `desarrollador_areas`
--

INSERT INTO `desarrollador_areas` (`id`, `desarrollador_id`, `area_id`) VALUES
(1, 2, 1),
(2, 2, 2),
(3, 3, 2),
(4, 3, 4),
(5, 4, 1),
(6, 4, 3),
(7, 8, 1),
(8, 9, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desarrollador_lenguajes`
--

CREATE TABLE `desarrollador_lenguajes` (
  `id` int(11) NOT NULL,
  `desarrollador_id` int(11) NOT NULL,
  `lenguaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `desarrollador_lenguajes`
--

INSERT INTO `desarrollador_lenguajes` (`id`, `desarrollador_id`, `lenguaje_id`) VALUES
(1, 2, 1),
(2, 2, 2),
(3, 3, 3),
(4, 3, 4),
(5, 4, 1),
(6, 4, 5),
(7, 8, 1),
(8, 8, 6),
(9, 9, 4),
(10, 9, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lenguajes`
--

CREATE TABLE `lenguajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lenguajes`
--

INSERT INTO `lenguajes` (`id`, `nombre`) VALUES
(4, 'C#'),
(6, 'C++'),
(9, 'Go'),
(3, 'Java'),
(1, 'JavaScript'),
(11, 'Kotlin'),
(5, 'PHP'),
(2, 'Python'),
(8, 'Ruby'),
(12, 'Rust'),
(13, 'SQL'),
(10, 'Swift'),
(7, 'TypeScript');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `conversacion_id` int(11) NOT NULL,
  `remitente_id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `conversacion_id`, `remitente_id`, `mensaje`, `fecha_envio`, `leido`) VALUES
(1, 3, 8, 'hola', '2025-10-13 19:40:41', 1),
(2, 5, 7, 'hola', '2025-10-15 06:46:21', 0),
(3, 1, 7, 'hola', '2025-10-15 06:47:12', 0);

--
-- Disparadores `mensajes`
--
DELIMITER $$
CREATE TRIGGER `tr_actualizar_ultimo_mensaje` AFTER INSERT ON `mensajes` FOR EACH ROW BEGIN
    UPDATE conversaciones 
    SET ultimo_mensaje = NEW.fecha_envio 
    WHERE id = NEW.conversacion_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ofertas_trabajo`
--

CREATE TABLE `ofertas_trabajo` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `empleador_id` int(11) NOT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `activa` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ofertas_trabajo`
--

INSERT INTO `ofertas_trabajo` (`id`, `titulo`, `empresa`, `descripcion`, `empleador_id`, `fecha_publicacion`, `activa`) VALUES
(1, 'Desarrollador Frontend Senior', 'TechCorp', 'Buscamos desarrollador frontend con experiencia en React y TypeScript.', 1, '2025-10-12 02:42:47', 1),
(2, 'Desarrollador Backend', 'Innovatech', 'Oportunidad para desarrollador backend con conocimientos en Node.js y Python.', 1, '2025-10-12 02:42:47', 1),
(3, 'Mobile Developer', 'AppSolutions', 'Buscamos desarrollador móvil con experiencia en React Native o Flutter.', 1, '2025-10-12 02:42:47', 1),
(4, 'licenciatura', 'fds', '1', 7, '2025-10-13 19:40:21', 1);

--
-- Disparadores `ofertas_trabajo`
--
DELIMITER $$
CREATE TRIGGER `tr_verificar_tipo_usuario_oferta` BEFORE INSERT ON `ofertas_trabajo` FOR EACH ROW BEGIN
    DECLARE v_tipo_usuario_id INT;
    
    SELECT tipo_id INTO v_tipo_usuario_id 
    FROM usuarios 
    WHERE id = NEW.empleador_id;
    
    IF v_tipo_usuario_id != 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Solo los empleadores pueden crear ofertas de trabajo';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oferta_requisitos`
--

CREATE TABLE `oferta_requisitos` (
  `id` int(11) NOT NULL,
  `oferta_id` int(11) NOT NULL,
  `lenguaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `oferta_requisitos`
--

INSERT INTO `oferta_requisitos` (`id`, `oferta_id`, `lenguaje_id`) VALUES
(1, 1, 1),
(2, 1, 7),
(3, 2, 1),
(4, 2, 2),
(5, 3, 1),
(6, 3, 10),
(7, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id`, `nombre`) VALUES
(2, 'desarrollador'),
(1, 'empleador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password_hash`, `tipo_id`, `nombres`, `apellidos`, `fecha_nacimiento`, `empresa`, `fecha_registro`, `activo`) VALUES
(1, 'emp1', '$2b$10$examplehash1', 1, 'Juan', 'Empresario', '1980-01-01', 'TechCorp', '2025-10-12 02:42:47', 1),
(2, 'dev1', '$2b$10$examplehash2', 2, 'María', 'Desarrolladora', '1990-05-15', NULL, '2025-10-12 02:42:47', 1),
(3, 'dev2', '$2b$10$examplehash3', 2, 'Carlos', 'Programador', '1988-03-20', NULL, '2025-10-12 02:42:47', 1),
(4, 'dev3', '$2b$10$examplehash4', 2, 'Ana', 'Desarrolladora', '1992-11-05', NULL, '2025-10-12 02:42:47', 1),
(5, 'Empleador', '$2y$10$45d3f4mza5R6VSFcGXLdJOhLTdpJcAfzsB.KR9Bjksq0rvDFZhvHW', 1, 'Angel', 'Castellanos', '2025-10-11', 'comac', '2025-10-12 03:54:45', 1),
(6, 'Empleador1', '$2y$10$TWGuwBA3CM3uhdxaej.X8ut1JZsdeg45GVhSbrze0MMgwqVcsHNsC', 1, 'Angel', 'Castellanos', '2025-10-11', 'comac', '2025-10-12 04:00:22', 1),
(7, 'Empleador2', '$2y$10$6/MDoaTL206jRxeB4x2CaeuNaG/LEHYUdEm1LO2BRMn5lzOVY0CDC', 1, 'Angel', 'Castellanos', '2025-10-13', 'comac', '2025-10-13 19:26:50', 1),
(8, 'Desarrollador1', '$2y$10$I3cUIZtuRtYFnmJyXj0rjO28Ny94vSX/cwKoKAjj7skqLPqZna8aK', 2, 'Angel', 'Castellanos', '2025-10-13', NULL, '2025-10-13 19:37:59', 1),
(9, 'juan', '$2y$10$/VhEFkQkRV131u/Xx.xbU.VwhEu.pw.AwUHkfIBHHVRpSzmLjtAGy', 2, 'Juan', 'Perez', '2022-01-15', NULL, '2025-10-15 21:15:30', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_desarrolladores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_desarrolladores` (
`id` int(11)
,`username` varchar(50)
,`nombres` varchar(100)
,`apellidos` varchar(100)
,`fecha_nacimiento` date
,`lenguajes` mediumtext
,`areas` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ofertas_completas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_ofertas_completas` (
`id` int(11)
,`titulo` varchar(200)
,`empresa` varchar(100)
,`descripcion` text
,`empleador_id` int(11)
,`empleador_nombre` varchar(100)
,`empleador_apellido` varchar(100)
,`fecha_publicacion` timestamp
,`requisitos` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_desarrolladores`
--
DROP TABLE IF EXISTS `vista_desarrolladores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_desarrolladores`  AS SELECT `u`.`id` AS `id`, `u`.`username` AS `username`, `u`.`nombres` AS `nombres`, `u`.`apellidos` AS `apellidos`, `u`.`fecha_nacimiento` AS `fecha_nacimiento`, group_concat(distinct `l`.`nombre` separator ',') AS `lenguajes`, group_concat(distinct `a`.`nombre` separator ',') AS `areas` FROM ((((`usuarios` `u` left join `desarrollador_lenguajes` `dl` on(`u`.`id` = `dl`.`desarrollador_id`)) left join `lenguajes` `l` on(`dl`.`lenguaje_id` = `l`.`id`)) left join `desarrollador_areas` `da` on(`u`.`id` = `da`.`desarrollador_id`)) left join `areas_especializacion` `a` on(`da`.`area_id` = `a`.`id`)) WHERE `u`.`tipo_id` = 2 AND `u`.`activo` = 1 GROUP BY `u`.`id` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ofertas_completas`
--
DROP TABLE IF EXISTS `vista_ofertas_completas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_ofertas_completas`  AS SELECT `o`.`id` AS `id`, `o`.`titulo` AS `titulo`, `o`.`empresa` AS `empresa`, `o`.`descripcion` AS `descripcion`, `o`.`empleador_id` AS `empleador_id`, `u`.`nombres` AS `empleador_nombre`, `u`.`apellidos` AS `empleador_apellido`, `o`.`fecha_publicacion` AS `fecha_publicacion`, group_concat(distinct `l`.`nombre` separator ',') AS `requisitos` FROM (((`ofertas_trabajo` `o` join `usuarios` `u` on(`o`.`empleador_id` = `u`.`id`)) left join `oferta_requisitos` `orq` on(`o`.`id` = `orq`.`oferta_id`)) left join `lenguajes` `l` on(`orq`.`lenguaje_id` = `l`.`id`)) WHERE `o`.`activa` = 1 GROUP BY `o`.`id` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas_especializacion`
--
ALTER TABLE `areas_especializacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `conversaciones`
--
ALTER TABLE `conversaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_conversacion` (`oferta_id`,`usuario1_id`,`usuario2_id`),
  ADD KEY `usuario2_id` (`usuario2_id`),
  ADD KEY `idx_conversaciones_oferta` (`oferta_id`),
  ADD KEY `idx_conversaciones_usuarios` (`usuario1_id`,`usuario2_id`);

--
-- Indices de la tabla `desarrollador_areas`
--
ALTER TABLE `desarrollador_areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_desarrollador_area` (`desarrollador_id`,`area_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indices de la tabla `desarrollador_lenguajes`
--
ALTER TABLE `desarrollador_lenguajes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_desarrollador_lenguaje` (`desarrollador_id`,`lenguaje_id`),
  ADD KEY `lenguaje_id` (`lenguaje_id`);

--
-- Indices de la tabla `lenguajes`
--
ALTER TABLE `lenguajes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remitente_id` (`remitente_id`),
  ADD KEY `idx_mensajes_conversacion` (`conversacion_id`),
  ADD KEY `idx_mensajes_fecha` (`fecha_envio`);

--
-- Indices de la tabla `ofertas_trabajo`
--
ALTER TABLE `ofertas_trabajo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ofertas_empleador` (`empleador_id`),
  ADD KEY `idx_ofertas_fecha` (`fecha_publicacion`);

--
-- Indices de la tabla `oferta_requisitos`
--
ALTER TABLE `oferta_requisitos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_oferta_lenguaje` (`oferta_id`,`lenguaje_id`),
  ADD KEY `lenguaje_id` (`lenguaje_id`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_usuarios_tipo` (`tipo_id`),
  ADD KEY `idx_usuarios_username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas_especializacion`
--
ALTER TABLE `areas_especializacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `conversaciones`
--
ALTER TABLE `conversaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `desarrollador_areas`
--
ALTER TABLE `desarrollador_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `desarrollador_lenguajes`
--
ALTER TABLE `desarrollador_lenguajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `lenguajes`
--
ALTER TABLE `lenguajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ofertas_trabajo`
--
ALTER TABLE `ofertas_trabajo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `oferta_requisitos`
--
ALTER TABLE `oferta_requisitos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `conversaciones`
--
ALTER TABLE `conversaciones`
  ADD CONSTRAINT `conversaciones_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas_trabajo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversaciones_ibfk_2` FOREIGN KEY (`usuario1_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversaciones_ibfk_3` FOREIGN KEY (`usuario2_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `desarrollador_areas`
--
ALTER TABLE `desarrollador_areas`
  ADD CONSTRAINT `desarrollador_areas_ibfk_1` FOREIGN KEY (`desarrollador_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `desarrollador_areas_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `areas_especializacion` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `desarrollador_lenguajes`
--
ALTER TABLE `desarrollador_lenguajes`
  ADD CONSTRAINT `desarrollador_lenguajes_ibfk_1` FOREIGN KEY (`desarrollador_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `desarrollador_lenguajes_ibfk_2` FOREIGN KEY (`lenguaje_id`) REFERENCES `lenguajes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`conversacion_id`) REFERENCES `conversaciones` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`remitente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ofertas_trabajo`
--
ALTER TABLE `ofertas_trabajo`
  ADD CONSTRAINT `ofertas_trabajo_ibfk_1` FOREIGN KEY (`empleador_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `oferta_requisitos`
--
ALTER TABLE `oferta_requisitos`
  ADD CONSTRAINT `oferta_requisitos_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas_trabajo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `oferta_requisitos_ibfk_2` FOREIGN KEY (`lenguaje_id`) REFERENCES `lenguajes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
