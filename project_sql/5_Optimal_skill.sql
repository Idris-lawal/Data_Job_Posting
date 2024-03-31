/*5.  What are the ost optimal skills to learn
        . Ptimal: High Demandin  and High paying*/


/*
    - identify skills in high demand and associated with high average salaries for data analysts
    - concentrates on remote position with specified salary
    -why? Target skills that offer job security(high demand) and financial benefit(High Salaries)
            offering strategic insights for career development in data analysis
*/
 -- METHOD 1 with CTE
WITH SKill_DemandCTE AS (
    SELECT c.skill_id,
        c.skills,
        Count(a.job_id) as demand_Count
    FROM job_postings_fact A
        INNER JOIN skills_job_dim B ON a.job_id = b.job_id
        INNER JOIN skills_dim C ON b.skill_id = c.skill_id
    where job_work_from_home = TRUE
        AND job_title_short = 'Data Analyst'
        and salary_year_avg is not NULL
    GROUP BY c.skill_id,
        c.skills
),
Average_SalaryCTE AS (
    SELECT c.skill_id,
        c.skills,
        round(AVG(salary_year_avg), 2) as averageSalary
    FROM job_postings_fact A
        INNER JOIN skills_job_dim B ON a.job_id = b.job_id
        INNER JOIN skills_dim C ON b.skill_id = c.skill_id
    where job_work_from_home = TRUE
        AND job_title_short = 'Data Analyst'
        and salary_year_avg is not NULL
    GROUP BY c.skill_id,
        c.skills
)
SELECT a.skill_id,
    a.skills,
    demand_Count,
    averageSalary
FROM SKill_DemandCTE A
    inner join Average_SalaryCTE B ON a.skill_id = b.skill_id
WHERE demand_Count > 10
ORDER by demand_count desc ,
         averageSalary DESC
LIMIT 25
;


---METHOD 2 


SELECT c.skill_id,c.skills,
        Count(a.job_id) as demand_Count,
        round(AVG(salary_year_avg)) as AverageSalary
FROM job_postings_fact A 
INNER JOIN skills_job_dim B ON a.job_id = b.job_id
INNER JOIN skills_dim C ON b.skill_id = c.skill_id
where job_work_from_home = TRUE AND
      job_title_short = 'Data Analyst' 
    
GROUP BY c.skills,c.skill_id
HAVING Count(a.job_id) > 10
ORDER BY demand_Count DESC,AverageSalary DESC
LIMIT 25;
