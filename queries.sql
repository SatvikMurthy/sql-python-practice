-- SQL practice on sample hiring data (made-up candidates, not real).
-- Load candidates.csv into a table called candidates, for example with DB Browser for SQLite.
-- Columns: candidate_id, role_type, source, furthest_stage, days_in_process

-- 1. How many candidates are in the data?
SELECT COUNT(*) AS total_candidates
FROM candidates;

-- 2. How many candidates stopped at each stage?
SELECT furthest_stage, COUNT(*) AS candidates
FROM candidates
GROUP BY furthest_stage
ORDER BY candidates DESC;

-- 3. Which source brings in the most candidates?
SELECT source, COUNT(*) AS candidates
FROM candidates
GROUP BY source
ORDER BY candidates DESC;

-- 4. Average days in process by role type
SELECT role_type, ROUND(AVG(days_in_process), 1) AS avg_days
FROM candidates
GROUP BY role_type;

-- 5. Of the candidates from each source, how many reached the interview stage or further?
SELECT source,
       COUNT(*) AS total,
       SUM(CASE WHEN furthest_stage IN ('Interviewed','Shortlisted','Offered','Joined') THEN 1 ELSE 0 END) AS reached_interview
FROM candidates
GROUP BY source;

-- 6. Which candidates have been in the process for more than 30 days?
SELECT candidate_id, role_type, furthest_stage, days_in_process
FROM candidates
WHERE days_in_process > 30
ORDER BY days_in_process DESC;
