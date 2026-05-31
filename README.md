# Introduction
This project is an analysis on top-paying jobs, in-demand skills, and top-paying skills in data engineering jobs.
- For SQL queries, please refer to [PROJECT_JOB_ANALYSIS folder](/PROJECT_JOB_ANALYSIS/)
# Background
As part of my journey into data analytics and data engineering, I completed a SQL-based project analyzing the data analyst job market. Using a real-world dataset containing job postings, salaries, locations, and required skills, I explored how SQL can be used to extract meaningful insights from large datasets.

The goal of this project was to identify the skills and qualifications that are most valuable in the job market, particularly those associated with high-paying opportunities. Through a series of SQL queries, I analyzed job posting data to answer the following questions:

What are the highest-paying remote data engineer jobs?
What skills are required for these top-paying positions?
Which skills are most in demand?
Which skills are associated with higher salaries?

This project allowed me to strengthen my SQL skills while gaining a deeper understanding of industry trends and the technical skills employers value most.
### Data Source

The dataset used in this project was obtained from Luke Barousse's SQL course and contains job posting data, including job titles, salaries, locations, and required skills.

Source:
[Luke Barousse SQL Course](https://lukebarousse.com/sql)
# Tools I Used
- SQL – Used to query, filter, aggregate, and analyze job posting data to uncover trends in salaries and skill demand.
- PostgreSQL – Served as the relational database for storing and managing the job market dataset.
- Visual Studio Code – Used as the primary development environment for writing and executing SQL queries.
- Git & GitHub – Used for version control, project organization, and sharing the analysis through a public repository.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data engineer job market. Here’s how I approached each question:

### 1. Top Paying Data Engineer Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field
```
SELECT 
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Analysis of the top 10 highest-paying remote Data Engineer positions in 2023 revealed salaries ranging from $242K to $325K annually. The highest-paying opportunities were primarily senior and specialized roles, including Data Engineer, Principal Data Engineer, Staff Data Engineer, and Engineering Leadership positions. These findings highlight the strong market demand and premium compensation associated with advanced data engineering expertise and large-scale data platform development.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
        salary_year_avg DESC
```
Among the top 10 highest-paying Data Engineer positions in 2023, Python was the dominant skill, appearing in 7 out of 10 roles. However, the strongest common theme was expertise in large-scale distributed data systems, particularly Spark, Hadoop, and Kafka. The results suggest that high compensation is less associated with basic data analysis skills and more associated with building scalable data infrastructure capable of processing massive volumes of data efficiently.

### 3. In-Demand Skills for Data Engineers
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10
```
Analysis of Data Engineer job postings revealed that SQL (14,213) and Python (13,893) were the most in-demand skills, highlighting their importance as foundational tools for data engineering. Cloud technologies such as AWS and Azure also ranked highly, reflecting the industry's shift toward cloud-based data platforms. Additionally, the strong demand for Spark, Airflow, Snowflake, Databricks, and Kafka demonstrates the growing importance of big data processing, workflow orchestration, and modern data infrastructure in data engineering roles.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_work_from_home = True AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20
```
Specialized technologies command the highest salaries. Skills like Assembly, Rust, Clojure, and Solidity appear at the top, suggesting employers pay a premium for expertise that is relatively rare in the market. In addition to that, high-paying Data Engineer roles often extend beyond traditional data engineering. Skills related to software engineering (Rust, FastAPI), machine learning (NumPy, MXNet), and DevOps (Kubernetes) indicate that top-paying positions increasingly require a broad technical skill set rather than just data pipeline expertise.
# What I learned
Throughout this project, I strengthened both my technical SQL skills and my ability to extract meaningful insights from real-world data:

- Advanced SQL Querying: Developed complex queries using joins, CTEs, subqueries, and aggregation techniques to analyze relationships between job postings, salaries, and required skills.
- Data Analysis : Used SQL to identify trends in salary and skill demand.
- Data-Driven Decision Making: Transformed raw job posting data into actionable insights, uncovering which skills are most in demand and most associated with high-paying Data Engineer roles.
- Database & Version Control Practices: Gained hands-on experience working with PostgreSQL for data management and Git/GitHub for version control, project organization, and portfolio development.
