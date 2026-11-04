CREATE DATABASE  IF NOT EXISTS `fishtank` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fishtank`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fishtank
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `ai_analyze`
--

DROP TABLE IF EXISTS `ai_analyze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_analyze` (
  `analysis_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `activity` int DEFAULT NULL,
  `detections` json NOT NULL,
  `analyzed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`analysis_id`),
  KEY `device_id` (`device_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ai_analyze_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE,
  CONSTRAINT `ai_analyze_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(45) NOT NULL,
  `type` enum('temp','waterquality','feed','waterChange') NOT NULL,
  `status` varchar(45) NOT NULL,
  `detail` json NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`alert_id`),
  KEY `device_alert_idx` (`device_id`),
  CONSTRAINT `device_alert` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camera`
--

DROP TABLE IF EXISTS `camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera` (
  `camera_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(45) NOT NULL,
  `camera_ip` varchar(45) NOT NULL,
  `rstp_uri` varchar(45) NOT NULL,
  PRIMARY KEY (`camera_id`),
  KEY `camera_device_FK_idx` (`device_id`),
  CONSTRAINT `camera_device_FK` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatbot`
--

DROP TABLE IF EXISTS `chatbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot` (
  `chatbot_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `question` text,
  `answer` text,
  `question_created_At` varchar(45) DEFAULT NULL,
  `Answer_created_At` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`chatbot_id`),
  KEY `user_chatbot_FK_idx` (`user_id`),
  CONSTRAINT `user_chatbot_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatbotmessage`
--

DROP TABLE IF EXISTS `chatbotmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbotmessage` (
  `chatbotmessage_id` int NOT NULL AUTO_INCREMENT,
  `chatbotroom_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `role` enum('model','user') NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`chatbotmessage_id`),
  KEY `chatbotroom_id` (`chatbotroom_id`),
  CONSTRAINT `chatbotmessage_ibfk_1` FOREIGN KEY (`chatbotroom_id`) REFERENCES `chatbotroom` (`chatbotroom_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatbotroom`
--

DROP TABLE IF EXISTS `chatbotroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbotroom` (
  `chatbotroom_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`chatbotroom_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `chatbotroom_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `parent_id` int DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `post_ForeignKey_idx` (`post_id`),
  KEY `user_ForeignKey_idx` (`user_id`),
  KEY `parent_FOreignKey_idx` (`parent_id`),
  CONSTRAINT `parent_FOreignKey` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE,
  CONSTRAINT `post_ForeignKey` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `user_ForeignKey` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commentlike`
--

DROP TABLE IF EXISTS `commentlike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentlike` (
  `commentlike_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `comment_id` int NOT NULL,
  PRIMARY KEY (`commentlike_id`),
  KEY `user_commentLikeFk_idx` (`user_id`),
  KEY `comment_commentLike_id_idx` (`comment_id`),
  CONSTRAINT `comment_commentLike_id` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE,
  CONSTRAINT `user_commentLikeFk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily`
--

DROP TABLE IF EXISTS `daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily` (
  `daily_id` int NOT NULL AUTO_INCREMENT,
  `min_temperature` float NOT NULL,
  `max_temperature` float NOT NULL,
  `avg_temperature` float NOT NULL,
  `water_quality` int NOT NULL,
  `daily` timestamp NOT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`daily_id`),
  KEY `daily_device_id_foreign_idx` (`device_id`),
  CONSTRAINT `daily_device_id_foreign_idx` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feederlog`
--

DROP TABLE IF EXISTS `feederlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feederlog` (
  `feederlog_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(45) NOT NULL,
  `status` tinyint NOT NULL,
  `feed_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feederlog_id`),
  KEY `water_device_idx` (`device_id`),
  CONSTRAINT `water_device` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fishinfo`
--

DROP TABLE IF EXISTS `fishinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fishinfo` (
  `fish_id` int NOT NULL AUTO_INCREMENT,
  `fish_type` varchar(45) NOT NULL,
  `fish_count` int NOT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fish_id`),
  KEY `fishinfo_device_id_foreign_idx` (`device_id`),
  CONSTRAINT `fishinfo_device_id_foreign_idx` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `Image_id` int NOT NULL AUTO_INCREMENT,
  `Image_url` varchar(255) NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`Image_id`),
  KEY `Post_image_FK_idx` (`post_id`),
  CONSTRAINT `Post_image_FK` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  `fish_type` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `PostUserForeignKey_idx` (`user_id`),
  CONSTRAINT `PostUserForeignKey` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensor` (
  `Sensor_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(45) NOT NULL,
  `temperature` float NOT NULL,
  `max_temperature` float DEFAULT NULL,
  `max_temperature_at` datetime DEFAULT NULL,
  `min_temperature` float DEFAULT NULL,
  `min_temperature_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Sensor_id`),
  KEY `SENSOR_DEVICE_FK_idx` (`device_id`),
  CONSTRAINT `SENSOR_DEVICE_FK` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=763 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tank`
--

DROP TABLE IF EXISTS `tank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tank` (
  `tank_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `device_id` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `min_temp` float DEFAULT NULL,
  `max_temp` float DEFAULT NULL,
  `normal_waterquality` int DEFAULT NULL,
  `warning_waterquality` float DEFAULT NULL,
  PRIMARY KEY (`tank_id`),
  UNIQUE KEY `device_id_UNIQUE` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(45) DEFAULT NULL,
  `provider` enum('kakao','google') DEFAULT NULL,
  `sns_id` varchar(45) NOT NULL,
  `token` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `nickname_UNIQUE` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userimage`
--

DROP TABLE IF EXISTS `userimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userimage` (
  `Image_id` int NOT NULL AUTO_INCREMENT,
  `Image_url` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`Image_id`),
  KEY `user_image_fk_idx` (`user_id`),
  CONSTRAINT `user_image_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `waterchangelog`
--

DROP TABLE IF EXISTS `waterchangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waterchangelog` (
  `waterchangelog_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(45) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`waterchangelog_id`),
  KEY `log_device_FK_idx` (`device_id`),
  CONSTRAINT `log_device_FK` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `waterquality`
--

DROP TABLE IF EXISTS `waterquality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waterquality` (
  `waterquality_id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `water_quality` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`waterquality_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `waterquality_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `tank` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=768 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'fishtank'
--

--
-- Dumping routines for database 'fishtank'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28 16:39:23
