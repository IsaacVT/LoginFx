CREATE DATABASE  IF NOT EXISTS `tiendaflores` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tiendaflores`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: tiendaflores
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `idareas` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idareas`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Administrador'),(2,'Soporte Técnico'),(3,'Pagos'),(4,'Cuentas'),(5,'Logística');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo`
--

DROP TABLE IF EXISTS `catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo` (
  `id_tienda_fk` int NOT NULL,
  `id_producto_fk` int NOT NULL,
  PRIMARY KEY (`id_tienda_fk`,`id_producto_fk`),
  KEY `fk_products_idx` (`id_producto_fk`),
  CONSTRAINT `fk_products` FOREIGN KEY (`id_producto_fk`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `fk_stores` FOREIGN KEY (`id_tienda_fk`) REFERENCES `tiendas` (`id_tienda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo`
--

LOCK TABLES `catalogo` WRITE;
/*!40000 ALTER TABLE `catalogo` DISABLE KEYS */;
INSERT INTO `catalogo` VALUES (3,1),(5,1),(1,2),(2,2),(3,3),(5,3),(1,4),(3,5),(1,6),(6,6),(2,7),(4,7),(6,7),(4,8),(4,9),(6,9),(2,10),(5,10),(4,11),(5,12),(6,12);
/*!40000 ALTER TABLE `catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfdi`
--

DROP TABLE IF EXISTS `cfdi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cfdi` (
  `idcfdi` int NOT NULL AUTO_INCREMENT,
  `concepto` varchar(100) NOT NULL,
  PRIMARY KEY (`idcfdi`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfdi`
--

LOCK TABLES `cfdi` WRITE;
/*!40000 ALTER TABLE `cfdi` DISABLE KEYS */;
INSERT INTO `cfdi` VALUES (1,'Adquisición de mercancías'),(2,'Devoluciones, descuentos o bonificaciones'),(3,'Gastos en general'),(4,'Mobiliario y equipo de oficina por inversiones'),(5,'Por definir');
/*!40000 ALTER TABLE `cfdi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudad_pueblo_delegacion`
--

DROP TABLE IF EXISTS `ciudad_pueblo_delegacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudad_pueblo_delegacion` (
  `id_cpd` int NOT NULL AUTO_INCREMENT,
  `cpd_nombre` varchar(45) NOT NULL,
  `id_estado_fk` int NOT NULL,
  PRIMARY KEY (`id_cpd`),
  KEY `fk_id_state_idx` (`id_estado_fk`),
  CONSTRAINT `fk_id_state` FOREIGN KEY (`id_estado_fk`) REFERENCES `estados` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad_pueblo_delegacion`
--

LOCK TABLES `ciudad_pueblo_delegacion` WRITE;
/*!40000 ALTER TABLE `ciudad_pueblo_delegacion` DISABLE KEYS */;
INSERT INTO `ciudad_pueblo_delegacion` VALUES (1,'Benito Juarez',1),(2,'Del Valle Centro',1),(3,'Exprado coapa',1),(4,'	Ciudad Guzman',2),(5,'Puerto Vallarta',2),(6,'Villahermosa',3),(7,'Monterrey',4),(8,'Lazaro Cardenas',5),(9,'Villa del Carbon',6),(10,'Ojuelos de Jalisco',2),(11,'	San Pedro Garza Garcia',4),(12,'Metepec',6),(13,'Naucalpan de Juarez',6);
/*!40000 ALTER TABLE `ciudad_pueblo_delegacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `idcompras` int NOT NULL AUTO_INCREMENT,
  `id_usuario_fk` int NOT NULL,
  `id_ticket_fk` int NOT NULL,
  PRIMARY KEY (`idcompras`,`id_usuario_fk`,`id_ticket_fk`),
  KEY `cliente_fk_idx` (`id_usuario_fk`),
  KEY `fk_tickets_fk` (`id_ticket_fk`),
  CONSTRAINT `cliente_fk` FOREIGN KEY (`id_usuario_fk`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_tickets_fk` FOREIGN KEY (`id_ticket_fk`) REFERENCES `ticket` (`id_ticket`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,2,1),(2,2,2),(3,3,3),(4,3,4),(5,5,5),(6,5,6),(7,9,7),(8,9,8);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas` (
  `idcuenta` int NOT NULL AUTO_INCREMENT,
  `id_usuario_fk` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `pass_word` varchar(60) NOT NULL,
  PRIMARY KEY (`idcuenta`),
  KEY `fk_user_idx` (`id_usuario_fk`),
  CONSTRAINT `fk_user` FOREIGN KEY (`id_usuario_fk`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES (1,1,'merinoluisa@example.net','2d7tA1us5!'),(2,2,'ricardotovar@example.com','B#490jUq*('),(3,3,'aldo25@example.org','#$B_xjjS37'),(4,4,'elisafarias@example.org','G7)9Sr*iBd'),(5,5,'gerardoreyna@example.com','$_2vVRchW7'),(6,6,'rubenconcepcion@example.net','Tq54PzEnt^'),(7,7,'garicaoscar@example.org','8MFhbZIy)T'),(8,8,'perla18@example.net','QG@$B8ZuS9'),(9,9,'jassojuan@example.com','V7PlYNgs$&'),(10,10,'cristina96@example.org','%6YloeCaB(');
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `iddireccion` int NOT NULL AUTO_INCREMENT,
  `calle` varchar(45) NOT NULL,
  `numero` varchar(45) NOT NULL,
  `codigo_postal` varchar(5) NOT NULL,
  `id_cpd_fk` int NOT NULL,
  PRIMARY KEY (`iddireccion`),
  KEY `fk_id_city_town_idx` (`id_cpd_fk`),
  CONSTRAINT `fk_id_city_town` FOREIGN KEY (`id_cpd_fk`) REFERENCES `ciudad_pueblo_delegacion` (`id_cpd`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
INSERT INTO `direccion` VALUES (1,'Insurgentes Sur','822','03100',2),(2,'Circuito Interior','229','03800',1),(3,'Av Filadelfia','24','03810',1),(4,'Calz. del Hueso','160','04980',3),(5,'Portal Hidalgo','12','47540',10),(6,'Amapas','214','48262',5),(7,'Federico del toro','278','49000',4),(8,'Av. Leona Vicario','24','52169',12),(9,'Sor Juana Ines de la Cruz','14','53240',13),(10,'México','5','54300',9),(11,'Av. 5 de Febrero','1007','60950',8),(12,'Padre Mier','1094','64000',7),(13,'Av. Revolución','3985','64850',7),(14,'Av. Roble','660','66265',11),(15,'Jose Maria Pino Suarez','217','86000',6),(16,'Av. 5 de Febrero','260','48262',5);
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_envio`
--

DROP TABLE IF EXISTS `estado_envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_envio` (
  `id_estado_envio` int NOT NULL AUTO_INCREMENT,
  `estado_envio` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estado_envio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_envio`
--

LOCK TABLES `estado_envio` WRITE;
/*!40000 ALTER TABLE `estado_envio` DISABLE KEYS */;
INSERT INTO `estado_envio` VALUES (1,'Entregado'),(2,'En camino'),(3,'Pendiente'),(4,'Cancelado');
/*!40000 ALTER TABLE `estado_envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_pago`
--

DROP TABLE IF EXISTS `estado_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_pago` (
  `id_edo_pago` int NOT NULL AUTO_INCREMENT,
  `edo_pago` varchar(45) NOT NULL,
  PRIMARY KEY (`id_edo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_pago`
--

LOCK TABLES `estado_pago` WRITE;
/*!40000 ALTER TABLE `estado_pago` DISABLE KEYS */;
INSERT INTO `estado_pago` VALUES (1,'En proceso'),(2,'Cancelado'),(3,'Error'),(4,'Realizado');
/*!40000 ALTER TABLE `estado_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `nombre_edo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'CDMX'),(2,'Jalisco'),(3,'Tabasco'),(4,'Nuevo León'),(5,'Michoacan'),(6,'Estado de México');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturacion`
--

DROP TABLE IF EXISTS `facturacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturacion` (
  `idfactura` int NOT NULL AUTO_INCREMENT,
  `rfc` varchar(20) NOT NULL,
  `id_dir_fiscal` int NOT NULL,
  `id_compra_fk` int NOT NULL,
  `id_cfdi` int NOT NULL,
  PRIMARY KEY (`idfactura`),
  KEY `fk_dir_fiscal_idx` (`id_dir_fiscal`),
  KEY `fk_compra_idx` (`id_compra_fk`),
  KEY `fk_cfdi_idx` (`id_cfdi`),
  CONSTRAINT `fk_cfdi` FOREIGN KEY (`id_cfdi`) REFERENCES `cfdi` (`idcfdi`),
  CONSTRAINT `fk_compra` FOREIGN KEY (`id_compra_fk`) REFERENCES `compras` (`idcompras`),
  CONSTRAINT `fk_dir_fiscal` FOREIGN KEY (`id_dir_fiscal`) REFERENCES `direccion` (`iddireccion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturacion`
--

LOCK TABLES `facturacion` WRITE;
/*!40000 ALTER TABLE `facturacion` DISABLE KEYS */;
INSERT INTO `facturacion` VALUES (1,'RACJ920101NVA',2,1,1),(2,'MAML930808GS6',1,4,4),(3,'CAAH960807TD3',6,5,5),(4,'ROZN9405222D2',11,8,3);
/*!40000 ALTER TABLE `facturacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `id_facturacion_fk` int NOT NULL,
  `id_usuario_fk` int NOT NULL,
  PRIMARY KEY (`id_facturacion_fk`,`id_usuario_fk`),
  KEY `fk_fact_user_idx` (`id_usuario_fk`),
  CONSTRAINT `fk_fact_user` FOREIGN KEY (`id_usuario_fk`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_factura` FOREIGN KEY (`id_facturacion_fk`) REFERENCES `facturacion` (`idfactura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,2),(2,3),(3,5),(4,9);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_deseados`
--

DROP TABLE IF EXISTS `lista_deseados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista_deseados` (
  `id_usuario` int NOT NULL,
  `id_producto` int NOT NULL,
  KEY `info_prod_idx` (`id_producto`),
  KEY `inf_client_idx` (`id_usuario`),
  CONSTRAINT `inf_client` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `prod` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_deseados`
--

LOCK TABLES `lista_deseados` WRITE;
/*!40000 ALTER TABLE `lista_deseados` DISABLE KEYS */;
INSERT INTO `lista_deseados` VALUES (2,3),(2,8),(2,12),(3,2),(5,4),(5,9),(5,10),(9,5),(9,7);
/*!40000 ALTER TABLE `lista_deseados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pago` (
  `id_metodo` int NOT NULL AUTO_INCREMENT,
  `tipo_metodo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_metodo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pago`
--

LOCK TABLES `metodos_pago` WRITE;
/*!40000 ALTER TABLE `metodos_pago` DISABLE KEYS */;
INSERT INTO `metodos_pago` VALUES (1,'Paypal'),(2,'Tarjeta de Credito'),(3,'Tarjeta de Debito');
/*!40000 ALTER TABLE `metodos_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `tipo_producto` varchar(45) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `stock` int NOT NULL,
  `costo` float NOT NULL,
  `costo_envio` float NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Ramo','Doble Orquidea Blanca',15,729,85.95,'Dos orquídeas grandes, dos sujetadores para mantenerlas en pie, planta base decorativa, maceta color blanco'),(2,'Ramo','Doble Orquidea Morada',20,659,85.95,'Orquídea doble color morado, planta decorativa, maceta color blanco'),(3,'Ramo','Rosas Rojas',10,839,59.99,'40 rosas rojas acomodadas en un lindo florero'),(4,'Ramo','Día soleado',12,549,55.49,'Para crear este arreglo floral se eligen 66 preciosas margaritas amarillas tomando especial atención en su color'),(5,'Ramo','Burbuja blanca',5,749,64.99,'Areglo floral conformado de 10 gerberas, 10 claveles y 10 margaritas'),(6,'Ramo','Fantasía en rosa',13,879,62.49,'Este maravilloso conjunto de 48 perfectos y sedosos lirios en tono rosado impresionará y robará todas las miradas'),(7,'Canasta','Premium Mezclada',3,949,54.99,'Esta canasta de flores naturales será el detalle perfecto para sorprender a tus seres queridos'),(8,'Canasta','Mezcla Perfecta con Osito',11,969,39.99,'Simplemente la mezcla perfecta'),(9,'Canasta','Rosas Amarillas y Claveles',8,749,49.99,'Sea para un cumpleaños, aniversario o solo porque sí, alegrará el día de quien sea'),(10,'Canasta','Gerberas de Otoño',17,839,49.99,'Perfecta combinación de colores tipicos de otoño'),(11,'Kit','Spa in box',13,929,39.49,'Vaso personalizado, banda para el pelo, toallitas desmaquillantes y más'),(12,'Set','Crema De Mezcal Chocomenta',2,1059,59.99,'Crema Mezcal de 500 ml. elaborada con frutos y miel de agave, producido en el Estado de Oaxaca y más');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soporte_tecnico`
--

DROP TABLE IF EXISTS `soporte_tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soporte_tecnico` (
  `id_administrador_fk` int NOT NULL,
  `id_ticket_fk` int NOT NULL,
  `id_area_fk` int NOT NULL,
  PRIMARY KEY (`id_administrador_fk`,`id_ticket_fk`,`id_area_fk`),
  KEY `info_ticket_idx` (`id_ticket_fk`),
  KEY `info_area_fk_idx` (`id_area_fk`),
  CONSTRAINT `info_area_fk` FOREIGN KEY (`id_area_fk`) REFERENCES `areas` (`idareas`),
  CONSTRAINT `info_ticket` FOREIGN KEY (`id_ticket_fk`) REFERENCES `ticket_soporte` (`id_ticket_soporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soporte_tecnico`
--

LOCK TABLES `soporte_tecnico` WRITE;
/*!40000 ALTER TABLE `soporte_tecnico` DISABLE KEYS */;
INSERT INTO `soporte_tecnico` VALUES (5,1,4),(3,2,3);
/*!40000 ALTER TABLE `soporte_tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id_ticket` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_compra` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `detalles_direccion` text NOT NULL,
  `id_metodo_pago_fk` int NOT NULL,
  `id_estado_pago_fk` int NOT NULL,
  `id_estado_envio_fk` int NOT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `info_product_idx` (`id_producto`),
  KEY `paymethod_idx` (`id_metodo_pago_fk`),
  KEY `paystatus_idx` (`id_estado_pago_fk`),
  KEY `info_send_idx` (`id_estado_envio_fk`) /*!80000 INVISIBLE */,
  CONSTRAINT `details_send` FOREIGN KEY (`id_estado_envio_fk`) REFERENCES `estado_envio` (`id_estado_envio`),
  CONSTRAINT `info_product` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `paymethod` FOREIGN KEY (`id_metodo_pago_fk`) REFERENCES `metodos_pago` (`id_metodo`),
  CONSTRAINT `paystatus` FOREIGN KEY (`id_estado_pago_fk`) REFERENCES `estado_pago` (`id_edo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,4,1,'2022-08-12','2022-08-17','Porton grande de madera color café',1,4,1),(2,6,4,'2022-09-28','2022-10-05','Porton grande de madera color café',2,4,1),(3,1,2,'2022-09-29','2022-10-06','Dejarlo con el portero',3,2,2),(4,10,1,'2022-10-08','2022-10-13','Dejarlo con el portero',3,4,1),(5,12,1,'2022-10-25','2022-10-30','Entrada por las cruces',1,4,1),(6,2,2,'2022-11-01','2022-11-06','Entrada por las cruces',1,4,1),(7,5,2,'2022-11-15','2022-11-20','Entrada por los arcos',2,1,3),(8,6,3,'2022-11-16','2022-11-21','Entrada por los arcos',2,3,3);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_sop_categoria`
--

DROP TABLE IF EXISTS `ticket_sop_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_sop_categoria` (
  `id_ticket_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_cat` varchar(45) NOT NULL,
  PRIMARY KEY (`id_ticket_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_sop_categoria`
--

LOCK TABLES `ticket_sop_categoria` WRITE;
/*!40000 ALTER TABLE `ticket_sop_categoria` DISABLE KEYS */;
INSERT INTO `ticket_sop_categoria` VALUES (1,'Cuenta'),(2,'Pagos'),(3,'Producto'),(4,'Otros');
/*!40000 ALTER TABLE `ticket_sop_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_sop_estado`
--

DROP TABLE IF EXISTS `ticket_sop_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_sop_estado` (
  `id_ticket_estado` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`id_ticket_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_sop_estado`
--

LOCK TABLES `ticket_sop_estado` WRITE;
/*!40000 ALTER TABLE `ticket_sop_estado` DISABLE KEYS */;
INSERT INTO `ticket_sop_estado` VALUES (1,'Nuevo'),(2,'Asignado'),(3,'En proceso'),(4,'Pendiente'),(5,'Resuelto');
/*!40000 ALTER TABLE `ticket_sop_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_sop_nivel`
--

DROP TABLE IF EXISTS `ticket_sop_nivel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_sop_nivel` (
  `id_nivel_ticket` int NOT NULL AUTO_INCREMENT,
  `nivel` varchar(45) NOT NULL,
  PRIMARY KEY (`id_nivel_ticket`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_sop_nivel`
--

LOCK TABLES `ticket_sop_nivel` WRITE;
/*!40000 ALTER TABLE `ticket_sop_nivel` DISABLE KEYS */;
INSERT INTO `ticket_sop_nivel` VALUES (1,'Critico'),(2,'Importante'),(3,'Moderado');
/*!40000 ALTER TABLE `ticket_sop_nivel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_soporte`
--

DROP TABLE IF EXISTS `ticket_soporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_soporte` (
  `id_ticket_soporte` int NOT NULL AUTO_INCREMENT,
  `id_usuario_fk` int NOT NULL,
  `id_categoria_fk` int NOT NULL,
  `descripcion` text NOT NULL,
  `id_ticket_estado_fk` int NOT NULL,
  `id_nivel_fk` int NOT NULL,
  PRIMARY KEY (`id_ticket_soporte`),
  KEY `fk_support_ticket_user1_idx` (`id_usuario_fk`),
  KEY `cat_ticket_idx` (`id_categoria_fk`),
  KEY `status_ticket_idx` (`id_ticket_estado_fk`),
  KEY `level_ticket_idx` (`id_nivel_fk`),
  CONSTRAINT `cat_ticket` FOREIGN KEY (`id_categoria_fk`) REFERENCES `ticket_sop_categoria` (`id_ticket_categoria`),
  CONSTRAINT `data_user` FOREIGN KEY (`id_usuario_fk`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `level_ticket` FOREIGN KEY (`id_nivel_fk`) REFERENCES `ticket_sop_nivel` (`id_nivel_ticket`),
  CONSTRAINT `status_ticket` FOREIGN KEY (`id_ticket_estado_fk`) REFERENCES `ticket_sop_estado` (`id_ticket_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_soporte`
--

LOCK TABLES `ticket_soporte` WRITE;
/*!40000 ALTER TABLE `ticket_soporte` DISABLE KEYS */;
INSERT INTO `ticket_soporte` VALUES (1,6,1,'No puedo acceder a mi cuenta',3,3),(2,9,2,'Mi pago no se procesa',1,2);
/*!40000 ALTER TABLE `ticket_soporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `tickets_compra`
--

DROP TABLE IF EXISTS `tickets_compra`;
/*!50001 DROP VIEW IF EXISTS `tickets_compra`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tickets_compra` AS SELECT 
 1 AS `id_ticket`,
 1 AS `nombre`,
 1 AS `producto`,
 1 AS `cantidad`,
 1 AS `a_pagar`,
 1 AS `fecha_compra`,
 1 AS `fecha_entrega`,
 1 AS `direccion_envio`,
 1 AS `detalles_direccion`,
 1 AS `tipo_metodo`,
 1 AS `edo_pago`,
 1 AS `estado_envio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tickets_soporte`
--

DROP TABLE IF EXISTS `tickets_soporte`;
/*!50001 DROP VIEW IF EXISTS `tickets_soporte`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tickets_soporte` AS SELECT 
 1 AS `admin_asigando`,
 1 AS `num_ticket`,
 1 AS `nombre_usuario`,
 1 AS `categoria`,
 1 AS `descripcion`,
 1 AS `estado`,
 1 AS `prioridad`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tiendas`
--

DROP TABLE IF EXISTS `tiendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiendas` (
  `id_tienda` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_dir` int NOT NULL,
  PRIMARY KEY (`id_tienda`),
  KEY `fk_direccion_idx` (`id_dir`),
  CONSTRAINT `fk_direccion` FOREIGN KEY (`id_dir`) REFERENCES `direccion` (`iddireccion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiendas`
--

LOCK TABLES `tiendas` WRITE;
/*!40000 ALTER TABLE `tiendas` DISABLE KEYS */;
INSERT INTO `tiendas` VALUES (1,'Reloj de Sol',5),(2,'Capital Flores',16),(3,'Reino de las Flores',14),(4,'Maxima Flores',13),(5,'Horizonte de las Flores',8),(6,'Reino Floral',9);
/*!40000 ALTER TABLE `tiendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `idtipo_usuario` int NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'Administrador'),(2,'Cliente');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre1` varchar(45) NOT NULL,
  `nombre2` varchar(45) DEFAULT NULL,
  `paterno` varchar(45) NOT NULL,
  `materno` varchar(45) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `num_celular` varchar(12) NOT NULL,
  `id_direccion` int NOT NULL,
  `id_tipo` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `direccion_fk_idx` (`id_direccion`),
  KEY `tipo_usuario_fk_idx` (`id_tipo`),
  CONSTRAINT `direccion_fk` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`iddireccion`),
  CONSTRAINT `tipo_usuario_fk` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_usuario` (`idtipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Alfredo ','Luis','Manuel','Almanza','1990-07-26','5553857325',3,1),(2,'Jónas','','Ramiro','Carbajal','1992-01-01','5577696336',2,2),(3,'Leticia','','Mariano','Montemayor','1993-08-08','5556870790',1,2),(4,'Anabel','','Helena','Abrego','1998-02-14','5556778939',4,1),(5,'Humberto',NULL,'Castro','Almanza','1996-08-07','3241412679',6,2),(6,'Eloy',NULL,'Micaela','Armas','1996-06-11','3222220912',7,1),(7,'Minerva','Mauricio','Miranda','Badillo','1990-09-21','9933127621',15,2),(8,'Ana',NULL,'Eloy','Benitez','1999-08-04','8183430070',12,1),(9,'Noemi',NULL,'Romero','Zambrano','1994-05-22','7535377275',11,2),(10,'Patricio','Benjamín','Oquendo','Trujillo','1986-11-24','5539105227',10,2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_catalogo`
--

DROP TABLE IF EXISTS `vista_catalogo`;
/*!50001 DROP VIEW IF EXISTS `vista_catalogo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_catalogo` AS SELECT 
 1 AS `id_producto`,
 1 AS `tipo_producto`,
 1 AS `nombre`,
 1 AS `stock`,
 1 AS `costo`,
 1 AS `costo_envio`,
 1 AS `descripcion`,
 1 AS `vendido_por`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_facturas`
--

DROP TABLE IF EXISTS `vista_facturas`;
/*!50001 DROP VIEW IF EXISTS `vista_facturas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_facturas` AS SELECT 
 1 AS `nombre`,
 1 AS `rfc`,
 1 AS `direccion_fiscal`,
 1 AS `concepto`,
 1 AS `compra`,
 1 AS `cantidad`,
 1 AS `pago`,
 1 AS `fecha_compra`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'tiendaflores'
--

--
-- Dumping routines for database 'tiendaflores'
--
/*!50003 DROP FUNCTION IF EXISTS `nombre_completo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nombre_completo`(iduser INT) RETURNS varchar(200) CHARSET utf8mb3
    COMMENT 'Función que devuelve la concatenación del nombre completo del usuario'
BEGIN
DECLARE nombre VARCHAR(200);
	SELECT CONCAT(nombre1, COALESCE(CONCAT(' ', nombre2), '') , ' ', paterno, ' ', materno) INTO nombre
	FROM usuario
	WHERE id_usuario = iduser;
RETURN nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `show_dir` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `show_dir`(iddir INT) RETURNS varchar(200) CHARSET utf8mb3
    COMMENT 'Función que devuelve la concatenación de todos los datos de una dirección'
BEGIN
DECLARE direccion VARCHAR(200);
	SELECT CONCAT( t1.calle, " #", t1.numero, ", ", t1.codigo_postal, ", ", t2.cpd_nombre, ', ', t3.nombre_edo ) INTO direccion
	FROM direccion AS t1
	INNER JOIN ciudad_pueblo_delegacion AS t2 ON t1.id_cpd_fk = t2.id_cpd
	INNER JOIN estados AS t3 ON t2.id_estado_fk = t3.id_estado
	WHERE iddireccion = iddir;
RETURN direccion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscador_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscador_usuario`(dato VARCHAR(100))
    COMMENT 'Proceso que busca los datos de un usuario mediante un dato en especifico'
BEGIN
	SELECT t1.id_usuario, t1.nombre1, t1.nombre2, t1.paterno, t1.materno, t1.fecha_nacimiento, t1.num_celular, t2.email, t2.pass_word
    FROM usuario AS t1
    INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
    WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR 
    t1.nombre2 LIKE CONCAT ('%', dato, '%') OR 
    t1.paterno LIKE CONCAT ('%', dato, '%') OR 
    t1.materno LIKE CONCAT ('%', dato, '%') OR 
    t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR 
    t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
    t2.email LIKE CONCAT ('%', dato, '%') OR 
    t2.pass_word LIKE CONCAT ('%', dato, '%'));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `datos_tipo_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `datos_tipo_usuario`(tipo INT)
    COMMENT 'Proceso que muestra los datos de administradores o clientes'
BEGIN
	IF tipo > 0 THEN
		SELECT t1.id_usuario, nombre_completo(t1.id_usuario) AS nombre, (YEAR(curdate()) - YEAR(t1.fecha_nacimiento)) AS edad, t1.num_celular, show_dir(t1.id_direccion) AS direccion, t2.tipo_usuario
		FROM usuario AS t1
		INNER JOIN tipo_usuario AS t2 ON t1.id_tipo = t2.idtipo_usuario
        WHERE t1.id_tipo = tipo 
        ORDER BY id_usuario ASC;
    ELSE 
		SELECT t1.id_usuario, nombre_completo(t1.id_usuario) AS nombre, (YEAR(curdate()) - YEAR(t1.fecha_nacimiento)) AS edad, t1.num_celular, show_dir(t1.id_direccion) AS direccion, t2.tipo_usuario
		FROM usuario AS t1
		INNER JOIN tipo_usuario AS t2 ON t1.id_tipo = t2.idtipo_usuario
        ORDER BY id_usuario ASC;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ganancias_generales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ganancias_generales`()
    COMMENT 'Proceso que calcula entradas y salidas generales'
BEGIN
	SELECT
    (SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE edo_pago = "Realizado" AND estado_envio = "Entregado") AS ganancias,
	(SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE (edo_pago = "En proceso" OR edo_pago = "Error") AND estado_envio = "Pendiente") AS pendientes,
	(SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE edo_pago = "Cancelado") AS perdidas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ganancias_mes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ganancias_mes`(mes INT)
    COMMENT 'Proceso que calcula entradas y salidas de un mes en especifico'
BEGIN
	SELECT monthname(STR_TO_DATE(mes, '%m')) AS mes,
    (SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND edo_pago = "Realizado" AND estado_envio = "Entregado") AS ganancias,
	(SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND (edo_pago = "En proceso" OR edo_pago = "Error") AND estado_envio = "Pendiente") AS pendientes,
	(SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND edo_pago = "Cancelado") AS perdidas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tabla_usuario_busqueda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_usuario_busqueda`(IN dato VARCHAR(50))
    COMMENT 'Procedimiento que crea una tabla y traslada los datos encontrados mediante busqueda a dicha tabla'
BEGIN
	 DECLARE done INT DEFAULT FALSE;
	 DECLARE v1, id INT DEFAULT 0;
	 
	 DECLARE nom1, nom2, pa, ma, num, email, pass VARCHAR(100);
     DECLARE nacimiento date;
	 
	 DECLARE cur1 CURSOR FOR 
		SELECT t1.id_usuario, t1.nombre1, t1.nombre2, t1.paterno, t1.materno, t1.fecha_nacimiento, t1.num_celular, t2.email, t2.pass_word
		FROM usuario AS t1 INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
		WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR t1.nombre2 LIKE CONCAT ('%', dato, '%') OR t1.paterno LIKE CONCAT ('%', dato, '%') OR 
		t1.materno LIKE CONCAT ('%', dato, '%') OR t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
		t2.email LIKE CONCAT ('%', dato, '%') OR t2.pass_word LIKE CONCAT ('%', dato, '%'));
	 
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		SELECT COUNT(t1.id_usuario) INTO v1 
        FROM usuario AS t1 INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
		WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR t1.nombre2 LIKE CONCAT ('%', dato, '%') OR t1.paterno LIKE CONCAT ('%', dato, '%') OR 
		t1.materno LIKE CONCAT ('%', dato, '%') OR t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
		t2.email LIKE CONCAT ('%', dato, '%') OR t2.pass_word LIKE CONCAT ('%', dato, '%'));
        
		IF v1 > 0 THEN
			DROP TABLE IF EXISTS busqueda;
			CREATE TABLE busqueda (iddato INT, nombre1 VARCHAR (50), nombre2 VARCHAR (50), paterno VARCHAR (50), materno VARCHAR (50), fecha DATE, celular VARCHAR (12), email VARCHAR (100), contra VARCHAR (100));

			OPEN cur1;		 
			read_loop: LOOP

				FETCH cur1 INTO id, nom1, nom2, pa, ma, nacimiento, num, email, pass;                

				IF done THEN 
					LEAVE read_loop;
				END IF;

                INSERT INTO busqueda (iddato, nombre1, nombre2, paterno, materno, fecha, celular, email, contra) 
				VALUES (id, nom1, nom2, pa, ma, nacimiento, num, email, pass);
			end loop;

			CLOSE cur1;
		END IF;
	
    SELECT * FROM busqueda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `tickets_compra`
--

/*!50001 DROP VIEW IF EXISTS `tickets_compra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tickets_compra` AS select `t2`.`id_ticket` AS `id_ticket`,`nombre_completo`(`t1`.`id_usuario_fk`) AS `nombre`,concat(`t3`.`nombre`,': ',`t3`.`descripcion`) AS `producto`,`t2`.`cantidad` AS `cantidad`,round((`t2`.`cantidad` * sum((`t3`.`costo` + `t3`.`costo_envio`))),2) AS `a_pagar`,`t2`.`fecha_compra` AS `fecha_compra`,`t2`.`fecha_entrega` AS `fecha_entrega`,`show_dir`(`t4`.`id_direccion`) AS `direccion_envio`,`t2`.`detalles_direccion` AS `detalles_direccion`,`t5`.`tipo_metodo` AS `tipo_metodo`,`t6`.`edo_pago` AS `edo_pago`,`t7`.`estado_envio` AS `estado_envio` from ((((((`compras` `t1` join `ticket` `t2` on((`t1`.`id_ticket_fk` = `t2`.`id_ticket`))) join `productos` `t3` on((`t2`.`id_producto` = `t3`.`id_producto`))) join `usuario` `t4` on((`t1`.`id_usuario_fk` = `t4`.`id_usuario`))) join `metodos_pago` `t5` on((`t2`.`id_metodo_pago_fk` = `t5`.`id_metodo`))) join `estado_pago` `t6` on((`t2`.`id_estado_pago_fk` = `t6`.`id_edo_pago`))) join `estado_envio` `t7` on((`t2`.`id_estado_envio_fk` = `t7`.`id_estado_envio`))) group by `t1`.`idcompras` order by `t1`.`idcompras` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tickets_soporte`
--

/*!50001 DROP VIEW IF EXISTS `tickets_soporte`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tickets_soporte` AS select concat(`t7`.`nombre1`,' en el área de ',`t6`.`nombre`) AS `admin_asigando`,`t2`.`id_ticket_soporte` AS `num_ticket`,`nombre_completo`(`t2`.`id_usuario_fk`) AS `nombre_usuario`,`t3`.`nombre_cat` AS `categoria`,`t2`.`descripcion` AS `descripcion`,`t4`.`estado` AS `estado`,`t5`.`nivel` AS `prioridad` from ((((((`soporte_tecnico` `t1` join `ticket_soporte` `t2` on((`t1`.`id_ticket_fk` = `t2`.`id_ticket_soporte`))) join `ticket_sop_categoria` `t3` on((`t2`.`id_categoria_fk` = `t3`.`id_ticket_categoria`))) join `ticket_sop_estado` `t4` on((`t2`.`id_ticket_estado_fk` = `t4`.`id_ticket_estado`))) join `ticket_sop_nivel` `t5` on((`t2`.`id_nivel_fk` = `t5`.`id_nivel_ticket`))) join `areas` `t6` on((`t1`.`id_area_fk` = `t6`.`idareas`))) join `usuario` `t7` on((`t1`.`id_administrador_fk` = `t7`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_catalogo`
--

/*!50001 DROP VIEW IF EXISTS `vista_catalogo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_catalogo` AS select `t3`.`id_producto` AS `id_producto`,`t3`.`tipo_producto` AS `tipo_producto`,`t3`.`nombre` AS `nombre`,`t3`.`stock` AS `stock`,`t3`.`costo` AS `costo`,`t3`.`costo_envio` AS `costo_envio`,`t3`.`descripcion` AS `descripcion`,`t2`.`nombre` AS `vendido_por` from ((`catalogo` `t1` join `tiendas` `t2` on((`t1`.`id_tienda_fk` = `t2`.`id_tienda`))) join `productos` `t3` on((`t1`.`id_producto_fk` = `t3`.`id_producto`))) group by `t3`.`id_producto` order by `t3`.`id_producto` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_facturas`
--

/*!50001 DROP VIEW IF EXISTS `vista_facturas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_facturas` AS select `nombre_completo`(`t1`.`id_usuario_fk`) AS `nombre`,`t2`.`rfc` AS `rfc`,`show_dir`(`t2`.`id_dir_fiscal`) AS `direccion_fiscal`,`t3`.`concepto` AS `concepto`,(select `tickets_compra`.`producto` from `tickets_compra` where (`tickets_compra`.`id_ticket` = `t4`.`id_ticket_fk`)) AS `compra`,(select `tickets_compra`.`cantidad` from `tickets_compra` where (`tickets_compra`.`id_ticket` = `t4`.`id_ticket_fk`)) AS `cantidad`,(select `tickets_compra`.`a_pagar` from `tickets_compra` where (`tickets_compra`.`id_ticket` = `t4`.`id_ticket_fk`)) AS `pago`,(select `tickets_compra`.`fecha_compra` from `tickets_compra` where (`tickets_compra`.`id_ticket` = `t4`.`id_ticket_fk`)) AS `fecha_compra` from (((`facturas` `t1` join `facturacion` `t2` on((`t1`.`id_facturacion_fk` = `t2`.`idfactura`))) join `cfdi` `t3` on((`t2`.`id_cfdi` = `t3`.`idcfdi`))) join `compras` `t4` on((`t2`.`id_compra_fk` = `t4`.`idcompras`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-02 17:33:54
