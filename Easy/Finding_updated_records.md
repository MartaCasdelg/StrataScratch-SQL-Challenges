# Finding Updated Records

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/finding_updated_records_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/finding_updated_records_2.png" />
</div>

&nbsp;


## Solution:

```sql
SELECT
    id,
    first_name,
    last_name, 
    department_id,
    MAX(salary) as actual_salary
FROM
    ms_employee_salary
GROUP BY
    id,
    first_name,
    last_name, 
    department_id
ORDER BY
    id ASC;
```
&nbsp;

## Explanation:

The MAX() function can be used to obtain the current salary of each employee, since the statement tells us to assume that salaries are increasing over time. Therefore, the current salary of each employee is the highest available in the table.

Having used an aggregation function, it is necessary to add the GROUP BY clause to the query, so that the result is calculated according to each id, name, surname and department. Finally, the records are sorted by id in ascending order, as requested by the problem. Executing the query, the expected result is obtained:


<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/finding_updated_records_output.png" />
</div>