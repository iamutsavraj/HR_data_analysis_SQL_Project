/* HR Data Analysis using SQL */ 


/* Q1. Retrieve the total number of employees in the dataset.*/
SELECT count(EmployeeID) FROM general_data;


/* Q2. List all unique job roles in the dataset. */
select distinct(JobRole) FROM general_data;


/* Q3. Find the average age of employees. */
select avg(age) as average_age FROM general_data;


/* Q4. Retrieve the names and ages of employees who have worked at the company for more than 5 years. */
select `Emp Name` as Employee_Name,Age FROM general_data
where YearsAtCompany >5;


/* Q5. Get a count of employees grouped by their department. */
select Department,count(*) as Employee_count FROM general_data
group by Department;


/* Q6. List employees who have 'High' Job Satisfaction. */
select `Emp Name`as Employee_name,JobSatisfaction from general_data gd 
join employee_survey_data ed on ed.EmployeeID=gd.EmployeeID 
where ed.JobSatisfaction = 3;


/* Q7. Find the highest Monthly Income in the dataset. */
select max(MonthlyIncome) as Highest_monthly_income from general_data;


/* Q8. List employees who have 'Travel_Rarely' as their Business Travel type. */
select `Emp Name` as Employee_name,BusinessTravel from general_data
where BusinessTravel='Travel_Rarely';


/* Q9. Retrieve the distinct MaritalStatus categories in the dataset. */
select distinct(MaritalStatus) from general_data;


/* Q10. Get a list of employees with more than 2 years of 
work experience but less than 4 years in their current role. */
select EmployeeID,`Emp name` as Employee_name from general_data
where TotalWorkingYears >2 and YearsAtCompany <4;


/* Q11. List employees who have changed their job roles within the company (JobLevel andJobRole differ from their previous job) */
select * from general_data as current 
join general_data as previous on current.EmployeeID=previous.EmployeeID
where (current.JobRole<>previous.JobRole or previous.EmployeeID is null)
or (Current.JobLevel<>previous.JobLevel or previous.EmployeeID is null);


/* Q12. Find the average distance from home for employees in each department. */
select Department, round(avg(DistanceFromHome),2) as Avg_distance
from general_data group by Department;


/* Q13. Retrieve the top 5 employees with the highest MonthlyIncome. */
select EmployeeID, `Emp Name`as 'Top 5 Highest Paid Employee',
MonthlyIncome from general_data 
order by MonthlyIncome desc limit 5;


/* Q14. Calculate the percentage of employees who have had a promotion in the last year. */
select count(*) as Total_employees,
count(case when YearsSinceLastPromotion<=1 then 1 end) as 
Count_promotion_last_year, 
(count(case when YearsSinceLastPromotion<=1 then 1 end)*100/count(*))
as Percentage from general_data;


/* Q15. List the employees with the highest and lowest Environment Satisfaction. */
select gd.EmployeeID,`Emp Name` as Employee_name,EnvironmentSatisfaction
from general_data gd
join employee_survey_data as ed on ed.EmployeeID=gd.EmployeeID 
where ed.EnvironmentSatisfaction in
(select max(EnvironmentSatisfaction) from employee_survey_data union
select min(EnvironmentSatisfaction) from employee_survey_data);


/* Q16. Find the employees who have the same Job Role and Marital Status. */
select EmployeeId, `Emp Name` as Employee_Name, JobRole, MaritalStatus
from general_data as a where exists (select 1 from general_data as b
where a.EmployeeId<>b.EmployeeId and a.JobRole like b.JobRole and
a.MaritalStatus like b.MaritalStatus) order by JobRole,MaritalStatus,
EmployeeID;


/* Q17. List the employees with the highest Total Working Years who also have a PerformanceRating of 4. */
select gd.EmployeeID, gd.`Emp name` as Employee_name
from general_data gd join manager_survey_data md on 
gd.EmployeeID = md.EmployeeID where md.PerformanceRating=4 and 
gd.TotalWorkingYears= (select max(TotalWorkingYears) from general_data
where EmployeeId in (select EmployeeId from manager_survey_data where 
PerformanceRating =4));


/* Q18. Calculate the average Age and Job Satisfaction for each Business Travel type.*/
select BusinessTravel,Avg(age) as Average_age, avg(ed.JobSatisfaction)
as Average_Job_satisfaction from general_data gd 
join employee_survey_data ed on gd.EmployeeId=ed.EmployeeId 
group by BusinessTravel;


/* Q19. Retrieve the most common EducationField among employees. */
select EducationField,count(EducationField) as most_common_field
from general_data group by EducationField
order by most_common_field desc limit 1;


/* Q20. List the employees who have worked for the company the longest but haven't had a promotion. */
select EmployeeId, `Emp Name`as Employee_name,YearsAtCompany,
YearsSinceLastPromotion from general_data
where YearsAtCompany in (select max(YearsAtCompany) from general_data
where YearsSinceLastPromotion=0) and YearsSinceLastPromotion=0;

/*       End Query      */
