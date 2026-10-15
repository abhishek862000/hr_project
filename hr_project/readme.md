# HR Employee Analytics & Retention Analysis

An end-to-end People Analytics project analyzing employee satisfaction, engagement, performance metrics, and manager spans of control to uncover the root causes driving employee turnover.

---

## Executive Summary

Analyzing organizational data across 311 employees and 21 managers revealed an overall turnover rate of 28.30% (88 resignations or terminations). While baseline satisfaction scores appear overall healthy (3.87/5 average), granular SQL view transformations and Power BI visualization uncovered critical retention risks hidden beneath surface-level averages.

### Key Insights

* **Production Holds the Highest Retention Concern:** Production accounts for 75 of the company's 88 total exits, driving a department resignation rate of 35.89%.
* **Satisfaction Alone Does Not Predict Retention:** Production and IT/IS report nearly identical satisfaction scores (3.87 vs 3.86), yet Production experiences triple the turnover rate of IT/IS (35.89% vs 12.00%).
* **High-Performer Flight in Software Engineering:** Software Engineering exhibits top-tier satisfaction (4.0/5) and performance (4.4/5), yet suffers from a high 27.27% resignation rate.
* **Manager Bandwidth Discrepancy:** Production operates at an unsustainable span of control with **20.9 employees per manager**, compared to IT/IS (8.33) and Sales (7.75).
* **Sales Model Success:** Sales maintains the lowest turnover among major departments at 9.68% alongside a 3.99/5 satisfaction rating.

---

## Key Metrics Summary

| Department | Total Employees | Exited Employees | Resignation Rate | Avg Satisfaction | Avg Performance Score |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Production** | 209 | 75 | 35.89% | 3.9 | 4.2 |
| **IT/IS** | 50 | 6 | 12.00% | 3.9 | 4.3 |
| **Sales** | 31 | 3 | 9.68% | 4.0 | 4.1 |
| **Software Engineering** | 11 | 3 | 27.27% | 4.0 | 4.4 |
| **Admin Offices** | 9 | 1 | 11.11% | 3.4 | 4.7 |
| **Executive Office** | 1 | 0 | 0.00% | 3.0 | 5.0 |
| **Total / Overall** | **311** | **88** | **28.30%** | **3.87** | **4.26** |

---

## Employee Distribution Matrix

Employees are categorized based on their combined **Performance Score Rank** and **Engagement Survey Score**:

| Category | Criteria / Logic | Count | Status |
| :--- | :--- | :---: | :--- |
| **Star Employee** | Performance ≥ 4 AND Engagement ≥ 4 | 242 | High Performers / Retain |
| **Risk** | Performance = 3 OR Engagement = 3 | 43 | Flight Risk Monitor |
| **Training Required** | Performance ≤ 2 AND Engagement ≤ 2 | 19 | Skill Development Needed |
| **Needs Attention** | Performance ≤ 2 AND Engagement ≥ 4 | 7 | Underperforming / Motivated |

---

## SQL Database Architecture & Views

The project transforms raw employee transactional records into structured analytical views using MySQL.

### 1. Performance View
Standardizes text-based performance evaluation categories into numerical rankings (1–5) and rounds engagement scores.

```sql
USE hr_project;

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