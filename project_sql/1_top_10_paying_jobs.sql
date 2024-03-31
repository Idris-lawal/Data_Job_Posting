/*1.   what are the top-paying jos for my role?*/
/* steps to be taken
QUESTION: what are hte top-paying data analysis job 
- identify the top 10 highest-paying data analysis roles that are available remotely
- focus on job posting with specificsalaries (remove null)
- Why? , highlight the top- payinh opportunities for data analyst offering insights into employment rates
*/

SELECT
    job_id,
    job_title,
    B.name AS CompanyName,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact a
LEFT JOIN
    company_dim b On a.company_id = b.company_id
WHERE job_title_short = 'Data Analyst' AND 
      job_location ='Anywhere' and salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
    LIMIT 10
;