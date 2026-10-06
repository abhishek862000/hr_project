HR Employee Analytics & Retention AnalysisAn end-to-end People Analytics project analyzing employee satisfaction, engagement, performance metrics, and manager spans of control to uncover the root causes driving employee turnover.Executive SummaryAnalyzing organizational data across 311 employees and 21 managers revealed an overall turnover rate of 28.30% (88 resignations or terminations). While baseline satisfaction scores appear overall healthy (3.87/5 average), granular SQL view transformations and Power BI visualization uncovered critical retention risks hidden beneath surface-level averages.   Key InsightsProduction Holds the Highest Retention Concern: Production accounts for 75 of the company's 88 total exits, driving a department resignation rate of 35.89%.   Satisfaction Alone Does Not Predict Retention: Production and IT/IS report nearly identical satisfaction scores (3.87 vs 3.86), yet Production experiences triple the turnover rate of IT/IS (35.89% vs 12.00%).   High-Performer Flight in Software Engineering: Software Engineering exhibits top-tier satisfaction (4.0/5) and performance (4.4/5), yet suffers from a high 27.27% resignation rate.   Manager Bandwidth Discrepancy: Production operates at an unsustainable span of control with 20.9 employees per manager, compared to IT/IS (8.33) and Sales (7.75).Sales Model Success: Sales maintains the lowest turnover among major departments at 9.68% alongside a 3.99/5 satisfaction rating.   Key Metrics SummaryDepartmentTotal EmployeesExited EmployeesResignation RateAvg SatisfactionAvg Performance ScoreProduction2097535.89%3.94.2   IT/IS50612.00%3.94.3   Sales3139.68%4.04.1   Software Engineering11327.27%4.04.4   Admin Offices9111.11%3.44.7   Executive Office100.00%3.05.0   Total / Overall3118828.30%3.874.26   Employee Distribution MatrixEmployees are categorized based on their combined Performance Score Rank and Engagement Survey Score:CategoryCriteria / LogicCountStatusStar EmployeePerformance $\ge$ 4 AND Engagement $\ge$ 4242High Performers / Retain   RiskPerformance = 3 OR Engagement = 343Flight Risk Monitor   Training RequiredPerformance $\le$ 2 AND Engagement $\le$ 219Skill Development Needed   Needs AttentionPerformance $\le$ 2 AND Engagement $\ge$ 47Underperforming / Motivated   SQL Database Architecture & ViewsThe project transforms raw employee transactional records into structured analytical views using MySQL.1. Performance ViewStandardizes text-based performance evaluation categories into numerical rankings (1–5) and rounds engagement scores.SQLUSE hr_project;

CREATE OR REPLACE VIEW Performance AS
SELECT 
    EmpID, 
    `ï»¿Employee_Name`,
    Department,
    DeptID,
    ManagerID, 
    ManagerName, 
    EmpSatisfaction,
    EmploymentStatus,
    PerformanceScore, 
    ROUND(EngagementSurvey) AS EngagementSurvey,
    CASE LOWER(TRIM(PerformanceScore))
        WHEN 'Exceeds' THEN 5
        WHEN 'Fully Meets' THEN 4
        WHEN 'average' THEN 3
        WHEN 'Needs Improvement' THEN 2
        WHEN 'PIP' THEN 1
        ELSE NULL
    END AS PerformanceScoreRank
FROM employedata;
2. category ViewCategorizes employees and assigns weighted scoring metrics based on performance and engagement cross-tabulation.SQLUSE hr_project;

