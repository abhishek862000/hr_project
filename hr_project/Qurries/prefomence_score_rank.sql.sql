use hr_project ;
select * from employedata;

use hr_project ;
create or REPLACE VIEW Performance AS
select EmpID, ï»¿Employee_Name,Department ,DeptID,ManagerID, ManagerName, EmpSatisfaction,EmploymentStatus,PerformanceScore, round(EngagementSurvey) AS EngagementSurvey,
    CASE LOWER(trim(PerformanceScore))
        WHEN 'Exceeds' THEN 5
        WHEN 'Fully Meets' THEN 4
        WHEN 'average' THEN 3
        WHEN 'Needs Improvement' THEN 2
        WHEN 'PIP' THEN 1
        ELSE NULL
        
    END AS PerformanceScoreRank
    from employedata;
        