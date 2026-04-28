-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: team14
-- ------------------------------------------------------
-- Server version	8.0.45

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` VALUES (1,1,1,'CREATE','Project',1,'2026-03-15 20:47:28'),(2,2,2,'CREATE','Project',2,'2026-03-15 20:47:28'),(3,3,3,'CREATE','Project',3,'2026-03-15 20:47:28'),(4,1,1,'ADD_MEMBER','User',4,'2026-03-15 20:47:28'),(5,1,1,'ADD_MEMBER','User',5,'2026-03-15 20:47:28'),(6,1,1,'ADD_MEMBER','User',6,'2026-03-15 20:47:28'),(7,2,2,'ADD_MEMBER','User',7,'2026-03-15 20:47:28'),(8,2,2,'ADD_MEMBER','User',8,'2026-03-15 20:47:28'),(9,3,3,'ADD_MEMBER','User',10,'2026-03-15 20:47:28'),(10,3,3,'ADD_MEMBER','User',9,'2026-03-15 20:47:28'),(11,1,1,'CREATE','Task',1,'2026-03-15 20:47:28'),(12,1,1,'CREATE','Task',2,'2026-03-15 20:47:28'),(13,1,1,'CREATE','Task',3,'2026-03-15 20:47:28'),(14,1,1,'CREATE','Task',4,'2026-03-15 20:47:28'),(15,1,1,'CREATE','Task',5,'2026-03-15 20:47:28'),(16,2,2,'CREATE','Task',6,'2026-03-15 20:47:28'),(17,2,2,'CREATE','Task',7,'2026-03-15 20:47:28'),(18,2,2,'CREATE','Task',8,'2026-03-15 20:47:28'),(19,3,3,'CREATE','Task',11,'2026-03-15 20:47:28'),(20,3,3,'CREATE','Task',15,'2026-03-15 20:47:28'),(21,1,1,'ASSIGN','Task',1,'2026-03-15 20:47:28'),(22,1,1,'ASSIGN','Task',3,'2026-03-15 20:47:28'),(23,2,2,'ASSIGN','Task',6,'2026-03-15 20:47:28'),(24,2,2,'ASSIGN','Task',8,'2026-03-15 20:47:28'),(25,3,3,'ASSIGN','Task',12,'2026-03-15 20:47:28'),(26,3,3,'ASSIGN','Task',15,'2026-03-15 20:47:28'),(27,1,2,'COMMENT','Task',1,'2026-03-15 20:47:28'),(28,1,1,'COMMENT','Task',2,'2026-03-15 20:47:28'),(29,2,6,'COMMENT','Task',6,'2026-03-15 20:47:28'),(30,3,3,'COMMENT','Task',15,'2026-03-15 20:47:28');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `Task_ID` int NOT NULL,
  `Attachment_Number` int NOT NULL,
  `File_Name` varchar(255) NOT NULL,
  `File_URL` text NOT NULL,
  `Uploaded_By` int NOT NULL,
  `Uploaded_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Task_ID`,`Attachment_Number`),
  KEY `Uploaded_By` (`Uploaded_By`),
  CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`Task_ID`) REFERENCES `tasks` (`Task_ID`) ON DELETE CASCADE,
  CONSTRAINT `attachments_ibfk_2` FOREIGN KEY (`Uploaded_By`) REFERENCES `users` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES (1,1,'ddl_script.sql','https://example.com/ddl_script.sql',1,'2026-03-15 20:38:25'),(1,2,'schema_notes.txt','https://example.com/schema_notes.txt',2,'2026-03-15 20:38:25'),(3,1,'users_seed.csv','https://example.com/users_seed.csv',4,'2026-03-15 20:38:25'),(5,1,'screenshot_checklist.pdf','https://example.com/screenshot_checklist.pdf',5,'2026-03-15 20:38:25'),(6,1,'fk_test_results.txt','https://example.com/fk_test_results.txt',6,'2026-03-15 20:38:25'),(8,1,'assignments_seed.csv','https://example.com/assignments_seed.csv',8,'2026-03-15 20:38:25'),(9,1,'comments_seed.csv','https://example.com/comments_seed.csv',10,'2026-03-15 20:38:25'),(10,1,'attachment_links.txt','https://example.com/attachment_links.txt',1,'2026-03-15 20:38:25'),(12,1,'notification_templates.txt','https://example.com/notification_templates.txt',7,'2026-03-15 20:38:25'),(15,1,'final_review.md','https://example.com/final_review.md',3,'2026-03-15 20:38:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,2,'Tables created successfully in team14.','2026-03-15 20:21:25'),(2,2,1,'Trigger added. Creator auto becomes ADMIN.','2026-03-15 20:21:25'),(3,3,4,'Inserted 10 users for the demo dataset.','2026-03-15 20:21:25'),(4,5,5,'Next step: screenshot SELECT outputs for all tables.','2026-03-15 20:21:25'),(5,6,6,'FK constraints validated for Projects/Users/Tasks.','2026-03-15 20:21:25'),(6,7,7,'Membership roles set correctly per project.','2026-03-15 20:21:25'),(7,8,8,'Task_Assignments populated (many-to-many).','2026-03-15 20:21:25'),(8,9,10,'Comments added so Tasks show collaboration.','2026-03-15 20:21:25'),(9,10,1,'Attachments added with placeholder URLs.','2026-03-15 20:21:25'),(10,15,3,'Final review: ensure all tables have rows for screenshots.','2026-03-15 20:21:25');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labels`
