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

/*
    Among the top 10 highest-paying Data Engineer positions in 2023, Python was the dominant skill, appearing in 7 out of 10 roles. 
    However, the strongest common theme was expertise in large-scale distributed data systems, particularly Spark, Hadoop, and Kafka. 
    The results suggest that high compensation is less associated with basic data analysis skills and more associated with building scalable data infrastructure capable of processing massive volumes of data efficiently.
*/
