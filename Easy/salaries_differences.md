# Salaries Differences

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/salaries_differences_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/salaries_differences_2.png" />
</div>

&nbsp;


## Solution:

```sql
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
```
&nbsp;

## Explanation:

In this case, I created a temporary table to obtain the maximum salary within the marketing and engineering departments. In order to filter the table by departments, it was necessary to join the two available tables using the id of the department. That done, the temporary table holds two records, each with the maximum salary in the respective department. 

In the final part of the query, I find the difference between these values by selecting the maximum and minimum of the temporary table, obtaining the expected result.


<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/salaries_differences_output.png" />
</div>