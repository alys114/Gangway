-- MySQL dump 10.13  Distrib 5.5.55, for Linux (x86_64)
--
-- Host: localhost    Database: ganway_db
-- ------------------------------------------------------
-- Server version	5.5.55-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_profile_id` int(11) NOT NULL,
  `bind_host_id` int(11) NOT NULL,
  `action_type` varchar(64) DEFAULT NULL,
  `op_date` datetime DEFAULT NULL,
  `cmd` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_profile_id` (`user_profile_id`),
  KEY `bind_host_id` (`bind_host_id`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_profile_id`) REFERENCES `user_profile` (`id`),
  CONSTRAINT `audit_log_ibfk_2` FOREIGN KEY (`bind_host_id`) REFERENCES `bind_host` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,4,1,'login','2017-12-04 20:37:26',NULL),(2,4,1,'cmd','2017-12-04 20:37:30','df -h'),(3,4,2,'login','2017-12-04 20:37:34',NULL),(4,4,2,'cmd','2017-12-04 20:37:41','ifconfig eth0'),(5,4,3,'login','2017-12-04 20:37:46',NULL),(6,4,3,'cmd','2017-12-04 20:37:54','echo \'\'[D[Daa[Caa'),(7,2,1,'login','2017-12-04 20:42:43',NULL),(8,2,1,'cmd','2017-12-04 20:42:59','tail /et/cc/passwd'),(9,3,2,'login','2017-12-04 20:47:34',NULL),(10,3,2,'cmd','2017-12-04 20:47:41','iffconfig eth1');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bind_host`
--

DROP TABLE IF EXISTS `bind_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bind_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_id` int(11) DEFAULT NULL,
  `remoteuser_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `_host_remoteuser_uc` (`host_id`,`remoteuser_id`),
  KEY `remoteuser_id` (`remoteuser_id`),
  CONSTRAINT `bind_host_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `host` (`id`),
  CONSTRAINT `bind_host_ibfk_2` FOREIGN KEY (`remoteuser_id`) REFERENCES `remote_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bind_host`
--

LOCK TABLES `bind_host` WRITE;
/*!40000 ALTER TABLE `bind_host` DISABLE KEYS */;
INSERT INTO `bind_host` VALUES (1,1,1),(5,1,3),(2,2,2),(6,2,3),(3,3,1),(7,3,3);
/*!40000 ALTER TABLE `bind_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bindhost_m2m_hostgroup`
--

DROP TABLE IF EXISTS `bindhost_m2m_hostgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bindhost_m2m_hostgroup` (
  `bindhost_id` int(11) DEFAULT NULL,
  `hostgroup_id` int(11) DEFAULT NULL,
  KEY `bindhost_id` (`bindhost_id`),
  KEY `hostgroup_id` (`hostgroup_id`),
  CONSTRAINT `bindhost_m2m_hostgroup_ibfk_1` FOREIGN KEY (`bindhost_id`) REFERENCES `bind_host` (`id`),
  CONSTRAINT `bindhost_m2m_hostgroup_ibfk_2` FOREIGN KEY (`hostgroup_id`) REFERENCES `host_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bindhost_m2m_hostgroup`
--

LOCK TABLES `bindhost_m2m_hostgroup` WRITE;
/*!40000 ALTER TABLE `bindhost_m2m_hostgroup` DISABLE KEYS */;
INSERT INTO `bindhost_m2m_hostgroup` VALUES (1,1),(3,1),(2,2);
/*!40000 ALTER TABLE `bindhost_m2m_hostgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(64) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'RabbitMQ-90','10.0.0.90',22),(2,'Redis-70','10.0.0.70',22),(3,'MySQL-52','10.0.0.52',22);
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_group`
--

DROP TABLE IF EXISTS `host_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_group`
--

LOCK TABLES `host_group` WRITE;
/*!40000 ALTER TABLE `host_group` DISABLE KEYS */;
INSERT INTO `host_group` VALUES (1,'db'),(2,'dev');
/*!40000 ALTER TABLE `host_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_user`
--

DROP TABLE IF EXISTS `remote_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_type` varchar(255) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `_user_passwd_uc` (`auth_type`,`username`,`password`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_user`
--

LOCK TABLES `remote_user` WRITE;
/*!40000 ALTER TABLE `remote_user` DISABLE KEYS */;
INSERT INTO `remote_user` VALUES (1,'ssh-password','dba','666666'),(2,'ssh-password','dev','123456'),(3,'ssh-password','root','123456');
/*!40000 ALTER TABLE `remote_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_m2m_bindhost`
--

DROP TABLE IF EXISTS `user_m2m_bindhost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_m2m_bindhost` (
  `userprofile_id` int(11) DEFAULT NULL,
  `bindhost_id` int(11) DEFAULT NULL,
  KEY `userprofile_id` (`userprofile_id`),
  KEY `bindhost_id` (`bindhost_id`),
  CONSTRAINT `user_m2m_bindhost_ibfk_1` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`),
  CONSTRAINT `user_m2m_bindhost_ibfk_2` FOREIGN KEY (`bindhost_id`) REFERENCES `bind_host` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_m2m_bindhost`
--

LOCK TABLES `user_m2m_bindhost` WRITE;
/*!40000 ALTER TABLE `user_m2m_bindhost` DISABLE KEYS */;
INSERT INTO `user_m2m_bindhost` VALUES (3,2),(4,5),(4,6),(4,7);
/*!40000 ALTER TABLE `user_m2m_bindhost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (1,'dev008','111111'),(2,'dba007','111111'),(3,'tmp110','111111'),(4,'admin','888888');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userprofile_m2m_hostgroup`
--

DROP TABLE IF EXISTS `userprofile_m2m_hostgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userprofile_m2m_hostgroup` (
  `userprofile_id` int(11) DEFAULT NULL,
  `hostgroup_id` int(11) DEFAULT NULL,
  KEY `userprofile_id` (`userprofile_id`),
  KEY `hostgroup_id` (`hostgroup_id`),
  CONSTRAINT `userprofile_m2m_hostgroup_ibfk_1` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`),
  CONSTRAINT `userprofile_m2m_hostgroup_ibfk_2` FOREIGN KEY (`hostgroup_id`) REFERENCES `host_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userprofile_m2m_hostgroup`
--

LOCK TABLES `userprofile_m2m_hostgroup` WRITE;
/*!40000 ALTER TABLE `userprofile_m2m_hostgroup` DISABLE KEYS */;
INSERT INTO `userprofile_m2m_hostgroup` VALUES (1,2),(2,1);
/*!40000 ALTER TABLE `userprofile_m2m_hostgroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-04 21:00:05
