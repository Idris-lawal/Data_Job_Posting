/* 4.  what are the top Skill based on salary for my role?*/

/*
    Look at the average salary associated witheach skill for data analyst position
    Focuses on roles with specific salaries, regardless the location
    why, it reveal how different skills impact salary levels for data analyst and helps identify the most financially rewarding skill to acqure or improve
*/

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


/*
Based on the provided data on the top-paying skills for data analysts, here are some insights into the trends:

Emergence of Blockchain and Smart Contracts: Solidity, a programming language for writing smart contracts on blockchain platforms like Ethereum, stands out with an average salary of $179,000. This suggests a growing demand for professionals skilled in blockchain technology.

Specialized Database Management: Skills like Couchbase and Cassandra indicate a need for expertise in managing NoSQL databases, particularly for handling large-scale data storage and retrieval.

Machine Learning Frameworks: DataRobot, MXNet, Keras, PyTorch, and TensorFlow represent a strong emphasis on machine learning frameworks, reflecting the increasing adoption of machine learning and deep learning techniques in data analysis.

DevOps and Infrastructure as Code (IaC): Tools like Terraform, Puppet, Ansible, and VMware highlight the importance of infrastructure automation and configuration management in data analytics environments, indicating a trend towards DevOps practices.

Streaming Data Processing: Kafka and Airflow are prominent skills related to data streaming and workflow orchestration, reflecting the growing need for real-time data processing and analysis.

Version Control and Collaboration Tools: SVN and GitLab suggest the importance of version control and collaboration in data analysis projects, emphasizing the need for efficient code management and team collaboration.

Programming Languages: Golang (Go), Perl, and Scala indicate the demand for professionals proficient in various programming languages, reflecting the diverse technological landscape of data analysis.

Overall, the trends suggest a shift towards specialized skills in emerging technologies such as blockchain, machine learning, and DevOps, alongside the continued importance of fundamental skills like database management and programming. Professionals with expertise in these areas are likely to command top salaries in the data analytics field.
*/