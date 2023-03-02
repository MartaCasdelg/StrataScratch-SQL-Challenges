# Workers with the highest salaries

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/workers_highest_salaries_1.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/workers_highest_salaries_2.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/workers_highest_salaries_3.png" />
</div>

&nbsp;


## Solution:

```sql
WITH best_paid AS(
SELECT
    worker_id,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
FROM
    worker)

SELECT
    title.worker_title
FROM
    best_paid JOIN
    title ON best_paid.worker_id = title.worker_ref_id
WHERE
    rank = 1;
```

To find the position of the highest paid person or persons in the company I have created a temporary table where I have assigned a ranking number to each employee based on their salary. Having this table, we can join it to the title table, which contains the name of the position of each employee and use the WHERE clause to find the position that occupies position 1 in the ranking. 

In this case we obtain that both the manager and the assistant manager receive the highest salaries.

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/workers_highest_salaries_output.png" />
</div>

&nbsp;

## Solution 2:

Solution 2:

Another solution would be to create a subquery within the where statement to select the positions whose salary is equal to the maximum of the worker table.

```sql
SELECT
    title.worker_title
FROM
    worker JOIN 
    title ON worker.worker_id = title.worker_ref_id
WHERE
    worker.salary = (SELECT MAX(salary) FROM worker);
```
