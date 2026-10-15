<<<<<<< HEAD
HR Employee Analytics & Retention AnalysisAn end-to-end People Analytics project analyzing employee satisfaction, engagement, performance metrics, and manager spans of control to uncover the root causes driving employee turnover.Executive SummaryAnalyzing organizational data across 311 employees and 21 managers revealed an overall turnover rate of 28.30% (88 resignations or terminations). While baseline satisfaction scores appear overall healthy (3.87/5 average), granular SQL view transformations and Power BI visualization uncovered critical retention risks hidden beneath surface-level averages. Key InsightsProduction Holds the Highest Retention Concern: Production accounts for 75 of the company's 88 total exits, driving a department resignation rate of 35.89%. Satisfaction Alone Does Not Predict Retention: Production and IT/IS report nearly identical satisfaction scores (3.87 vs 3.86), yet Production experiences triple the turnover rate of IT/IS (35.89% vs 12.00%). High-Performer Flight in Software Engineering: Software Engineering exhibits top-tier satisfaction (4.0/5) and performance (4.4/5), yet suffers from a high 27.27% resignation rate. Manager Bandwidth Discrepancy: Production operates at an unsustainable span of control with 20.9 employees per manager, compared to IT/IS (8.33) and Sales (7.75).Sales Model Success: Sales maintains the lowest turnover among major departments at 9.68% alongside a 3.99/5 satisfaction rating. Key Metrics SummaryDepartmentTotal EmployeesExited EmployeesResignation RateAvg SatisfactionAvg Performance ScoreProduction2097535.89%3.94.2 IT/IS50612.00%3.94.3 Sales3139.68%4.04.1 Software Engineering11327.27%4.04.4 Admin Offices9111.11%3.44.7 Executive Office100.00%3.05.0 Total / Overall3118828.30%3.874.26 Employee Distribution MatrixEmployees are categorized based on their combined Performance Score Rank and Engagement Survey Score:CategoryCriteria / LogicCountStatusStar EmployeePerformance 
≥
 4 AND Engagement 
≥
 4242High Performers / Retain RiskPerformance = 3 OR Engagement = 343Flight Risk Monitor Training RequiredPerformance 
≤
 2 AND Engagement 
≤
 219Skill Development Needed Needs AttentionPerformance 
≤
 2 AND Engagement 
≥
 47Underperforming / Motivated SQL Database Architecture & ViewsThe project transforms raw employee transactional records into structured analytical views using MySQL.1. Performance ViewStandardizes text-based performance evaluation categories into numerical rankings (1–5) and rounds engagement scores.SQLUSE hr_project;

CREATE OR REPLACE VIEW Performance AS SELECT EmpID, ï»¿Employee_Name, Department, DeptID, ManagerID, ManagerName, EmpSatisfaction, EmploymentStatus, PerformanceScore, ROUND(EngagementSurvey) AS EngagementSurvey, CASE LOWER(TRIM(PerformanceScore)) WHEN 'Exceeds' THEN 5 WHEN 'Fully Meets' THEN 4 WHEN 'average' THEN 3 WHEN 'Needs Improvement' THEN 2 WHEN 'PIP' THEN 1 ELSE NULL END AS PerformanceScoreRank FROM employedata; 2. category ViewCategorizes employees and assigns weighted scoring metrics based on performance and engagement cross-tabulation.SQLUSE hr_project;

CREATE OR REPLACE VIEW category AS SELECT EmpID, ï»¿Employee_Name, ManagerID, Department, DeptID, ManagerName, EmpSatisfaction, EmploymentStatus, PerformanceScore, EngagementSurvey, PerformanceScoreRank, CASE
WHEN PerformanceScoreRank >= 4 AND EngagementSurvey >= 4 THEN 'StarEmployee' WHEN PerformanceScoreRank >= 4 AND EngagementSurvey <= 2 THEN 'At-Risk Performer' WHEN PerformanceScoreRank <= 2 AND EngagementSurvey >= 4 THEN 'Needs Attention' WHEN PerformanceScoreRank <= 2 AND EngagementSurvey <= 2 THEN 'Training Required' WHEN PerformanceScoreRank = 3 OR EngagementSurvey = 3 THEN 'Risk' ELSE 'Missing / Invalid Data' END AS Category, CASE WHEN PerformanceScoreRank >= 4 AND EngagementSurvey >= 4 THEN 5 WHEN PerformanceScoreRank >= 4 AND EngagementSurvey <= 2 THEN 4 WHEN PerformanceScoreRank <= 2 AND EngagementSurvey >= 4 THEN 3 WHEN PerformanceScoreRank <= 2 AND EngagementSurvey <= 2 THEN 2 WHEN PerformanceScoreRank = 3 OR EngagementSurvey = 3 THEN 1 ELSE 'Missing / Invalid Data' END AS Category_score FROM Performance; 3. DepartmentStatus ViewAggregates departmental totals, headcount splits (Active vs. Resigned/Terminated), and average engagement metrics.SQLUSE hr_project;

