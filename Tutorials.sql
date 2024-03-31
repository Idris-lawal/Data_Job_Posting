-- January
CREATE TABLE january_Job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM Job_posted_date) = 1;

-- February
CREATE TABLE february_Job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM Job_posted_date) = 2;

-- March
CREATE TABLE march_Job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM Job_posted_date) = 3;


select * FROM
march_Job;


select
    job_title_short,
    job_location
FROM
    job_postings_fact;

/*
    label a new column as follows
    - 'Anywhere' jobs as 'Remote'
    - 'New York, NY' jobs as local
    - otherwise 'onsite'
*/

select
    count(job_id) As number_of_job,
    CASE
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'Local'
        else 'Onsite'
    end as Job_type
FROM
    job_postings_fact
WHERE  
    job_title_short = 'Data Analyst'
GROUP BY
    Job_type;


Select 
   count(job_id) As number_of_job,
    CASE
        when salary_year_avg <= 100000 then 'Low salary'
        when  salary_year_avg > 100000 and salary_year_avg <= 500000 then 'Standard'
        Else 'High Salary'
    end as Salary_range
FROM
    job_postings_fact
where job_title_short = 'Data Analyst'
GROUP BY
    Salary_range
order by 
    number_of_job desc
;



/*CTE are defiend with "WITH"*/
/*this is a query inside a query - subquery*/

Select 
    company_id,
        name as Company_name
From Company_dim
where company_id IN (
     SELECT 
                company_id
     FROM
                job_postings_fact
    where
                job_no_degree_mention = true
    ORDER BY 
            company_id
     );



/*CTE this is a temporary result set that can be used refrenced with select , update and delete statement*/

/*
    find the companies that have the most job openings
    - Get the total number of jobpostings per company (job-posting_fact)
    -Return the total number of jobs withinthe company name
*/


WITH company_job_countCTE As (
SELECT 
        company_id,
        count(*) as JobCount
FROM
        job_postings_fact
GROUP BY
        company_id
)
-- return the company id's which has the max number of job postings.
--SELECT * from company_job_countCTE
--ORDER BY JobCount DESC
--limit 10 ;



SELECT name,JobCount
FROM   company_dim a 
LEFT JOIN company_job_countCTE b on a.company_id = b.company_id
ORDER BY jobcount DESC
limit 10
; -- Join the CTE


SELECT * 
FROM
    job_postings_fact
    limit 10;

SELECT * FROM Skills_dim;

Select * From Skills_job_dim;

SELECT 
b.Skills ,
 COUNT(a.job_id) AS NoOfJobsWithThisSkill
FROM      skills_job_dim A
INNER JOIN
            Skills_dim B 
        on a.Skill_Id=B.Skill_Id
GROUP BY B.Skills
order BY NoOfJobsWithThisSkill desc
limit 5
;


/*
Find the count of number of remote job posting per skill
    -Display the top 5 skills by their demand in remote work
    - Include skill ID, name, and count of posting required per skill
*/

-- First step is to see the skill_ids


WITH remote_jobs_skillsCTE AS (
SELECT 
        Skill_Id,
        count(*) as skill_count
FROM
    Skills_job_dim a
INNER JOIN
    job_postings_fact b 
 ON   a.job_id = b.job_id
where
 b.job_work_from_home = true and
 b.job_title_short = 'Data Analyst'
 Group by SKill_Id

)

Select a.Skill_Id,
        b.Skills as Name, skill_count
from remote_jobs_skillsCTE a 
INNER JOIN
Skills_Dim b
on a.Skill_Id = b.Skill_Id
 order by skill_count DESC 
 limit 5;


/*UNION  is used to remove duplicates unlike Union all*/

SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    january_Job

UNION

SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    february_Job

UNION

SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    march_Job
    ;


SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    january_Job

UNION ALL

SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    february_Job

UNION ALL

SELECT  
    job_title_short,
    company_id,
    job_location
FROM
    march_Job
;

/*1
Find job postings for the first quarter that has a salary greater than $70k
-   combine jon posting table for the first quarter
-   Get job postings with an average salary greater than 70K
*/


SELECT job_title_short,
        job_location,
        Job_via,
        Job_posted_date :: DATE,
        salary_year_avg 
FROM (
    SELECT * 
    FROM january_Job
    UNION ALL
    SELECT * 
    FROM february_Job
    UNION ALL
    SELECT * 
    FROM march_Job
) AS Q1
Where Q1.salary_year_avg > 70000 and
      Q1.job_title_short = 'Data Analyst'
ORDER BY salary_year_avg  DESC
;
