
SELECT 
	skills,
	COUNT(sjd.job_id) as total_jobs
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim skills ON sjd.skill_id = skills.skill_id
WHERE
	job_title_short = 'Data Analyst'
GROUP BY
	skills
ORDER BY
	total_jobs DESC
LIMIT 5