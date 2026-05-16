-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: localhost    Database: team14
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '2ffc4656-097c-11f1-a969-83ba1d5e8375:1-487';

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `Log_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  `Action_Type` varchar(30) NOT NULL,
  `Entity_Type` varchar(30) NOT NULL,
  `Entity_ID` int NOT NULL,
  `Occurred_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Log_ID`),
  KEY `Project_ID` (`Project_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`) ON DELETE CASCADE,
  CONSTRAINT `activity_log_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` VALUES (1,1,1,'CREATE','Project',1,'2026-03-15 20:47:28'),(2,2,2,'CREATE','Project',2,'2026-03-15 20:47:28'),(3,3,3,'CREATE','Project',3,'2026-03-15 20:47:28'),(4,1,1,'ADD_MEMBER','User',4,'2026-03-15 20:47:28'),(5,1,1,'ADD_MEMBER','User',5,'2026-03-15 20:47:28'),(6,1,1,'ADD_MEMBER','User',6,'2026-03-15 20:47:28'),(7,2,2,'ADD_MEMBER','User',7,'2026-03-15 20:47:28'),(8,2,2,'ADD_MEMBER','User',8,'2026-03-15 20:47:28'),(9,3,3,'ADD_MEMBER','User',10,'2026-03-15 20:47:28'),(10,3,3,'ADD_MEMBER','User',9,'2026-03-15 20:47:28'),(11,1,1,'CREATE','Task',1,'2026-03-15 20:47:28'),(12,1,1,'CREATE','Task',2,'2026-03-15 20:47:28'),(13,1,1,'CREATE','Task',3,'2026-03-15 20:47:28'),(14,1,1,'CREATE','Task',4,'2026-03-15 20:47:28'),(15,1,1,'CREATE','Task',5,'2026-03-15 20:47:28'),(16,2,2,'CREATE','Task',6,'2026-03-15 20:47:28'),(17,2,2,'CREATE','Task',7,'2026-03-15 20:47:28'),(18,2,2,'CREATE','Task',8,'2026-03-15 20:47:28'),(19,3,3,'CREATE','Task',11,'2026-03-15 20:47:28'),(20,3,3,'CREATE','Task',15,'2026-03-15 20:47:28'),(21,1,1,'ASSIGN','Task',1,'2026-03-15 20:47:28'),(22,1,1,'ASSIGN','Task',3,'2026-03-15 20:47:28'),(23,2,2,'ASSIGN','Task',6,'2026-03-15 20:47:28'),(24,2,2,'ASSIGN','Task',8,'2026-03-15 20:47:28'),(25,3,3,'ASSIGN','Task',12,'2026-03-15 20:47:28'),(26,3,3,'ASSIGN','Task',15,'2026-03-15 20:47:28'),(27,1,2,'COMMENT','Task',1,'2026-03-15 20:47:28'),(28,1,1,'COMMENT','Task',2,'2026-03-15 20:47:28'),(29,2,6,'COMMENT','Task',6,'2026-03-15 20:47:28'),(30,3,3,'COMMENT','Task',15,'2026-03-15 20:47:28'),(31,1,1,'COMMENT','Task',21,'2026-04-28 16:49:14'),(32,1,1,'DELETE','Task',21,'2026-04-28 16:49:37'),(33,1,1,'UPDATE','Task',5,'2026-04-28 16:50:11'),(34,1,1,'UPDATE','Task',20,'2026-04-28 16:50:27'),(35,1,1,'ADD_MEMBER','User',3,'2026-04-28 16:58:20'),(36,1,1,'DELETE','Task',22,'2026-04-28 19:51:07'),(37,1,1,'CREATE','Task',23,'2026-04-28 19:51:22'),(38,8,12,'CREATE','Project',8,'2026-04-28 19:54:43'),(39,8,12,'ADD_MEMBER','User',2,'2026-04-28 19:55:18'),(40,9,2,'CREATE','Project',9,'2026-05-10 17:21:54'),(41,10,2,'CREATE','Project',10,'2026-05-10 17:22:30'),(42,11,2,'CREATE','Project',11,'2026-05-10 17:23:01'),(43,12,2,'CREATE','Project',12,'2026-05-10 17:23:35'),(44,13,2,'CREATE','Project',13,'2026-05-10 17:26:18'),(45,14,2,'CREATE','Project',14,'2026-05-10 17:27:02'),(46,8,2,'CREATE','Task',24,'2026-05-10 17:32:10'),(47,8,2,'COMMENT','Task',24,'2026-05-10 17:32:18'),(48,8,2,'UPDATE','Task',24,'2026-05-10 17:42:09'),(49,8,2,'CREATE','Task',25,'2026-05-10 17:42:21'),(50,8,2,'UPDATE','Task',25,'2026-05-10 17:42:25'),(51,8,2,'CREATE','Task',26,'2026-05-10 17:42:29'),(52,8,2,'UPDATE','Task',26,'2026-05-10 17:42:34'),(53,8,2,'CREATE','Task',27,'2026-05-10 17:42:39'),(54,8,2,'CREATE','Task',28,'2026-05-10 17:42:42'),(55,8,2,'CREATE','Task',29,'2026-05-10 17:42:45'),(56,8,2,'CREATE','Task',30,'2026-05-10 17:42:49'),(57,8,2,'CREATE','Task',31,'2026-05-10 17:42:53'),(58,8,2,'UPDATE','Task',27,'2026-05-10 17:43:00'),(59,8,2,'UPDATE','Task',28,'2026-05-10 17:43:03'),(60,8,2,'UPDATE','Task',29,'2026-05-10 17:43:07'),(61,8,2,'UPDATE','Task',30,'2026-05-10 17:43:12'),(62,8,2,'UPDATE','Task',31,'2026-05-10 17:43:17'),(63,8,2,'UPDATE','Task',25,'2026-05-10 17:56:57'),(64,8,2,'UPDATE','Task',26,'2026-05-10 17:57:01'),(65,8,2,'UPDATE','Task',27,'2026-05-10 17:57:04'),(66,8,2,'UPDATE','Task',28,'2026-05-10 17:57:08'),(67,8,2,'UPDATE','Task',29,'2026-05-10 17:57:12'),(68,8,2,'UPDATE','Task',30,'2026-05-10 17:57:16'),(69,8,2,'UPDATE','Task',31,'2026-05-10 18:00:15'),(70,8,2,'UPDATE','Task',24,'2026-05-10 18:00:18'),(71,1,2,'UPDATE','Task',5,'2026-05-15 16:52:52'),(72,1,2,'UPDATE','Task',5,'2026-05-15 16:53:38'),(73,1,2,'UPDATE','Task',5,'2026-05-15 17:06:47'),(74,1,2,'UPDATE','Task',5,'2026-05-15 17:25:07'),(75,1,2,'UPDATE','Task',5,'2026-05-15 17:27:46'),(76,1,2,'UPDATE','Task',5,'2026-05-15 17:32:44'),(77,1,2,'UPDATE','Task',5,'2026-05-15 17:33:24'),(78,1,2,'UPDATE','Task',5,'2026-05-15 17:43:45'),(79,1,2,'UPDATE','Task',5,'2026-05-15 17:44:33'),(80,1,2,'UPDATE','Task',5,'2026-05-15 17:53:55'),(81,1,2,'UPDATE','Task',5,'2026-05-15 17:57:10'),(82,1,2,'UPDATE','Task',5,'2026-05-15 17:57:43'),(83,1,2,'UPDATE','Task',5,'2026-05-15 18:03:55'),(84,1,2,'UPDATE','Task',5,'2026-05-15 18:04:30'),(85,1,2,'UPDATE','Task',20,'2026-05-15 18:04:35'),(86,1,2,'UPDATE','Task',20,'2026-05-15 18:04:48'),(87,1,2,'UPDATE','Task',5,'2026-05-15 18:05:02'),(88,1,2,'UPDATE','Task',5,'2026-05-15 18:07:58'),(89,1,2,'UPDATE','Task',5,'2026-05-15 18:09:54'),(90,1,1,'UPDATE','Task',23,'2026-05-15 18:12:22'),(91,1,1,'UPDATE','Task',1,'2026-05-15 18:12:26'),(92,1,1,'UPDATE','Task',2,'2026-05-15 18:12:31'),(93,1,1,'UPDATE','Task',3,'2026-05-15 18:12:37'),(94,2,1,'UPDATE','Task',6,'2026-05-15 18:12:44'),(95,2,1,'UPDATE','Task',8,'2026-05-15 18:12:48'),(96,2,1,'UPDATE','Task',9,'2026-05-15 18:12:52'),(97,2,1,'UPDATE','Task',7,'2026-05-15 18:12:56'),(98,8,2,'UPDATE','Task',25,'2026-05-15 18:25:50');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` text NOT NULL,
  `uploaded_by` int NOT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `uploaded_by` (`uploaded_by`),
  CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`Task_ID`) ON DELETE CASCADE,
  CONSTRAINT `attachments_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES (1,5,'Random1.txt','uploads/Random1.txt',2,'2026-05-15 18:09:54'),(2,23,'Random2.txt','uploads/Random2.txt',1,'2026-05-15 18:12:22'),(3,1,'Random3.txt','uploads/Random3.txt',1,'2026-05-15 18:12:26'),(4,2,'Random4.txt','uploads/Random4.txt',1,'2026-05-15 18:12:31'),(5,3,'Random5.txt','uploads/Random5.txt',1,'2026-05-15 18:12:37'),(6,6,'Random6.txt','uploads/Random6.txt',1,'2026-05-15 18:12:44'),(7,8,'Random7.txt','uploads/Random7.txt',1,'2026-05-15 18:12:48'),(8,9,'Random8.txt','uploads/Random8.txt',1,'2026-05-15 18:12:52'),(9,7,'Random9.txt','uploads/Random9.txt',1,'2026-05-15 18:12:56'),(10,25,'Random10.txt','uploads/Random10.txt',2,'2026-05-15 18:25:50');
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `Comment_ID` int NOT NULL AUTO_INCREMENT,
  `Task_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  `Comment_Text` text NOT NULL,
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Comment_ID`),
  KEY `Task_ID` (`Task_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`Task_ID`) REFERENCES `tasks` (`Task_ID`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,2,'Tables created successfully in team14.','2026-03-15 20:21:25'),(2,2,1,'Trigger added. Creator auto becomes ADMIN.','2026-03-15 20:21:25'),(3,3,4,'Inserted 10 users for the demo dataset.','2026-03-15 20:21:25'),(4,5,5,'Next step: screenshot SELECT outputs for all tables.','2026-03-15 20:21:25'),(5,6,6,'FK constraints validated for Projects/Users/Tasks.','2026-03-15 20:21:25'),(6,7,7,'Membership roles set correctly per project.','2026-03-15 20:21:25'),(7,8,8,'Task_Assignments populated (many-to-many).','2026-03-15 20:21:25'),(8,9,10,'Comments added so Tasks show collaboration.','2026-03-15 20:21:25'),(10,15,3,'Final review: ensure all tables have rows for screenshots.','2026-03-15 20:21:25'),(15,24,2,'I will do this one.','2026-05-10 17:32:18');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labels`
--

DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labels` (
  `label_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `label_name` varchar(40) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`label_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `labels_project_fk` FOREIGN KEY (`project_id`) REFERENCES `projects` (`Project_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labels`
--

LOCK TABLES `labels` WRITE;
/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
INSERT INTO `labels` VALUES (1,1,'Software','#ffcccc'),(2,1,'Physical','#ccffcc'),(3,8,'Frontend','#ffcccc'),(4,8,'Backend','#ccffcc'),(5,8,'Priority','#ccccff'),(6,8,'Unimportant','#ffffcc'),(7,8,'Main Feature','#ffcccc'),(8,8,'Sub-Feature','#ccffcc'),(9,8,'Database','#ffffcc'),(10,8,'UI','#e6ccff');
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `Notification_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Message` text NOT NULL,
  `Is_Read` tinyint(1) NOT NULL DEFAULT '0',
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Triggering_Entity_Type` varchar(30) DEFAULT NULL,
  `Triggering_Entity_ID` int DEFAULT NULL,
  PRIMARY KEY (`Notification_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,4,'You were added to TaskMe Web App as MEMBER.',0,'2026-03-15 20:13:26','Project',1),(2,5,'You were added to TaskMe Web App as COMMENT_ONLY.',1,'2026-03-15 20:13:26','Project',1),(3,6,'You were added to TaskMe Web App as MEMBER.',0,'2026-03-15 20:13:26','Project',1),(4,7,'You were added to Database Demo Pack as MEMBER.',0,'2026-03-15 20:13:26','Project',2),(5,8,'You were added to Database Demo Pack as MEMBER.',0,'2026-03-15 20:13:26','Project',2),(6,10,'You were added to Workflow Simulation as COMMENT_ONLY.',0,'2026-03-15 20:13:26','Project',3),(7,9,'You were added to Workflow Simulation as MEMBER.',0,'2026-03-15 20:13:26','Project',3),(8,1,'Task assigned: Create Tables',1,'2026-03-15 20:13:26','Task',1),(9,1,'Task assigned: Add Trigger',1,'2026-03-15 20:13:26','Task',2),(10,2,'Task assigned: Insert Sample Users',1,'2026-03-15 20:13:26','Task',3),(11,4,'Task assigned: Insert Sample Projects',0,'2026-03-15 20:13:26','Task',4),(12,5,'Task assigned: Capture Screenshots',1,'2026-03-15 20:13:26','Task',5),(13,2,'Task assigned: Validate FKs',1,'2026-03-15 20:13:26','Task',6),(14,6,'Task assigned: Insert Memberships',0,'2026-03-15 20:13:26','Task',7),(15,7,'Task assigned: Create Assignments',0,'2026-03-15 20:13:26','Task',8),(16,8,'Task assigned: Add Comments',0,'2026-03-15 20:13:26','Task',9),(17,10,'Task assigned: Add Attachments',0,'2026-03-15 20:13:26','Task',10),(18,3,'Task assigned: Final Review',1,'2026-03-15 20:13:26','Task',15),(19,3,'You were added to TaskMe Web App as MEMBER.',1,'2026-04-28 16:58:20','Project',1),(20,2,'Task deleted: April 28th Notification Test',1,'2026-04-28 19:51:07','Task',22),(21,3,'Task deleted: April 28th Notification Test',0,'2026-04-28 19:51:07','Task',22),(22,4,'Task deleted: April 28th Notification Test',0,'2026-04-28 19:51:07','Task',22),(23,5,'Task deleted: April 28th Notification Test',1,'2026-04-28 19:51:07','Task',22),(24,6,'Task deleted: April 28th Notification Test',0,'2026-04-28 19:51:07','Task',22),(27,2,'New task created: April 28th - Notification Test Night',1,'2026-04-28 19:51:22','Task',23),(28,3,'New task created: April 28th - Notification Test Night',0,'2026-04-28 19:51:22','Task',23),(29,4,'New task created: April 28th - Notification Test Night',0,'2026-04-28 19:51:22','Task',23),(30,5,'New task created: April 28th - Notification Test Night',1,'2026-04-28 19:51:22','Task',23),(31,6,'New task created: April 28th - Notification Test Night',0,'2026-04-28 19:51:22','Task',23),(34,2,'You were added to Final Test Project as MEMBER.',1,'2026-04-28 19:55:18','Project',8),(35,12,'New task created: Hello Test',0,'2026-05-10 17:32:10','Task',24),(36,12,'New comment on task: Hello Test',0,'2026-05-10 17:32:18','Task',24),(37,12,'Task updated: Hello Test',0,'2026-05-10 17:42:09','Task',24),(38,12,'New task created: Hello Test 2',0,'2026-05-10 17:42:21','Task',25),(39,12,'Task updated: Hello Test 2',0,'2026-05-10 17:42:25','Task',25),(40,12,'New task created: Hello Test 3',0,'2026-05-10 17:42:29','Task',26),(41,12,'Task updated: Hello Test 3',0,'2026-05-10 17:42:34','Task',26),(42,12,'New task created: Hello Test 4',0,'2026-05-10 17:42:39','Task',27),(43,12,'New task created: Hello Test 5',0,'2026-05-10 17:42:42','Task',28),(44,12,'New task created: Hello Test 6',0,'2026-05-10 17:42:45','Task',29),(45,12,'New task created: Hello Test 7',0,'2026-05-10 17:42:49','Task',30),(46,12,'New task created: Hello Test 8',0,'2026-05-10 17:42:53','Task',31),(47,12,'Task updated: Hello Test 4',0,'2026-05-10 17:43:00','Task',27),(48,12,'Task updated: Hello Test 5',0,'2026-05-10 17:43:03','Task',28),(49,12,'Task updated: Hello Test 6',0,'2026-05-10 17:43:07','Task',29),(50,12,'Task updated: Hello Test 7',0,'2026-05-10 17:43:12','Task',30),(51,12,'Task updated: Hello Test 8',0,'2026-05-10 17:43:17','Task',31),(52,12,'Task updated: Hello Test 2',0,'2026-05-10 17:56:57','Task',25),(53,12,'Task updated: Hello Test 3',0,'2026-05-10 17:57:01','Task',26),(54,12,'Task updated: Hello Test 4',0,'2026-05-10 17:57:04','Task',27),(55,12,'Task updated: Hello Test 5',0,'2026-05-10 17:57:08','Task',28),(56,12,'Task updated: Hello Test 6',0,'2026-05-10 17:57:12','Task',29),(57,12,'Task updated: Hello Test 7',0,'2026-05-10 17:57:16','Task',30),(58,12,'Task updated: Hello Test 8',0,'2026-05-10 18:00:15','Task',31),(59,12,'Task updated: Hello Test',0,'2026-05-10 18:00:18','Task',24),(60,1,'Task updated: Capture Screenshots',0,'2026-05-15 16:52:52','Task',5),(61,3,'Task updated: Capture Screenshots',0,'2026-05-15 16:52:52','Task',5),(62,4,'Task updated: Capture Screenshots',0,'2026-05-15 16:52:52','Task',5),(63,5,'Task updated: Capture Screenshots',0,'2026-05-15 16:52:52','Task',5),(64,6,'Task updated: Capture Screenshots',0,'2026-05-15 16:52:52','Task',5),(67,1,'Task updated: Capture Screenshots',0,'2026-05-15 16:53:38','Task',5),(68,3,'Task updated: Capture Screenshots',0,'2026-05-15 16:53:38','Task',5),(69,4,'Task updated: Capture Screenshots',0,'2026-05-15 16:53:38','Task',5),(70,5,'Task updated: Capture Screenshots',0,'2026-05-15 16:53:38','Task',5),(71,6,'Task updated: Capture Screenshots',0,'2026-05-15 16:53:38','Task',5),(72,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:06:48','Task',5),(73,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:06:48','Task',5),(74,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:06:48','Task',5),(75,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:06:48','Task',5),(76,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:06:48','Task',5),(79,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:25:07','Task',5),(80,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:25:07','Task',5),(81,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:25:07','Task',5),(82,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:25:07','Task',5),(83,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:25:07','Task',5),(86,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:27:46','Task',5),(87,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:27:46','Task',5),(88,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:27:46','Task',5),(89,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:27:46','Task',5),(90,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:27:46','Task',5),(93,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:32:44','Task',5),(94,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:32:44','Task',5),(95,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:32:44','Task',5),(96,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:32:44','Task',5),(97,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:32:44','Task',5),(100,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:33:24','Task',5),(101,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:33:24','Task',5),(102,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:33:24','Task',5),(103,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:33:24','Task',5),(104,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:33:24','Task',5),(107,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:43:45','Task',5),(108,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:43:45','Task',5),(109,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:43:45','Task',5),(110,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:43:45','Task',5),(111,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:43:45','Task',5),(114,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:44:33','Task',5),(115,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:44:33','Task',5),(116,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:44:33','Task',5),(117,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:44:33','Task',5),(118,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:44:33','Task',5),(121,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:53:55','Task',5),(122,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:53:55','Task',5),(123,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:53:55','Task',5),(124,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:53:55','Task',5),(125,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:53:55','Task',5),(128,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:10','Task',5),(129,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:10','Task',5),(130,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:10','Task',5),(131,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:10','Task',5),(132,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:10','Task',5),(135,1,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:43','Task',5),(136,3,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:43','Task',5),(137,4,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:43','Task',5),(138,5,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:43','Task',5),(139,6,'Task updated: Capture Screenshots',0,'2026-05-15 17:57:43','Task',5),(142,1,'Task updated: Capture Screenshots',0,'2026-05-15 18:03:55','Task',5),(143,3,'Task updated: Capture Screenshots',0,'2026-05-15 18:03:55','Task',5),(144,4,'Task updated: Capture Screenshots',0,'2026-05-15 18:03:55','Task',5),(145,5,'Task updated: Capture Screenshots',0,'2026-05-15 18:03:55','Task',5),(146,6,'Task updated: Capture Screenshots',0,'2026-05-15 18:03:55','Task',5),(149,1,'Task updated: Capture Screenshots',0,'2026-05-15 18:04:30','Task',5),(150,3,'Task updated: Capture Screenshots',0,'2026-05-15 18:04:30','Task',5),(151,4,'Task updated: Capture Screenshots',0,'2026-05-15 18:04:30','Task',5),(152,5,'Task updated: Capture Screenshots',0,'2026-05-15 18:04:30','Task',5),(153,6,'Task updated: Capture Screenshots',0,'2026-05-15 18:04:30','Task',5),(156,1,'Task updated: New Task Test',0,'2026-05-15 18:04:35','Task',20),(157,3,'Task updated: New Task Test',0,'2026-05-15 18:04:35','Task',20),(158,4,'Task updated: New Task Test',0,'2026-05-15 18:04:35','Task',20),(159,5,'Task updated: New Task Test',0,'2026-05-15 18:04:35','Task',20),(160,6,'Task updated: New Task Test',0,'2026-05-15 18:04:35','Task',20),(163,1,'Task updated: New Task Test',0,'2026-05-15 18:04:48','Task',20),(164,3,'Task updated: New Task Test',0,'2026-05-15 18:04:48','Task',20),(165,4,'Task updated: New Task Test',0,'2026-05-15 18:04:48','Task',20),(166,5,'Task updated: New Task Test',0,'2026-05-15 18:04:48','Task',20),(167,6,'Task updated: New Task Test',0,'2026-05-15 18:04:48','Task',20),(170,1,'Task updated: Capture Screenshots',0,'2026-05-15 18:05:02','Task',5),(171,3,'Task updated: Capture Screenshots',0,'2026-05-15 18:05:02','Task',5),(172,4,'Task updated: Capture Screenshots',0,'2026-05-15 18:05:02','Task',5),(173,5,'Task updated: Capture Screenshots',0,'2026-05-15 18:05:02','Task',5),(174,6,'Task updated: Capture Screenshots',0,'2026-05-15 18:05:02','Task',5),(177,1,'Task updated: Capture Screenshots',0,'2026-05-15 18:07:58','Task',5),(178,3,'Task updated: Capture Screenshots',0,'2026-05-15 18:07:58','Task',5),(179,4,'Task updated: Capture Screenshots',0,'2026-05-15 18:07:58','Task',5),(180,5,'Task updated: Capture Screenshots',0,'2026-05-15 18:07:58','Task',5),(181,6,'Task updated: Capture Screenshots',0,'2026-05-15 18:07:58','Task',5),(184,1,'Task updated: Capture Screenshots',0,'2026-05-15 18:09:54','Task',5),(185,3,'Task updated: Capture Screenshots',0,'2026-05-15 18:09:54','Task',5),(186,4,'Task updated: Capture Screenshots',0,'2026-05-15 18:09:54','Task',5),(187,5,'Task updated: Capture Screenshots',0,'2026-05-15 18:09:54','Task',5),(188,6,'Task updated: Capture Screenshots',0,'2026-05-15 18:09:54','Task',5),(191,2,'Task updated: April 28th - Notification Test Night',0,'2026-05-15 18:12:22','Task',23),(192,3,'Task updated: April 28th - Notification Test Night',0,'2026-05-15 18:12:22','Task',23),(193,4,'Task updated: April 28th - Notification Test Night',0,'2026-05-15 18:12:22','Task',23),(194,5,'Task updated: April 28th - Notification Test Night',0,'2026-05-15 18:12:22','Task',23),(195,6,'Task updated: April 28th - Notification Test Night',0,'2026-05-15 18:12:22','Task',23),(198,2,'Task updated: Create Tables',0,'2026-05-15 18:12:26','Task',1),(199,3,'Task updated: Create Tables',0,'2026-05-15 18:12:26','Task',1),(200,4,'Task updated: Create Tables',0,'2026-05-15 18:12:26','Task',1),(201,5,'Task updated: Create Tables',0,'2026-05-15 18:12:26','Task',1),(202,6,'Task updated: Create Tables',0,'2026-05-15 18:12:26','Task',1),(205,2,'Task updated: Add Trigger',0,'2026-05-15 18:12:31','Task',2),(206,3,'Task updated: Add Trigger',0,'2026-05-15 18:12:31','Task',2),(207,4,'Task updated: Add Trigger',0,'2026-05-15 18:12:31','Task',2),(208,5,'Task updated: Add Trigger',0,'2026-05-15 18:12:31','Task',2),(209,6,'Task updated: Add Trigger',0,'2026-05-15 18:12:31','Task',2),(212,2,'Task updated: Insert Sample Users',0,'2026-05-15 18:12:37','Task',3),(213,3,'Task updated: Insert Sample Users',0,'2026-05-15 18:12:37','Task',3),(214,4,'Task updated: Insert Sample Users',0,'2026-05-15 18:12:37','Task',3),(215,5,'Task updated: Insert Sample Users',0,'2026-05-15 18:12:37','Task',3),(216,6,'Task updated: Insert Sample Users',0,'2026-05-15 18:12:37','Task',3),(219,2,'Task updated: Validate FKs',0,'2026-05-15 18:12:44','Task',6),(220,7,'Task updated: Validate FKs',0,'2026-05-15 18:12:44','Task',6),(221,8,'Task updated: Validate FKs',0,'2026-05-15 18:12:44','Task',6),(222,2,'Task updated: Create Assignments',0,'2026-05-15 18:12:48','Task',8),(223,7,'Task updated: Create Assignments',0,'2026-05-15 18:12:48','Task',8),(224,8,'Task updated: Create Assignments',0,'2026-05-15 18:12:48','Task',8),(225,2,'Task updated: Add Comments',0,'2026-05-15 18:12:52','Task',9),(226,7,'Task updated: Add Comments',0,'2026-05-15 18:12:52','Task',9),(227,8,'Task updated: Add Comments',0,'2026-05-15 18:12:52','Task',9),(228,2,'Task updated: Insert Memberships',0,'2026-05-15 18:12:56','Task',7),(229,7,'Task updated: Insert Memberships',0,'2026-05-15 18:12:56','Task',7),(230,8,'Task updated: Insert Memberships',0,'2026-05-15 18:12:56','Task',7),(231,12,'Task updated: Hello Test 2',0,'2026-05-15 18:25:50','Task',25);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_memberships`
--

DROP TABLE IF EXISTS `project_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_memberships` (
  `Project_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  `Role` enum('ADMIN','MEMBER','COMMENT_ONLY') NOT NULL DEFAULT 'MEMBER',
  `Joined_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Project_ID`,`User_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `project_memberships_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`) ON DELETE CASCADE,
  CONSTRAINT `project_memberships_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_memberships`
--

LOCK TABLES `project_memberships` WRITE;
/*!40000 ALTER TABLE `project_memberships` DISABLE KEYS */;
INSERT INTO `project_memberships` VALUES (1,1,'ADMIN','2026-03-15 19:57:47'),(1,2,'MEMBER','2026-04-14 10:57:55'),(1,3,'MEMBER','2026-04-28 16:58:20'),(1,4,'MEMBER','2026-03-15 19:57:47'),(1,5,'COMMENT_ONLY','2026-03-15 19:57:47'),(1,6,'MEMBER','2026-03-15 19:57:47'),(2,1,'MEMBER','2026-04-14 11:34:35'),(2,2,'ADMIN','2026-03-15 19:57:47'),(2,7,'MEMBER','2026-03-15 19:57:47'),(2,8,'MEMBER','2026-03-15 19:57:47'),(3,3,'ADMIN','2026-03-15 19:57:47'),(3,9,'MEMBER','2026-03-15 19:57:47'),(3,10,'COMMENT_ONLY','2026-03-15 19:57:47'),(8,2,'MEMBER','2026-04-28 19:55:18'),(8,12,'ADMIN','2026-04-28 19:54:43'),(9,2,'ADMIN','2026-05-10 17:21:54'),(10,2,'ADMIN','2026-05-10 17:22:30'),(11,2,'ADMIN','2026-05-10 17:23:01'),(12,2,'ADMIN','2026-05-10 17:23:35'),(13,2,'ADMIN','2026-05-10 17:26:18'),(14,2,'ADMIN','2026-05-10 17:27:02');
/*!40000 ALTER TABLE `project_memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `Project_ID` int NOT NULL AUTO_INCREMENT,
  `Project_Name` varchar(100) NOT NULL,
  `Description` text,
  `Due_Date` datetime DEFAULT NULL,
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Creator_User_ID` int NOT NULL,
  PRIMARY KEY (`Project_ID`),
  KEY `Creator_User_ID` (`Creator_User_ID`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`Creator_User_ID`) REFERENCES `users` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'TaskMe Web App','Build TaskMe tables + demo data','2026-04-10 17:00:00','2026-03-15 19:26:23',1),(2,'Database Demo Pack','Populate tables for Workbench screenshots','2026-04-12 17:00:00','2026-03-15 19:26:23',2),(3,'Workflow Simulation','Simulate team workflow with logs/notifications','2026-04-15 17:00:00','2026-03-15 19:26:23',3),(8,'Final Test Project','Testing the final code for this project.','2026-04-30 21:00:00','2026-04-28 19:54:43',12),(9,'Aurora Analytics','Built a dashboard that tracks customer purchasing trends and sales performance.','2026-06-03 17:21:00','2026-05-10 17:21:54',2),(10,'EchoNet Security','Develop a small network monitoring tool that detects suspicious login attempts.','2026-05-28 17:22:00','2026-05-10 17:22:30',2),(11,'GreenGrid Energy','Analyze household energy usage and propose conservation improvements.','2026-06-15 17:22:00','2026-05-10 17:23:01',2),(12,'Titan Inventory System','Create a database system for managing warehouse stock and supplier records.','2026-05-31 17:23:00','2026-05-10 17:23:35',2),(13,'NovaLearn Platform','Design an online learning portal with quizzes, assignments, and grade tracking.','2026-06-20 17:26:00','2026-05-10 17:26:18',2),(14,'BlueWave Mobile App','Prototype a mobile app that helps users track fitness and nutrition goals.','2026-05-25 17:26:00','2026-05-10 17:27:02',2);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_assignments`
--

DROP TABLE IF EXISTS `task_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_assignments` (
  `Task_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  `Assigned_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Task_ID`,`User_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `task_assignments_ibfk_1` FOREIGN KEY (`Task_ID`) REFERENCES `tasks` (`Task_ID`) ON DELETE CASCADE,
  CONSTRAINT `task_assignments_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_assignments`
--

LOCK TABLES `task_assignments` WRITE;
/*!40000 ALTER TABLE `task_assignments` DISABLE KEYS */;
INSERT INTO `task_assignments` VALUES (1,1,'2026-03-15 19:57:42'),(2,1,'2026-03-15 19:57:42'),(3,2,'2026-03-15 19:57:42'),(4,4,'2026-03-15 19:57:42'),(5,5,'2026-03-15 19:57:42'),(6,2,'2026-03-15 19:57:42'),(7,6,'2026-03-15 19:57:42'),(8,7,'2026-03-15 19:57:42'),(9,8,'2026-03-15 19:57:42'),(11,3,'2026-03-15 19:57:42'),(12,1,'2026-03-15 19:57:42'),(13,2,'2026-03-15 19:57:42'),(14,6,'2026-03-15 19:57:42'),(15,7,'2026-03-15 19:57:42');
/*!40000 ALTER TABLE `task_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `Task_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int NOT NULL,
  `Task_Title` varchar(150) NOT NULL,
  `Task_Description` text,
  `Due_Date` datetime DEFAULT NULL,
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('TODO','IN_PROGRESS','DONE') NOT NULL DEFAULT 'TODO',
  `Priority` tinyint NOT NULL DEFAULT '2',
  `Created_By` int DEFAULT NULL,
  `label_id` int DEFAULT NULL,
  PRIMARY KEY (`Task_ID`),
  KEY `Project_ID` (`Project_ID`),
  KEY `Created_By` (`Created_By`),
  KEY `tasks_label_fk` (`label_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`Created_By`) REFERENCES `users` (`User_ID`) ON DELETE SET NULL,
  CONSTRAINT `tasks_label_fk` FOREIGN KEY (`label_id`) REFERENCES `labels` (`label_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Create Tables','Run DDL to create tables + keys','2026-03-20 23:59:00','2026-03-15 19:44:02','DONE',2,NULL,NULL),(2,1,'Add Trigger','Creator auto-admin trigger','2026-03-21 23:59:00','2026-03-15 19:44:02','DONE',2,NULL,NULL),(3,1,'Insert Sample Users','Add 10 users for demo','2026-03-22 23:59:00','2026-03-15 19:44:02','IN_PROGRESS',2,NULL,NULL),(4,1,'Insert Sample Projects','Add 3 projects for demo','2026-03-22 23:59:59','2026-03-15 19:44:02','TODO',2,NULL,NULL),(5,1,'Capture Screenshots','Run SELECT * and screenshot','2026-03-25 23:59:00','2026-03-15 19:44:02','IN_PROGRESS',3,NULL,NULL),(6,2,'Validate FKs','Ensure FK constraints work','2026-03-23 23:59:00','2026-03-15 19:44:02','IN_PROGRESS',2,NULL,NULL),(7,2,'Insert Memberships','Add project membership roles','2026-03-23 23:59:00','2026-03-15 19:44:02','TODO',1,NULL,NULL),(8,2,'Create Assignments','Populate Task_Assignments','2026-03-24 23:59:00','2026-03-15 19:49:43','TODO',2,NULL,NULL),(9,2,'Add Comments','Add comment rows for demo','2026-03-24 23:59:00','2026-03-15 19:49:43','TODO',2,NULL,NULL),(11,3,'Create Labels','Add labels to tasks','2026-03-26 23:59:59','2026-03-15 19:49:43','TODO',1,NULL,NULL),(12,3,'Generate Notifications','Add notifications for events','2026-03-26 23:59:59','2026-03-15 19:49:43','TODO',2,NULL,NULL),(13,3,'Write Activity Logs','Insert audit log rows','2026-03-27 23:59:59','2026-03-15 19:49:43','TODO',2,NULL,NULL),(14,3,'Role Testing','Verify ADMIN/MEMBER/COMMENT_ONLY','2026-03-28 23:59:59','2026-03-15 19:49:43','TODO',2,NULL,NULL),(15,3,'Final Review','Final pass for demo','2026-03-30 23:59:59','2026-03-15 19:49:43','TODO',3,NULL,NULL),(20,1,'New Task Test','Testing 123','2026-04-18 18:35:00','2026-04-14 18:35:02','DONE',1,1,NULL),(23,1,'April 28th - Notification Test Night','',NULL,'2026-04-28 19:51:22','TODO',2,1,NULL),(24,8,'Hello Test','Hello there!','2026-05-11 17:32:00','2026-05-10 17:32:10','TODO',2,2,4),(25,8,'Hello Test 2','',NULL,'2026-05-10 17:42:21','TODO',2,2,3),(26,8,'Hello Test 3','',NULL,'2026-05-10 17:42:29','TODO',2,2,4),(27,8,'Hello Test 4','',NULL,'2026-05-10 17:42:39','TODO',2,2,5),(28,8,'Hello Test 5','',NULL,'2026-05-10 17:42:42','TODO',2,2,6),(29,8,'Hello Test 6','',NULL,'2026-05-10 17:42:45','TODO',2,2,7),(30,8,'Hello Test 7','',NULL,'2026-05-10 17:42:49','TODO',2,2,8),(31,8,'Hello Test 8','',NULL,'2026-05-10 17:42:53','TODO',2,2,3);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password_Hash` varchar(255) NOT NULL,
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sunny','Johl','indpaul.johl@sjsu.edu','9c47d564485498c5b507ae857c6b0468:2de6b994063959dc7cccd891a70f529add9290a93be783cf35c2c0605df5e1da','2026-03-15 19:26:23'),(2,'Eric','Tran','eric.tran06@sjsu.edu','f93a4e4e3d8c10cb029c952317ea1ded:9eb4187e520c01b335ecfcf1d822ae4ac0ae02cd7575a7be345d368354c45ded','2026-03-15 19:26:23'),(3,'Tehkhum','Sultanali','tehkhumhusein.sultanali@sjsu.edu','bf4cfb90d562c0a49ef2647c48a10b65:ba28cebeecbcd83d46b7439aae04f3217f2abcca0d96d09a0da2c668b6cd7f0e','2026-03-15 19:26:23'),(4,'Ava','Patel','ava.patel@sjsu.edu','f98b63ff2d32a4a205c2db18b238d33f:18cb50cdadd9046bf9326539d5fddc3fda08e396cf47f12e02913689890b4cd1','2026-03-15 19:32:42'),(5,'Liam','Nguyen','liam.nguyen@sjsu.edu','4cae7669202dfe4f6dd49884efe7f5a5:c6f99eda459e65d90372c54d3d62c9e62958d57252a0e37818d2cffb4c3e3dd4','2026-03-15 19:32:42'),(6,'Mia','Chen','mia.chen@sjsu.edu','41ad734233247023fb48a33033fba749:321182aaabff69afd5b52d4bf59a268b3920775d8e68269cddc74b67d536fc9b','2026-03-15 19:32:42'),(7,'Noah','Garcia','noah.garcia@sjsu.edu','3ba9a7fbecdea291e7942721b10f71cc:fe59fae67a1147c7653183e1617189e612b6045ef7ec36ecb356c28c9bbee48b','2026-03-15 19:32:42'),(8,'Emma','Kim','emma.kim@sjsu.edu','2f6a033d21f8aa7599bb796296df9357:493c3d973ea208927d98a49b38e4854dea8e0587cb8447052907f4ebc8c3b105','2026-03-15 19:32:42'),(9,'Ethan','Lopez','ethan.lopez@sjsu.edu','2bb39efaa5ebf1d1ffbfea817995c782:a3d708ed2481febd40cfa76ca43b022392c78cff12da7c7d7ed2388627adcb2f','2026-03-15 19:32:42'),(10,'Sophia','Singh','sophia.singh@sjsu.edu','fbe081d0daddf1845bcee932d922acdb:6b2412d05d30703b8ee233408314909fc8d30f4592b20cbdbb793cada50f07ad','2026-03-15 19:32:42'),(12,'Zachary','Ong','zachary.ong@sjsu.edu','b72ecc3817876ba0e3a5eddb81ca67ae:9dd0f8d22b36665d53020ba1fffca71d578ceef4fb439f4ab63de60235c0e73a','2026-04-28 19:53:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-15 18:26:14
