use prformance;
select * from performance;
use hr_project ;
create or REPLACE VIEW category AS
select EmpID, ï»¿Employee_Name, ManagerID, Department ,DeptID,
         ManagerName, EmpSatisfaction,
EmploymentStatus,PerformanceScore,
 EngagementSurvey, PerformanceScoreRank,
 case-- category of arranging  
when PerformanceScoreRank >=4 AND EngagementSurvey >=4  THEN 'StarEmployee'
when PerformanceScoreRank >=4 AND EngagementSurvey <=2   THEN 'At-Risk Performer'
when PerformanceScoreRank <=2 AND EngagementSurvey >=4 THEN 'Needs Attention'
when PerformanceScoreRank<=2 AND EngagementSurvey <=2 THEN  'Training Required'
when PerformanceScoreRank=3 or EngagementSurvey =3 THEN 'Risk'
ELSE 'Missing / Invalid Data'
 END AS Category,
 case-- ranking the score
when PerformanceScoreRank >=4 AND EngagementSurvey >=4  THEN 5
when PerformanceScoreRank >=4 AND EngagementSurvey <=2   THEN 4
when PerformanceScoreRank <=2 AND EngagementSurvey >=4 THEN 3
when PerformanceScoreRank<=2 AND EngagementSurvey <=2 THEN  2
when PerformanceScoreRank=3 or EngagementSurvey =3 THEN 1
ELSE 'Missing / Invalid Data'
 END AS Category_score
 from performance;

 select count(* )from category;