CREATE OR REPLACE VIEW DepartmentStatus AS SELECT MAX(DeptID) AS DeptID, Department, COUNT(EmpID) AS Total_employee_under_manager, COUNT(CASE WHEN EmploymentStatus IN ('Resigned', 'Terminated') THEN EmpID END) AS Resigned_or_Terminated_Count, COUNT(CASE WHEN EmploymentStatus = 'Active' THEN EmpID END) AS Current_Employee_Count, ROUND(AVG(EmpSatisfaction), 2) AS Avg_EmpSatisfaction, ROUND(AVG(EngagementSurvey), 2) AS Avg_EngagementSurvey, ROUND(AVG(PerformanceScoreRank), 2) AS Avg_PerformanceScoreRank, ROUND(AVG(Category_score), 2) AS Avg_Category_score FROM category GROUP BY DeptID, Department; 4. MangerStatus ViewEvaluates managerial span of control and team attrition metrics across individual managers.SQLUSE hr_project;

CREATE OR REPLACE VIEW MangerStatus AS SELECT ManagerID, MAX(ManagerName) AS ManagerName, MAX(DeptID) AS DeptID, Department, COUNT(EmpID) AS Total_employee_under_manager, COUNT(CASE WHEN EmploymentStatus IN ('Resigned', 'Terminated') THEN EmpID END) AS Resigned_or_Terminated_Count, COUNT(CASE WHEN EmploymentStatus = 'Active' THEN EmpID END) AS Current_Employee_Count, ROUND(AVG(EmpSatisfaction), 2) AS Avg_EmpSatisfaction, ROUND(AVG(EngagementSurvey), 2) AS Avg_EngagementSurvey, ROUND(AVG(PerformanceScoreRank), 2) AS Avg_PerformanceScoreRank, ROUND(AVG(Category_score), 2) AS Avg_Category_score FROM category GROUP BY ManagerID, DeptID, Department; Repository StructurePlaintexthr_project/ ├── SQL/ │ ├── 01_performance_view.sql │ ├── 02_category_view.sql │ ├── 03_department_status_view.sql │ └── 04_manager_status_view.sql ├── Dashboard/ │ └── HR_Analytics_Dashboard.pbix ├── Data/ │ └── raw_employee_data.csv └── README.md How to RunPrerequisitesMySQL Server 8.0+ / MySQL WorkbenchPower BI Desktop
=======
# HR Employee Attrition Analysis

End-to-end people analytics project using **MySQL 8** and **Power BI** to investigate employee performance, engagement, satisfaction, management structure, and employee turnover.

**Headline:** 88 of 311 employees resigned or were terminated? **No — according to the latest department table, 88 is the combined count of resigned or terminated employees.** The overall rate is 28.3%. Production accounts for 75 of these 88 exits, with a resignation/termination rate of 35.89%.

**Tech Stack:** MySQL 8 · Power BI Desktop · Excel/CSV

---

## Key Findings

| # | Finding | Evidence |
|---|---|---|
| 1 | **Production has the highest turnover burden** | 75 of 88 exits; 35.89% resignation/termination rate |
| 2 | **Employee satisfaction alone does not explain turnover** | Production has 3.87/5 satisfaction and a 35.89% exit rate, while IT has 3.86/5 satisfaction and a 12% rate |
| 3 | **Production managers have the largest teams** | 20.9 employees per manager, compared with 8.33 in IT and 7.75 in Sales |
| 4 | **Software Engineering has a high exit rate despite strong scores** | 27.27% exit rate, 4.44/5 average performance score, and 4.05/5 satisfaction |
| 5 | **Sales has the lowest exit rate among the larger departments** | 9.68% exit rate, 4.11/5 average performance, and 3.99/5 satisfaction |