--

DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labels` (
  `Task_ID` int NOT NULL,
  `Label_Name` varchar(40) NOT NULL,
  `Color_Code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Task_ID`,`Label_Name`),
  CONSTRAINT `labels_ibfk_1` FOREIGN KEY (`Task_ID`) REFERENCES `tasks` (`Task_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labels`
--

LOCK TABLES `labels` WRITE;
/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
INSERT INTO `labels` VALUES (1,'Database','#2a9d8f'),(5,'Screenshots','#e9c46a'),(8,'Assignments','#f4a261'),(12,'Notifications','#264653'),(15,'Final','#e76f51');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,4,'You were added to TaskMe Web App as MEMBER.',0,'2026-03-15 20:13:26','Project',1),(2,5,'You were added to TaskMe Web App as COMMENT_ONLY.',0,'2026-03-15 20:13:26','Project',1),(3,6,'You were added to TaskMe Web App as MEMBER.',0,'2026-03-15 20:13:26','Project',1),(4,7,'You were added to Database Demo Pack as MEMBER.',0,'2026-03-15 20:13:26','Project',2),(5,8,'You were added to Database Demo Pack as MEMBER.',0,'2026-03-15 20:13:26','Project',2),(6,10,'You were added to Workflow Simulation as COMMENT_ONLY.',0,'2026-03-15 20:13:26','Project',3),(7,9,'You were added to Workflow Simulation as MEMBER.',0,'2026-03-15 20:13:26','Project',3),(8,1,'Task assigned: Create Tables',0,'2026-03-15 20:13:26','Task',1),(9,1,'Task assigned: Add Trigger',1,'2026-03-15 20:13:26','Task',2),(10,2,'Task assigned: Insert Sample Users',0,'2026-03-15 20:13:26','Task',3),(11,4,'Task assigned: Insert Sample Projects',0,'2026-03-15 20:13:26','Task',4),(12,5,'Task assigned: Capture Screenshots',0,'2026-03-15 20:13:26','Task',5),(13,2,'Task assigned: Validate FKs',1,'2026-03-15 20:13:26','Task',6),(14,6,'Task assigned: Insert Memberships',0,'2026-03-15 20:13:26','Task',7),(15,7,'Task assigned: Create Assignments',0,'2026-03-15 20:13:26','Task',8),(16,8,'Task assigned: Add Comments',0,'2026-03-15 20:13:26','Task',9),(17,10,'Task assigned: Add Attachments',0,'2026-03-15 20:13:26','Task',10),(18,3,'Task assigned: Final Review',0,'2026-03-15 20:13:26','Task',15);
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
INSERT INTO `project_memberships` VALUES (1,1,'ADMIN','2026-03-15 19:57:47'),(1,4,'MEMBER','2026-03-15 19:57:47'),(1,5,'COMMENT_ONLY','2026-03-15 19:57:47'),(1,6,'MEMBER','2026-03-15 19:57:47'),(2,2,'ADMIN','2026-03-15 19:57:47'),(2,7,'MEMBER','2026-03-15 19:57:47'),(2,8,'MEMBER','2026-03-15 19:57:47'),(3,3,'ADMIN','2026-03-15 19:57:47'),(3,9,'MEMBER','2026-03-15 19:57:47'),(3,10,'COMMENT_ONLY','2026-03-15 19:57:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'TaskMe Web App','Build TaskMe tables + demo data','2026-04-10 17:00:00','2026-03-15 19:26:23',1),(2,'Database Demo Pack','Populate tables for Workbench screenshots','2026-04-12 17:00:00','2026-03-15 19:26:23',2),(3,'Workflow Simulation','Simulate team workflow with logs/notifications','2026-04-15 17:00:00','2026-03-15 19:26:23',3);
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
INSERT INTO `task_assignments` VALUES (1,1,'2026-03-15 19:57:42'),(2,1,'2026-03-15 19:57:42'),(3,2,'2026-03-15 19:57:42'),(4,4,'2026-03-15 19:57:42'),(5,5,'2026-03-15 19:57:42'),(6,2,'2026-03-15 19:57:42'),(7,6,'2026-03-15 19:57:42'),(8,7,'2026-03-15 19:57:42'),(9,8,'2026-03-15 19:57:42'),(10,10,'2026-03-15 19:57:42'),(11,3,'2026-03-15 19:57:42'),(12,1,'2026-03-15 19:57:42'),(13,2,'2026-03-15 19:57:42'),(14,6,'2026-03-15 19:57:42'),(15,7,'2026-03-15 19:57:42');
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
  PRIMARY KEY (`Task_ID`),
  KEY `Project_ID` (`Project_ID`),
  KEY `Created_By` (`Created_By`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`Created_By`) REFERENCES `users` (`User_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Create Tables','Run DDL to create tables + keys','2026-03-20 23:59:59','2026-03-15 19:44:02','DONE',3,1),(2,1,'Add Trigger','Creator auto-admin trigger','2026-03-21 23:59:59','2026-03-15 19:44:02','DONE',2,1),(3,1,'Insert Sample Users','Add 10 users for demo','2026-03-22 23:59:59','2026-03-15 19:44:02','IN_PROGRESS',2,1),(4,1,'Insert Sample Projects','Add 3 projects for demo','2026-03-22 23:59:59','2026-03-15 19:44:02','TODO',2,1),(5,1,'Capture Screenshots','Run SELECT * and screenshot','2026-03-25 23:59:59','2026-03-15 19:44:02','TODO',3,1),(6,2,'Validate FKs','Ensure FK constraints work','2026-03-23 23:59:59','2026-03-15 19:44:02','IN_PROGRESS',2,2),(7,2,'Insert Memberships','Add project membership roles','2026-03-23 23:59:59','2026-03-15 19:44:02','TODO',2,2),(8,2,'Create Assignments','Populate Task_Assignments','2026-03-24 23:59:59','2026-03-15 19:49:43','TODO',2,2),(9,2,'Add Comments','Add comment rows for demo','2026-03-24 23:59:59','2026-03-15 19:49:43','TODO',2,2),(10,2,'Add Attachments','Add attachments for demo','2026-03-25 23:59:59','2026-03-15 19:49:43','TODO',1,2),(11,3,'Create Labels','Add labels to tasks','2026-03-26 23:59:59','2026-03-15 19:49:43','TODO',1,3),(12,3,'Generate Notifications','Add notifications for events','2026-03-26 23:59:59','2026-03-15 19:49:43','TODO',2,3),(13,3,'Write Activity Logs','Insert audit log rows','2026-03-27 23:59:59','2026-03-15 19:49:43','TODO',2,3),(14,3,'Role Testing','Verify ADMIN/MEMBER/COMMENT_ONLY','2026-03-28 23:59:59','2026-03-15 19:49:43','TODO',2,3),(15,3,'Final Review','Final pass for demo','2026-03-30 23:59:59','2026-03-15 19:49:43','TODO',3,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sunny','Johl','indpaul.johl@sjsu.edu','hash1','2026-03-15 19:26:23'),(2,'Eric','Tran','eric.tran06@sjsu.edu','hash2','2026-03-15 19:26:23'),(3,'Tehkhum','Sultanali','tehkhumhusein.sultanali@sjsu.edu','hash3','2026-03-15 19:26:23'),(4,'Ava','Patel','ava.patel@sjsu.edu','hash4','2026-03-15 19:32:42'),(5,'Liam','Nguyen','liam.nguyen@sjsu.edu','hash5','2026-03-15 19:32:42'),(6,'Mia','Chen','mia.chen@sjsu.edu','hash6','2026-03-15 19:32:42'),(7,'Noah','Garcia','noah.garcia@sjsu.edu','hash7','2026-03-15 19:32:42'),(8,'Emma','Kim','emma.kim@sjsu.edu','hash8','2026-03-15 19:32:42'),(9,'Ethan','Lopez','ethan.lopez@sjsu.edu','hash9','2026-03-15 19:32:42'),(10,'Sophia','Singh','sophia.singh@sjsu.edu','hash10','2026-03-15 19:32:42');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-08 17:50:06
