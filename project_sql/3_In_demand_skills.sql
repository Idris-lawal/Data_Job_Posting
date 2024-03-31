/*3.  What are the most in-demand skill for my role?*/
/*
- join job posting to inner join table similar to query two
- identify the top 5  in-demand skills for a data analyst
- focus on alljob posting
-why? Retrieves the top 5 skills with highest demand in the job market
    providing insight into the most valuable skills for job seekers
*/

/* METHOD 1: CTE*/
WITH Remote_job_countCTE AS(
Select 
    a.skill_id,
    Count(*) as Skill_count
FROM
    skills_job_dim A
INNER JOIN
    job_postings_fact B 
on a.job_id = b.job_id
where b.job_title_short = 'Data Analyst' AND
     b.job_work_from_home = TRUE
GROUP BY a.skill_id
)

SELECT
      b.skill_id,b.skills,Skill_count
FROM
    Remote_job_countCTE A
INNER JOIN
    skills_dim B ON a.skill_id=B.skill_id
ORDER BY
    Skill_count DESC
LIMIT 5;

/*METHOD 2*/

SELECT c.skills,Count(a.job_id) as demand_Count
FROM job_postings_fact A 
INNER JOIN skills_job_dim B ON a.job_id = b.job_id
INNER JOIN skills_dim C ON b.skill_id = c.skill_id
where job_work_from_home = TRUE AND
      job_title_short = 'Data Analyst'
GROUP BY c.skills
ORDER BY demand_Count DESC
LIMIT 5;