## Department Summary

| Department | Employees | Managers | Employees per manager | Resigned or terminated | Exit rate | Avg. performance / 5 | Avg. satisfaction / 5 |
|---|---:|---:|---:|---:|---:|---:|---:|
| Production | 209 | 10 | 20.90 | 75 | 35.89% | 4.24 | 3.87 |
| IT | 50 | 6 | 8.33 | 6 | 12.00% | 4.34 | 3.86 |
| Sales | 31 | 4 | 7.75 | 3 | 9.68% | 4.11 | 3.99 |
| Software Engineering | 11 | 3 | 3.67 | 3 | 27.27% | 4.44 | 4.05 |
| Admin Office | 9 | 3 | 3.00 | 1 | 11.11% | 4.65 | 3.40 |
| Executive Office | 1 | 1 | 1.00 | 0 | 0.00% | 5.00 | 3.00 |
| **Whole organization** | **311** | **21** | **14.81** | **88** | **28.30%** | **4.26** | **3.87** |

*Note: The rate and exit-count columns above follow the supplied department table. Confirm whether the 88 exits include terminations before labelling the metric “resignation rate.”*

## Employee Segmentation

Employees are classified using their numeric performance rank (1–5) and rounded engagement score (1–5).

| Segment | Rule | Count |
|---|---|---:|
| Star Employee | Performance ≥ 4 and Engagement ≥ 4 | 242 |
| Risk | Performance = 3 or Engagement = 3 | 43 |
| Training Required | Performance ≤ 2 and Engagement ≤ 2 | 19 |
| Needs Attention | Performance ≤ 2 and Engagement ≥ 4 | 7 |
| At-Risk Performer | Performance ≥ 4 and Engagement ≤ 2 | 0 |

**Performance mapping:** `Exceeds` = 5, `Fully Meets` = 4, `Average` = 3, `Needs Improvement` = 2, `PIP` = 1.

## How It Works

```text
EmployeData (raw table)
    └── Performance
         └── Text rating converted to numeric rank
             and engagement score rounded
              └── category
                   ├── Employee segmentation
                   ├── DepartmentStatus
                   │    └── Headcount, exits, averages
                   └── MangerStatus
                        └── Team size and exits per manager
                             └── Power BI dashboard
```

## Repository Structure

```text
hr_project/
├── DashBoardHr.pbix
├── Dash board PDF/
│   └── hr resignion finding.pdf
├── Data and VIews/
│   ├── EmployeData.csv / .xlsx
│   ├── maintable.sql
│   └── views/
└── Qurries/
    ├── prefomence_score_rank.sql.sql
    ├── catogryPrefomence.sql.sql
    ├── department.sql.sql
    └── ratingMangerAvg.sql.sql
```

## How to Run

1. Install MySQL 8.0+ and Power BI Desktop.
2. Create the `hr_project` database and import `Data and VIews/maintable.sql`, or load `EmployeData.csv` into a table named `employedata`.
3. Run the SQL queries in `Qurries/` in the required dependency order: `prefomence_score_rank` → `catogryPrefomence` → `department` → `ratingMangerAvg`.
4. Open `DashBoardHr.pbix` and configure the data source to connect to your MySQL instance.

## Data Notes and Limitations

- **Exit definitions:** The source contains 207 Active, 88 Resigned, and 16 Terminated employees. Therefore, 88 represents resignations alone in the raw data, while 104 represents resignations plus terminations. Verify which definition your department table uses before publishing the 28.3% headline.
- **Data spelling:** The source uses `Resinged` for resigned employees.
- **Data quality:** Some values, such as `Terminated `, contain trailing spaces. One manager, Michael Albert, appears under two IDs, affecting the manager count.
- **Small departments:** Executive Office, Software Engineering, and Admin Office have small employee populations, so their rates can fluctuate substantially.
- **Analytical limitation:** The dataset is a single snapshot. The results identify associations and investigation priorities; they do not establish causal relationships.

## Author

**Abhishek MJ** · [GitHub Repository](https://github.com/abhishek862000/hr_project)
>>>>>>> 38cd813 (include all the newe updated readme)
