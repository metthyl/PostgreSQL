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

/*
1. Specialized technologies command the highest salaries. 
   Skills like Assembly, Rust, Clojure, and Solidity appear at the top, suggesting employers pay a premium for expertise that is relatively rare in the market.
2. High-paying Data Engineer roles often extend beyond traditional data engineering. 
   Skills related to software engineering (Rust, FastAPI), machine learning (NumPy, MXNet), and DevOps (Kubernetes) indicate that top-paying positions increasingly require a broad technical skill set rather than just data pipeline expertise.
*/