-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: dashboard
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `codigo` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `nombre` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `brokers` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `fc_inicio` int NOT NULL,
  `fc_final` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `id_estado` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (1,1,'VENTA2025','Campaña Ventas Q1 2025','Campaña de ventas primer trimestre','_1__2__3_',20250101,20250331),(2,1,'RETEN2025','Retención Clientes','Campaña de retención de clientes existentes','_2__4__5_',20250101,20250630),(3,1,'CROSS2025','Cross Selling','Venta cruzada de productos adicionales','_1__3__5_',20250201,20250430),(4,2,'COBRA2025','Cobranzas','Gestión de cobranzas morosas','_4__5_',20250101,20251231),(5,1,'ENCUES25','Encuestas Satisfacción','Encuestas de satisfacción post-venta','_1__2__3__4_',20250115,20250315);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns_estados`
--

DROP TABLE IF EXISTS `campaigns_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_estados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns_estados`
--

LOCK TABLES `campaigns_estados` WRITE;
/*!40000 ALTER TABLE `campaigns_estados` DISABLE KEYS */;
INSERT INTO `campaigns_estados` VALUES (1,'Activa','Campaña en ejecución'),(2,'Pausada','Campaña temporalmente suspendida'),(3,'Finalizada','Campaña completada'),(4,'Planificada','Campaña programada para el futuro');
/*!40000 ALTER TABLE `campaigns_estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_estado` int NOT NULL,
  `id_domicilio` int unsigned NOT NULL,
  `id_ocupacion` int NOT NULL,
  `id_estado_civil` int NOT NULL,
  `ci` bigint NOT NULL,
  `nombre1` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `nombre2` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido1` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido2` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `fc_nacimiento` int NOT NULL,
  `sexo` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `zurdo` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `id_tel_fijo1` int NOT NULL,
  `id_tel_fijo2` int NOT NULL,
  `id_tel_movil1` int NOT NULL,
  `id_tel_movil2` int NOT NULL,
  `email` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `id_userinsert` int NOT NULL,
  `id_fuente_dato` int NOT NULL,
  `se_queda` int NOT NULL,
  `timestamp` bigint NOT NULL,
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mascota` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_tel_fijo1` (`id_tel_fijo1`),
  KEY `id_estado` (`id_estado`),
  KEY `id_domicilio` (`id_domicilio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES (1,1,1,1,1,11111111,'Roberto','Carlos','Silva','Mendoza',19850315,'M','N',1,13,2,11,'roberto.silva@email.com',1,1,0,20250101120000,'2025-09-25 01:32:59',1),(2,2,2,2,2,22222222,'Laura','Isabel','Fernández','Castro',19920708,'F','N',3,14,4,12,'laura.fernandez@email.com',2,1,1,20250102130000,'2025-09-25 01:32:59',0),(3,1,3,3,1,33333333,'Miguel','Ángel','Torres','Vega',19880422,'M','S',5,17,6,15,'miguel.torres@email.com',1,2,0,20250103140000,'2025-09-25 01:32:59',1),(4,1,4,1,3,44444444,'Carmen','Rosa','Jiménez','Morales',19750912,'F','N',7,18,8,16,'carmen.jimenez@email.com',3,1,0,20250104150000,'2025-09-25 01:32:59',0),(5,3,5,4,1,55555555,'Andrés','Felipe','Vargas','Ruiz',19901203,'M','N',9,0,10,19,'andres.vargas@email.com',2,3,1,20250105160000,'2025-09-25 01:32:59',1),(6,1,6,2,2,66666666,'Patricia','Elena','Herrera','Díaz',19860825,'F','N',0,1,20,2,'patricia.herrera@email.com',4,1,0,20250106170000,'2025-09-25 01:32:59',0),(7,2,7,5,1,77777777,'Francisco','Javier','Ramírez','Cruz',19820617,'M','S',3,5,4,6,'francisco.ramirez@email.com',1,2,1,20250107180000,'2025-09-25 01:32:59',1),(8,1,8,1,4,88888888,'Beatriz','Alejandra','Guerrero','Peña',19940210,'F','N',7,9,8,10,'beatriz.guerrero@email.com',5,1,0,20250108190000,'2025-09-25 01:32:59',0),(9,1,9,3,1,99999999,'Jorge','Luis','Mendoza','Flores',19870530,'M','N',13,17,11,15,'jorge.mendoza@email.com',3,2,0,20250109200000,'2025-09-25 01:32:59',1),(10,5,10,2,2,10101010,'Valentina','Sofía','Ortega','Restrepo',19910914,'F','N',14,18,12,16,'valentina.ortega@email.com',2,1,1,20250110210000,'2025-09-25 01:32:59',0);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos_estado`
--

DROP TABLE IF EXISTS `contactos_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactos_estado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos_estado`
--

LOCK TABLES `contactos_estado` WRITE;
/*!40000 ALTER TABLE `contactos_estado` DISABLE KEYS */;
INSERT INTO `contactos_estado` VALUES (1,'Prospecto'),(2,'Cliente'),(3,'Rechazado'),(4,'No contactar'),(5,'Seguimiento');
/*!40000 ALTER TABLE `contactos_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestiones`
--

DROP TABLE IF EXISTS `gestiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestiones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipo` int NOT NULL,
  `id_campaign` int NOT NULL,
  `id_broker` int NOT NULL,
  `id_contacto` int NOT NULL,
  `id_resultado` int NOT NULL,
  `notas` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `timestamp` char(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `id_tel_fijo1` int NOT NULL,
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_contacto` (`id_contacto`),
  KEY `id_tipo` (`id_tipo`),
  KEY `id_campaign` (`id_campaign`),
  KEY `id_broker` (`id_broker`),
  KEY `id_resultado` (`id_resultado`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestiones`
--

LOCK TABLES `gestiones` WRITE;
/*!40000 ALTER TABLE `gestiones` DISABLE KEYS */;
INSERT INTO `gestiones` VALUES (1,1,1,1,1,3,'Primera llamada, no contesta','20250115080000',1,'2025-09-25 00:49:23'),(2,1,1,1,1,2,'Contactado, muestra interés','20250116090000',1,'2025-09-25 00:49:23'),(3,1,1,1,1,1,'Coordinada visita para el jueves','20250117100000',1,'2025-09-25 00:49:23'),(4,1,1,2,1,8,'Reagendado para la próxima semana','20250118110000',2,'2025-09-25 00:49:23'),(5,1,1,2,1,1,'Venta cerrada exitosamente','20250119120000',2,'2025-09-25 00:49:23'),(6,1,2,3,2,2,'Cliente actual, consulta sobre renovación','20250115130000',3,'2025-09-25 00:49:23'),(7,1,2,3,2,1,'Acepta renovación, coordinado pago','20250116140000',3,'2025-09-25 00:49:23'),(8,1,2,4,2,11,'Pendiente documentación','20250117150000',4,'2025-09-25 00:49:23'),(9,1,2,4,2,1,'Documentación completa, proceso finalizado','20250118160000',4,'2025-09-25 00:49:23'),(10,1,3,5,3,4,'Línea ocupada','20250115170000',5,'2025-09-25 00:49:23'),(11,1,3,5,3,3,'No contesta segunda llamada','20250116180000',5,'2025-09-25 00:49:23'),(12,1,3,1,3,2,'Contactado, interesado en producto','20250117190000',6,'2025-09-25 00:49:23'),(13,1,3,1,3,8,'Agendado para presentación','20250118200000',6,'2025-09-25 00:49:23'),(14,1,3,2,3,1,'Presentación realizada, coordinado','20250119210000',6,'2025-09-25 00:49:23'),(15,1,1,3,4,7,'No está interesada en el momento','20250115220000',7,'2025-09-25 00:49:23'),(16,1,1,3,4,10,'Solicita llamar en 2 semanas','20250130080000',7,'2025-09-25 00:49:23'),(17,1,1,4,4,2,'Segunda oportunidad, muestra interés','20250201090000',8,'2025-09-25 00:49:23'),(18,1,1,4,4,1,'Acepta propuesta, coordinado','20250202100000',8,'2025-09-25 00:49:23'),(19,1,4,5,5,9,'Cliente rechaza gestión de cobranza','20250115110000',9,'2025-09-25 00:49:23'),(20,1,4,5,5,12,'Datos de contacto incorrectos','20250116120000',10,'2025-09-25 00:49:23'),(21,1,4,1,5,2,'Actualización de datos, contactado','20250117130000',10,'2025-09-25 00:49:23'),(22,1,4,1,5,11,'Pendiente regularizar situación','20250118140000',10,'2025-09-25 00:49:23'),(23,1,5,2,6,16,'Encuesta de satisfacción completada','20250115150000',1,'2025-09-25 00:49:23'),(24,1,1,2,6,2,'Cross selling, consultó otros productos','20250116160000',20,'2025-09-25 00:49:23'),(25,1,1,3,6,8,'Interesada, agendada nueva llamada','20250117170000',20,'2025-09-25 00:49:23'),(26,1,1,3,6,1,'Adquiere producto adicional','20250118180000',20,'2025-09-25 00:49:23'),(27,1,2,4,7,2,'Cliente fidelizado, consulta beneficios','20250115190000',3,'2025-09-25 00:49:23'),(28,1,2,4,7,1,'Acepta upgrade del servicio','20250116200000',3,'2025-09-25 00:49:23'),(29,1,2,5,7,11,'Pendiente activación técnica','20250117210000',4,'2025-09-25 00:49:23'),(30,1,2,5,7,1,'Servicio activado correctamente','20250118220000',4,'2025-09-25 00:49:23'),(31,1,3,1,8,13,'Menor de edad, no puede contratar','20250115230000',7,'2025-09-25 00:49:23'),(32,1,3,1,8,2,'Habló con tutor, autoriza gestión','20250120080000',8,'2025-09-25 00:49:23'),(33,1,3,2,8,15,'Coordinación vía email con tutor','20250121090000',8,'2025-09-25 00:49:23'),(34,1,3,2,8,1,'Contrato firmado por tutor','20250122100000',8,'2025-09-25 00:49:23'),(35,1,1,3,9,6,'Número equivocado','20250115110000',13,'2025-09-25 00:49:23'),(36,1,1,3,9,2,'Número correcto, contactado','20250116120000',11,'2025-09-25 00:49:23'),(37,1,1,4,9,14,'Ya tiene servicio similar con competencia','20250117130000',11,'2025-09-25 00:49:23'),(38,1,1,4,9,10,'Solicita llamar cuando venza contrato','20250118140000',11,'2025-09-25 00:49:23'),(39,1,5,5,10,16,'Encuesta completada, muy satisfecha','20250115150000',14,'2025-09-25 00:49:23'),(40,1,2,5,10,2,'Consulta sobre nuevos servicios','20250116160000',12,'2025-09-25 00:49:23'),(41,1,2,1,10,1,'Contrata servicio adicional','20250117170000',12,'2025-09-25 00:49:23'),(42,1,1,1,2,3,'No contesta en horario laboral','20250119080000',3,'2025-09-25 00:49:23'),(43,1,2,2,3,4,'Línea ocupada durante la llamada','20250119090000',5,'2025-09-25 00:49:23'),(44,1,3,3,4,5,'Teléfono fuera de servicio','20250119100000',7,'2025-09-25 00:49:23'),(45,1,4,4,5,2,'Contactado para seguimiento cobranza','20250119110000',9,'2025-09-25 00:49:23'),(46,1,5,5,6,16,'Segunda encuesta completada','20250119120000',1,'2025-09-25 00:49:23'),(47,1,1,1,7,3,'No atiende llamada matutina','20250119130000',3,'2025-09-25 00:49:23'),(48,1,2,2,8,2,'Contactada para retención','20250119140000',7,'2025-09-25 00:49:23'),(49,1,3,3,9,6,'Número incorrecto en base datos','20250119150000',13,'2025-09-25 00:49:23'),(50,1,4,4,10,11,'Pendiente actualización datos','20250119160000',14,'2025-09-25 00:49:23'),(51,1,5,5,1,2,'Follow up encuesta anterior','20250120080000',1,'2025-09-25 00:49:23'),(52,1,1,1,3,10,'Reagendar para mejor horario','20250120090000',5,'2025-09-25 00:49:23'),(53,1,2,2,5,7,'Cliente rechaza propuesta','20250120100000',9,'2025-09-25 00:49:23'),(54,1,3,3,7,2,'Contactado para cross selling','20250120110000',3,'2025-09-25 00:49:23'),(55,1,4,4,9,12,'Actualizar información de contacto','20250120120000',11,'2025-09-25 00:49:23'),(56,1,5,5,2,1,'Encuesta y venta cruzada exitosa','20250120130000',3,'2025-09-25 00:49:23'),(57,1,1,1,4,8,'Agendar para próxima semana','20250120140000',7,'2025-09-25 00:49:23'),(58,1,2,2,6,2,'Consulta sobre renovación','20250120150000',20,'2025-09-25 00:49:23'),(59,1,3,3,8,11,'Pendiente documentación legal','20250120160000',7,'2025-09-25 00:49:23'),(60,1,4,4,10,1,'Regularización de cuenta exitosa','20250120170000',14,'2025-09-25 00:49:23'),(61,1,1,2,1,3,'Tercer intento, no contesta','20250121080000',1,'2025-09-25 00:49:23'),(62,1,2,3,2,2,'Consulta adicional sobre servicios','20250121090000',3,'2025-09-25 00:49:23'),(63,1,3,4,3,1,'Cierre exitoso de venta','20250121100000',5,'2025-09-25 00:49:23'),(64,1,4,5,4,9,'No interesada en momento actual','20250121110000',7,'2025-09-25 00:49:23'),(65,1,5,1,5,16,'Encuesta post-regularización','20250121120000',9,'2025-09-25 00:49:23'),(66,1,1,2,6,2,'Seguimiento producto adicional','20250121130000',20,'2025-09-25 00:49:23'),(67,1,2,3,7,1,'Upgrade confirmado y activado','20250121140000',3,'2025-09-25 00:49:23'),(68,1,3,4,8,2,'Contacto con tutor confirmado','20250121150000',7,'2025-09-25 00:49:23'),(69,1,4,5,9,3,'No contesta en nuevo número','20250121160000',11,'2025-09-25 00:49:23'),(70,1,5,1,10,2,'Seguimiento satisfacción cliente','20250121170000',14,'2025-09-25 00:49:23'),(71,1,1,3,1,4,'Ocupado durante horario comercial','20250122080000',1,'2025-09-25 00:49:23'),(72,1,2,4,2,1,'Renovación procesada exitosamente','20250122090000',3,'2025-09-25 00:49:23'),(73,1,3,5,3,11,'Pendiente activación técnica','20250122100000',5,'2025-09-25 00:49:23'),(74,1,4,1,4,2,'Recontacto después de rechazo','20250122110000',7,'2025-09-25 00:49:23'),(75,1,5,2,5,2,'Nueva encuesta de seguimiento','20250122120000',9,'2025-09-25 00:49:23'),(76,1,1,3,6,8,'Reagendado para presentación','20250122130000',20,'2025-09-25 00:49:23'),(77,1,2,4,7,2,'Cliente consulta nuevos beneficios','20250122140000',3,'2025-09-25 00:49:23'),(78,1,3,5,8,1,'Contrato menor edad procesado','20250122150000',7,'2025-09-25 00:49:23'),(79,1,4,1,9,2,'Contactado en número actualizado','20250122160000',11,'2025-09-25 00:49:23'),(80,1,5,2,10,16,'Encuesta satisfacción completada','20250122170000',14,'2025-09-25 00:49:23'),(81,1,1,4,1,2,'Contactado para nueva oferta','20250123080000',1,'2025-09-25 00:49:23'),(82,1,2,5,2,11,'Pendiente firma documentos','20250123090000',3,'2025-09-25 00:49:23'),(83,1,3,1,3,1,'Activación técnica completada','20250123100000',5,'2025-09-25 00:49:23'),(84,1,4,2,4,10,'Volver a llamar próximo mes','20250123110000',7,'2025-09-25 00:49:23'),(85,1,5,3,5,2,'Encuesta post regularización','20250123120000',9,'2025-09-25 00:49:23'),(86,1,1,4,6,1,'Producto adicional confirmado','20250123130000',20,'2025-09-25 00:49:23'),(87,1,2,5,7,2,'Seguimiento upgrade servicio','20250123140000',3,'2025-09-25 00:49:23'),(88,1,3,1,8,11,'Pendiente activación tutor','20250123150000',7,'2025-09-25 00:49:23'),(89,1,4,2,9,14,'Competencia vence en 6 meses','20250123160000',11,'2025-09-25 00:49:23'),(90,1,5,3,10,1,'Servicio adicional activado','20250123170000',14,'2025-09-25 00:49:23'),(91,1,1,5,1,3,'No contesta en horario tarde','20250124080000',1,'2025-09-25 00:49:23'),(92,1,2,1,2,2,'Cliente muy satisfecho','20250124090000',3,'2025-09-25 00:49:23'),(93,1,3,2,3,1,'Proceso completado exitosamente','20250124100000',5,'2025-09-25 00:49:23'),(94,1,4,3,4,8,'Reagendado para fin de mes','20250124110000',7,'2025-09-25 00:49:23'),(95,1,5,4,5,16,'Última encuesta del proceso','20250124120000',9,'2025-09-25 00:49:23'),(96,1,1,5,6,2,'Seguimiento final producto','20250124130000',20,'2025-09-25 00:49:23'),(97,1,2,1,7,1,'Fidelización completada','20250124140000',3,'2025-09-25 00:49:23'),(98,1,3,2,8,2,'Confirmación final tutor','20250124150000',7,'2025-09-25 00:49:23'),(99,1,4,3,9,2,'Datos actualizados correctamente','20250124160000',11,'2025-09-25 00:49:23'),(100,1,5,4,10,1,'Proceso integral completado','20250124170000',14,'2025-09-25 00:49:23'),(101,1,1,1,1,3,'Primera llamada, no contesta','20250925080000',1,'2025-09-26 01:47:08'),(102,1,1,1,1,2,'Contactado, muestra interés','20250925080000',1,'2025-09-26 01:47:08'),(103,1,1,1,1,1,'Coordinada visita para el jueves','20250925080000',1,'2025-09-26 01:47:08');
/*!40000 ALTER TABLE `gestiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestiones_resultado`
--

DROP TABLE IF EXISTS `gestiones_resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestiones_resultado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestiones_resultado`
--

LOCK TABLES `gestiones_resultado` WRITE;
/*!40000 ALTER TABLE `gestiones_resultado` DISABLE KEYS */;
INSERT INTO `gestiones_resultado` VALUES (1,'Coordinado'),(2,'Contactado'),(3,'No contesta'),(4,'Ocupado'),(5,'Fuera de servicio'),(6,'Número equivocado'),(7,'Rechazado'),(8,'Agendado'),(9,'No interesado'),(10,'Volver a llamar'),(11,'Pendiente'),(12,'Datos incorrectos'),(13,'Menor de edad'),(14,'Ya tiene el servicio'),(15,'Coordinar por mail'),(16,'Encuesta completada');
/*!40000 ALTER TABLE `gestiones_resultado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestiones_tipo`
--

DROP TABLE IF EXISTS `gestiones_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestiones_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestiones_tipo`
--

LOCK TABLES `gestiones_tipo` WRITE;
/*!40000 ALTER TABLE `gestiones_tipo` DISABLE KEYS */;
INSERT INTO `gestiones_tipo` VALUES (1,'Llamada'),(2,'Email'),(3,'SMS'),(4,'Visita'),(5,'WhatsApp');
/*!40000 ALTER TABLE `gestiones_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshots`
--

DROP TABLE IF EXISTS `snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snapshots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_creacion` char(255) DEFAULT NULL,
  `fec_intervalo` char(40) DEFAULT NULL,
  `contactabilidad` decimal(5,2) DEFAULT NULL,
  `penetracion_bruta` decimal(5,2) DEFAULT NULL,
  `penetracion_neta` decimal(5,2) DEFAULT NULL,
  `id_broker` int DEFAULT NULL,
  `id_campaign` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshots`
--

LOCK TABLES `snapshots` WRITE;
/*!40000 ALTER TABLE `snapshots` DISABLE KEYS */;
INSERT INTO `snapshots` VALUES (38,'2025-09-26 05:14:13','15/01/2025 - 26/09/2025',71.84,5.83,7.79,1,NULL),(39,'2025-09-26 05:14:28','15/01/2025 - 26/09/2025',0.00,0.00,0.00,3,NULL),(40,'2025-09-26 10:54:09','26/08/2025 - 26/09/2025',66.67,0.00,0.00,NULL,NULL);
/*!40000 ALTER TABLE `snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefonos`
--

DROP TABLE IF EXISTS `telefonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefonos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipo` int NOT NULL,
  `numero` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `tipo` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefonos`
--

LOCK TABLES `telefonos` WRITE;
/*!40000 ALTER TABLE `telefonos` DISABLE KEYS */;
INSERT INTO `telefonos` VALUES (1,1,24001234),(2,2,98765432),(3,1,24005678),(4,2,99123456),(5,1,24009012),(6,2,97456789),(7,1,24003456),(8,2,96789012),(9,1,24007890),(10,2,95123456),(11,2,94567890),(12,2,93456789),(13,1,24002345),(14,1,24006789),(15,2,92345678),(16,2,91234567),(17,1,24004567),(18,1,24008901),(19,2,90123456),(20,2,98901234);
/*!40000 ALTER TABLE `telefonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipo` int NOT NULL,
  `id_estado` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_categoria` int NOT NULL,
  `ci` int NOT NULL,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `usuario` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `id_tipo_escala` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo` (`id_tipo`,`id_estado`,`id_grupo`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_estado` (`id_estado`),
  KEY `id_grupo` (`id_grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,1,1,1,12345678,'Juan','Pérez','jperez','hash123',1),(2,1,1,1,1,23456789,'María','González','mgonzalez','hash456',1),(3,1,1,1,2,34567890,'Carlos','Rodríguez','crodriguez','hash789',1),(4,2,1,1,3,45678901,'Ana','Martínez','amartinez','hashabc',2),(5,1,1,2,2,56789012,'Pedro','López','plopez','hashdef',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_categorias`
--

DROP TABLE IF EXISTS `users_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_categorias`
--

LOCK TABLES `users_categorias` WRITE;
/*!40000 ALTER TABLE `users_categorias` DISABLE KEYS */;
INSERT INTO `users_categorias` VALUES (1,'Junior'),(2,'Senior'),(3,'Team Leader');
/*!40000 ALTER TABLE `users_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_estados`
--

DROP TABLE IF EXISTS `users_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_estados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_estados`
--

LOCK TABLES `users_estados` WRITE;
/*!40000 ALTER TABLE `users_estados` DISABLE KEYS */;
INSERT INTO `users_estados` VALUES (1,'Activo'),(2,'Inactivo'),(3,'Suspendido');
/*!40000 ALTER TABLE `users_estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_grupos`
--

DROP TABLE IF EXISTS `users_grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_grupos`
--

LOCK TABLES `users_grupos` WRITE;
/*!40000 ALTER TABLE `users_grupos` DISABLE KEYS */;
INSERT INTO `users_grupos` VALUES (1,'Ventas','Equipo de ventas telefónicas'),(2,'Retención','Equipo de retención de clientes'),(3,'Cobranzas','Equipo de gestión de cobranzas');
/*!40000 ALTER TABLE `users_grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_tipos`
--

DROP TABLE IF EXISTS `users_tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_tipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_tipos`
--

LOCK TABLES `users_tipos` WRITE;
/*!40000 ALTER TABLE `users_tipos` DISABLE KEYS */;
INSERT INTO `users_tipos` VALUES (1,'Operador','Agente telefónico que realiza gestiones'),(2,'Supervisor','Supervisa el trabajo de los operadores'),(3,'Administrador','Acceso completo al sistema');
/*!40000 ALTER TABLE `users_tipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-26 11:47:19
