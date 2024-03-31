# INTRODUCTION
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here:[project_sql folder](/project_sql/)
# BACKGROUND
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data was provide by Luke Barousse [SQL course](https://www.lukebarousse.com/sql),It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
    1.  What are the top-paying data analyst jobs?
    2.  What skills are required for these top-paying jobs?
    3.  What skills are most in demand for data analysts?
    4.  Which skills are associated with higher salaries?
    5.  What are the most optimal skills to learn?
# TOOLS USED

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.



# THE ANALYSIS

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```
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
```
Here's the breakdown of the top data analyst jobs in 2023:

- Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.
 


| job_id  | job_title                             | companyname                           | job_location | job_schedule_type | salary_year_avg | job_posted_date       |
|---------|---------------------------------------|---------------------------------------|--------------|-------------------|-----------------|------------------------|
| 226942  | Data Analyst                          | Mantys                                | Anywhere     | Full-time         | 650000.0        | 2023-02-20 15:13:33    |
| 547382  | Director of Analytics                 | Meta                                  | Anywhere     | Full-time         | 336500.0        | 2023-08-23 12:04:42    |
| 552322  | Associate Director- Data Insights     | AT&T                                  | Anywhere     | Full-time         | 255829.5        | 2023-06-18 16:03:12    |
| 99305   | Data Analyst, Marketing               | Pinterest Job Advertisements          | Anywhere     | Full-time         | 232423.0        | 2023-12-05 20:00:40    |
| 1021647 | Data Analyst (Hybrid/Remote)         | Uclahealthcareers                     | Anywhere     | Full-time         | 217000.0        | 2023-01-17 00:17:23    |
| 168310  | Principal Data Analyst (Remote)       | SmartAsset                            | Anywhere     | Full-time         | 205000.0        | 2023-08-09 11:00:01    |
| 731368  | Director, Data Analyst - HYBRID      | Inclusively                           | Anywhere     | Full-time         | 189309.0        | 2023-12-07 15:00:13    |
| 310660  | Principal Data Analyst, AV Performance Analysis | Motional                   | Anywhere     | Full-time         | 189000.0        | 2023-01-05 00:00:25    |
| 1749593 | Principal Data Analyst                | SmartAsset                            | Anywhere     | Full-time         | 186000.0        | 2023-07-11 16:00:05    |
| 387860  | ERM Data Analyst                      | Get It Recruit - Information Technology | Anywhere  | Full-time         | 184000.0        | 2023-06-09 08:01:04    |

Each row represents a different job listing with corresponding details such as job ID, title, company name, location, schedule type, average salary, and posted date. This tabular format provides a clear and structured representation of the data.

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```
WITH top_paying_jobsCTE AS(
    SELECT
        job_id,
        job_title,
        B.name AS CompanyName,
        salary_year_avg
    FROM
        job_postings_fact a
    LEFT JOIN
        company_dim b On a.company_id = b.company_id
    WHERE job_title_short = 'Data Analyst' AND 
        job_location ='Anywhere' and salary_year_avg is not NULL
    ORDER BY
        salary_year_avg DESC
        LIMIT 10
)
SELECT a.job_id,a.job_title,a.CompanyName,a.salary_year_avg,c.skills
 FROM 
    top_paying_jobsCTE a 
LEFT JOIN
skills_job_dim b ON a.job_id=b.job_id
INNER JOIN
skills_dim C on b.skill_id = c.skill_id
ORDER BY A.salary_year_avg DESC
;
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6. 
- Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

| job_id |            job_title             |          companyname                    | salary_year_avg |   skills  |
|--------|---------------------------------|-----------------------------------------|-----------------|-----------|
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | sql       |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | python    |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | r         |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | azure     |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | databricks|
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | aws       |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | pandas    |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | pyspark   |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | jupyter   |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | excel     |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | tableau   |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | power bi  |
| 552322 | Associate Director- Data Insights | AT&T                                    | 255829.5        | powerpoint|
| 99305  | Data Analyst, Marketing          | Pinterest Job Advertisements            | 232423.0        | sql       |
| 99305  | Data Analyst, Marketing          | Pinterest Job Advertisements            | 232423.0        | python    |
| 99305  | Data Analyst, Marketing          | Pinterest Job Advertisements            | 232423.0        | r         |
| 99305  | Data Analyst, Marketing          | Pinterest Job Advertisements            | 232423.0        | hadoop    |
| 99305  | Data Analyst, Marketing          | Pinterest Job Advertisements            | 232423.0        | tableau   |
| 1021647| Data Analyst (Hybrid/Remote)    | Uclahealthcareers                       | 217000.0        | sql       |
| 1021647| Data Analyst (Hybrid/Remote)    | Uclahealthcareers                       | 217000.0        | crystal   |
| 1021647| Data Analyst (Hybrid/Remote)    | Uclahealthcareers                       | 217000.0        | oracle    |
| 1021647| Data Analyst (Hybrid/Remote)    | Uclahealthcareers                       | 217000.0        | tableau   |
| 1021647| Data Analyst (Hybrid/Remote)    | Uclahealthcareers                       | 217000.0        | flow      |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | sql       |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | python    |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | go        |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | snowflake |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | pandas    |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | numpy     |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | excel     |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | tableau   |
| 168310 | Principal Data Analyst (Remote)  | SmartAsset                              | 205000.0        | gitlab    |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | sql       |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | python    |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | azure     |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | aws       |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | oracle    |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | snowflake |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | tableau   |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | power bi  |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | sap       |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | jenkins   |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | bitbucket |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | atlassian |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively                             | 189309.0        | jira      |
| 731368 | Director, Data Analyst - HYBRID  | Inclusively

                             | 189309.0        | confluence|
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | sql       |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | python    |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | r         |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | git       |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | bitbucket |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | atlassian |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | jira      |
| 310660 | Principal Data Analyst, AV Performance Analysis | Motional                     | 189000.0        | confluence|
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | sql       |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | python    |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | go        |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | snowflake |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | pandas    |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | numpy     |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | excel     |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | tableau   |
| 1749593| Principal Data Analyst         | SmartAsset                              | 186000.0        | gitlab    |
| 387860 | ERM Data Analyst               | Get It Recruit - Information Technology| 184000.0        | sql       |
| 387860 | ERM Data Analyst               | Get It Recruit - Information Technology| 184000.0        | python    |
| 387860 | ERM Data Analyst               | Get It Recruit - Information Technology| 184000.0        | r         |

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```
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

/*METHOD 2  using join*/

SELECT c.skills,Count(a.job_id) as demand_Count
FROM job_postings_fact A 
INNER JOIN skills_job_dim B ON a.job_id = b.job_id
INNER JOIN skills_dim C ON b.skill_id = c.skill_id
where job_work_from_home = TRUE AND
      job_title_short = 'Data Analyst'
GROUP BY c.skills
ORDER BY demand_Count DESC
LIMIT 5;

which ever of the two methods works
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

Sure, here's the provided data presented in a table format:


|  skills  | demand_count |
|----------|--------------|
|   sql    |     7291     |
|  excel   |     4611     |
|  python  |     4330     |
| tableau  |     3745     |
| power bi |     2609     |

Table of the demand for the top 5 skills in data analyst job postings

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

'''
SELECT c.skills,round(AVG(salary_year_avg ),2) as averageSalary
FROM job_postings_fact A 
INNER JOIN skills_job_dim B ON a.job_id = b.job_id
INNER JOIN skills_dim C ON b.skill_id = c.skill_id
where --job_work_from_home = TRUE AND
      job_title_short = 'Data Analyst'
      and salary_year_avg is not NULL
GROUP BY c.skills
ORDER BY averageSalary DESC
LIMIT 25;
'''

Here's a breakdown of the results for top paying skills for Data Analysts:

- High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.
Skills	Average Salary ($)

|   skills   | averagesalary |
|------------|---------------|
|    svn     |   400000.00   |
|  solidity  |   179000.00   |
|  couchbase |   160515.00   |
|  datarobot |   155485.50   |
|   golang   |   155000.00   |
|   mxnet    |   149000.00   |
|   dplyr    |   147633.33   |
|   vmware   |   147500.00   |
|  terraform |   146733.83   |
|   twilio   |   138500.00   |

Table of the average salary for the top 10 paying skills for data analysts

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
 ```
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

whichever of the two scripts works perfectly

```
| skill_id |  skills  | demand_count | averagesalary |
|----------|----------|--------------|---------------|
|    0     |   sql    |     7291     |     97237     |
|   181    |  excel   |     4611     |     87288     |
|    1     |  python  |     4330     |    101397     |
|   182    | tableau  |     3745     |     99288     |
|   183    | power bi |     2609     |     97431     |
|    5     |    r     |     2142     |    100499     |
|   186    |   sas    |      933     |     98902     |
|    7     |   sas    |      933     |     98902     |
|   185    |  looker  |      868     |    103795     |
|    74    |  azure   |      821     |    111225     |


Table of the most optimal skills for data analyst sorted by salary

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.


# WHAT I LEARNED

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- 📊 Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- 💡 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# CONCLUSION

### Insights
From the analysis, several general insights emerged:

- Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
-  Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
- Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
- Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.

