-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hr_project
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `category`
--

DROP TABLE IF EXISTS `category`;
/*!50001 DROP VIEW IF EXISTS `category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `category` AS SELECT 
 1 AS `EmpID`,
 1 AS `ï»¿Employee_Name`,
 1 AS `ManagerID`,
 1 AS `Department`,
 1 AS `DeptID`,
 1 AS `ManagerName`,
 1 AS `EmpSatisfaction`,
 1 AS `EmploymentStatus`,
 1 AS `PerformanceScore`,
 1 AS `EngagementSurvey`,
 1 AS `PerformanceScoreRank`,
 1 AS `Category`,
 1 AS `Category_score`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `category`
--

/*!50001 DROP VIEW IF EXISTS `category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `category` AS select `performance`.`EmpID` AS `EmpID`,`performance`.`ï»¿Employee_Name` AS `ï»¿Employee_Name`,`performance`.`ManagerID` AS `ManagerID`,`performance`.`Department` AS `Department`,`performance`.`DeptID` AS `DeptID`,`performance`.`ManagerName` AS `ManagerName`,`performance`.`EmpSatisfaction` AS `EmpSatisfaction`,`performance`.`EmploymentStatus` AS `EmploymentStatus`,`performance`.`PerformanceScore` AS `PerformanceScore`,`performance`.`EngagementSurvey` AS `EngagementSurvey`,`performance`.`PerformanceScoreRank` AS `PerformanceScoreRank`,(case when ((`performance`.`PerformanceScoreRank` >= 4) and (`performance`.`EngagementSurvey` >= 4)) then 'StarEmployee' when ((`performance`.`PerformanceScoreRank` >= 4) and (`performance`.`EngagementSurvey` <= 2)) then 'At-Risk Performer' when ((`performance`.`PerformanceScoreRank` <= 2) and (`performance`.`EngagementSurvey` >= 4)) then 'Needs Attention' when ((`performance`.`PerformanceScoreRank` <= 2) and (`performance`.`EngagementSurvey` <= 2)) then 'Training Required' when ((`performance`.`PerformanceScoreRank` = 3) or (`performance`.`EngagementSurvey` = 3)) then 'Risk' else 'Missing / Invalid Data' end) AS `Category`,(case when ((`performance`.`PerformanceScoreRank` >= 4) and (`performance`.`EngagementSurvey` >= 4)) then 5 when ((`performance`.`PerformanceScoreRank` >= 4) and (`performance`.`EngagementSurvey` <= 2)) then 4 when ((`performance`.`PerformanceScoreRank` <= 2) and (`performance`.`EngagementSurvey` >= 4)) then 3 when ((`performance`.`PerformanceScoreRank` <= 2) and (`performance`.`EngagementSurvey` <= 2)) then 2 when ((`performance`.`PerformanceScoreRank` = 3) or (`performance`.`EngagementSurvey` = 3)) then 1 else 'Missing / Invalid Data' end) AS `Category_score` from `performance` */;
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

-- Dump completed on 2026-09-07 21:41:30