CREATE OR REPLACE VIEW category AS
SELECT 
    EmpID, 
    `ï»¿Employee_Name`, 
    ManagerID, 
    Department,
    DeptID,
    ManagerName, 
    EmpSatisfaction,
    EmploymentStatus,
    PerformanceScore,
    EngagementSurvey, 
    PerformanceScoreRank,
    CASE  
        WHEN PerformanceScoreRank >= 4 AND EngagementSurvey >= 4 THEN 'StarEmployee'
        WHEN PerformanceScoreRank >= 4 AND EngagementSurvey <= 2 THEN 'At-Risk Performer'
        WHEN PerformanceScoreRank <= 2 AND EngagementSurvey >= 4 THEN 'Needs Attention'
        WHEN PerformanceScoreRank <= 2 AND EngagementSurvey <= 2 THEN 'Training Required'
        WHEN PerformanceScoreRank = 3 OR EngagementSurvey = 3 THEN 'Risk'
        ELSE 'Missing / Invalid Data'
    END AS Category,
    CASE 
        WHEN PerformanceScoreRank >= 4 AND EngagementSurvey >= 4 THEN 5
        WHEN PerformanceScoreRank >= 4 AND EngagementSurvey <= 2 THEN 4
        WHEN PerformanceScoreRank <= 2 AND EngagementSurvey >= 4 THEN 3
        WHEN PerformanceScoreRank <= 2 AND EngagementSurvey <= 2 THEN 2
        WHEN PerformanceScoreRank = 3 OR EngagementSurvey = 3 THEN 1
        ELSE 'Missing / Invalid Data'
    END AS Category_score
FROM Performance;
3. DepartmentStatus ViewAggregates departmental totals, headcount splits (Active vs. Resigned/Terminated), and average engagement metrics.SQLUSE hr_project;

CREATE OR REPLACE VIEW DepartmentStatus AS
SELECT 
    MAX(DeptID) AS DeptID,
    Department,
    COUNT(EmpID) AS Total_employee_under_manager,
    COUNT(CASE WHEN EmploymentStatus IN ('Resigned', 'Terminated') THEN EmpID END) AS Resigned_or_Terminated_Count,
    COUNT(CASE WHEN EmploymentStatus = 'Active' THEN EmpID END) AS Current_Employee_Count,
    ROUND(AVG(EmpSatisfaction), 2) AS Avg_EmpSatisfaction,
    ROUND(AVG(EngagementSurvey), 2) AS Avg_EngagementSurvey,
    ROUND(AVG(PerformanceScoreRank), 2) AS Avg_PerformanceScoreRank,
    ROUND(AVG(Category_score), 2) AS Avg_Category_score
FROM category
GROUP BY DeptID, Department;
4. MangerStatus ViewEvaluates managerial span of control and team attrition metrics across individual managers.SQLUSE hr_project;

CREATE OR REPLACE VIEW MangerStatus AS
SELECT 
    ManagerID,
    MAX(ManagerName) AS ManagerName,
    MAX(DeptID) AS DeptID,
    Department,
    COUNT(EmpID) AS Total_employee_under_manager,
    COUNT(CASE WHEN EmploymentStatus IN ('Resigned', 'Terminated') THEN EmpID END) AS Resigned_or_Terminated_Count,
    COUNT(CASE WHEN EmploymentStatus = 'Active' THEN EmpID END) AS Current_Employee_Count,
    ROUND(AVG(EmpSatisfaction), 2) AS Avg_EmpSatisfaction,
    ROUND(AVG(EngagementSurvey), 2) AS Avg_EngagementSurvey,
    ROUND(AVG(PerformanceScoreRank), 2) AS Avg_PerformanceScoreRank,
    ROUND(AVG(Category_score), 2) AS Avg_Category_score
FROM category
GROUP BY ManagerID, DeptID, Department;
Repository StructurePlaintexthr_project/
├── SQL/
│   ├── 01_performance_view.sql
│   ├── 02_category_view.sql
│   ├── 03_department_status_view.sql
│   └── 04_manager_status_view.sql
├── Dashboard/
│   └── HR_Analytics_Dashboard.pbix
├── Data/
│   └── raw_employee_data.csv
└── README.md
How to RunPrerequisitesMySQL Server 8.0+ / MySQL WorkbenchPower BI Desktop