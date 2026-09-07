use hr_project ;
select * from category;

USE hr_project;

CREATE OR REPLACE VIEW MangerStatus AS
SELECT 
    ManagerID,
    MAX(ManagerName) AS ManagerName,
    MAX(DeptID) AS DeptID,
    Department ,
    COUNT(EmpID) AS Total_employee_under_manager,
    COUNT (CASE WHEN
    EmploymentStatus IN('Resinged','Terminated')
    THEN EmpID END) AS Resigned_or_Terminated_Count,
     COUNT (CASE WHEN
    EmploymentStatus IN('Active')
    THEN EmpID END) AS Current_Employee_Count,
   ROUND(AVG(EmpSatisfaction),2) AS Avg_EmpSatisfaction,
    ROUND(AVG(EngagementSurvey),2) AS Avg_EngagementSurvey,
    ROUND(AVG(PerformanceScoreRank),2) AS Avg_PerformanceScoreRank,
    ROUND(AVG(Category_score),2) AS Avg_Category_score-- FINDING THE CATOGRY O
FROM category
GROUP BY ManagerID, 
    DeptID, 
    Department;