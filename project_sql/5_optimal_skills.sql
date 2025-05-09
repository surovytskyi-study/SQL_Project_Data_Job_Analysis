WITH skills_demand AS(
	SELECT 
		skills.skill_id,
		skills.skills,
	COUNT(sjd.job_id) as total_jobs
	FROM job_postings_fact as jpf
	INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
	INNER JOIN skills_dim skills ON sjd.skill_id = skills.skill_id
	WHERE
		job_title_short = 'Data Analyst' AND
		jpf.salary_year_avg IS NOT NULL
	GROUP BY
		skills.skill_id
), average_salary_skill AS(
	SELECT 
		sjd.skill_id,
		AVG(jpf.salary_year_avg) as salary_avg
	FROM job_postings_fact as jpf
	INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
	INNER JOIN skills_dim skills ON sjd.skill_id = skills.skill_id
	WHERE
		job_title_short = 'Data Analyst' AND
		jpf.salary_year_avg IS NOT NULL
	GROUP BY
		sjd.skill_id
)

SELECT
	skills_demand.skill_id,
	skills_demand.skills,
	total_jobs,
	salary_avg
FROM
	skills_demand
INNER JOIN average_salary_skill ass ON skills_demand.skill_id = ass.skill_id
WHERE
	total_jobs > 10
ORDER BY
	salary_avg DESC,
	total_jobs DESC
LIMIT 25


-- Another example
SELECT
	skills.skill_id,
	skills.skills,
	COUNT(sjd.job_id) as total_count,
	ROUND(AVG(jpf.salary_year_avg), 0) as salary_avg
FROM
	job_postings_fact jpf
INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim skills ON sjd.skill_id = skills.skill_id
WHERE
	jpf.job_title_short = 'Data Analyst' AND
	jpf.salary_year_avg IS NOT NULL
GROUP BY
	skills.skill_id
HAVING
	COUNT(sjd.job_id) > 10
ORDER BY
	salary_avg DESC,
	total_count DESC
LIMIT 25

