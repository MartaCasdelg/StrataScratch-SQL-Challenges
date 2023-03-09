-- Count the number of companies in the Information Technology sector in each country
SELECT 
    country,
    COUNT(company) 
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology'
GROUP BY
    country;

--Other solution
SELECT DISTINCT
    country,
    COUNT(company) OVER (PARTITION BY country) AS number_of_companies
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology';



-- Salaries Differences
WITH cte AS (
    SELECT
        d.department,
        MAX(e.salary) AS salary
    FROM
        db_employee e JOIN
        db_dept d ON e.department_id = d.id
    WHERE
        d.department IN ('marketing', 'engineering')
    GROUP BY
        d.department
)

SELECT
    MAX(salary) - MIN(salary) AS salary_difference
FROM
    cte;
