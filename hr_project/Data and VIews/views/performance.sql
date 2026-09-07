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
-- Temporary view structure for view `performance`
--

DROP TABLE IF EXISTS `performance`;
/*!50001 DROP VIEW IF EXISTS `performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `performance` AS SELECT 
 1 AS `EmpID`,
 1 AS `ï»¿Employee_Name`,
 1 AS `Department`,
 1 AS `DeptID`,
 1 AS `ManagerID`,
 1 AS `ManagerName`,
 1 AS `EmpSatisfaction`,
 1 AS `EmploymentStatus`,
 1 AS `PerformanceScore`,
 1 AS `EngagementSurvey`,
 1 AS `PerformanceScoreRank`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `performance`
--

/*!50001 DROP VIEW IF EXISTS `performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `performance` AS select `employedata`.`EmpID` AS `EmpID`,`employedata`.`ï»¿Employee_Name` AS `ï»¿Employee_Name`,`employedata`.`Department` AS `Department`,`employedata`.`DeptID` AS `DeptID`,`employedata`.`ManagerID` AS `ManagerID`,`employedata`.`ManagerName` AS `ManagerName`,`employedata`.`EmpSatisfaction` AS `EmpSatisfaction`,`employedata`.`EmploymentStatus` AS `EmploymentStatus`,`employedata`.`PerformanceScore` AS `PerformanceScore`,round(`employedata`.`EngagementSurvey`,0) AS `EngagementSurvey`,(case lower(trim(`employedata`.`PerformanceScore`)) when 'Exceeds' then 5 when 'Fully Meets' then 4 when 'average' then 3 when 'Needs Improvement' then 2 when 'PIP' then 1 else NULL end) AS `PerformanceScoreRank` from `employedata` */;
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

-- Dump completed on 2026-09-07 21:42:20
