
SELECT 
	skills,
	ROUND(AVG(jpf.salary_year_avg), 0) as salary_avg
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim skills ON sjd.skill_id = skills.skill_id
WHERE
	job_title_short = 'Data Analyst' AND
	jpf.salary_year_avg IS NOT NULL AND
	jpf.job_work_from_home = TRUE
GROUP BY
	skills
ORDER BY
	salary_avg DESC
LIMIT 5