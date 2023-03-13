# Highest Target Under Manager

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/highest_target_under_manager_1.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/highest_target_under_manager_2.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/highest_target_under_manager_3.png" />
</div>

&nbsp;


## Solution:

```sql
WITH ranking AS (
    SELECT
        first_name,
        target,
        DENSE_RANK() OVER (ORDER BY target DESC) AS rank
    FROM
        salesforce_employees
    WHERE
        manager_id = 13
)

SELECT
    first_name,
    target
FROM 
    ranking
WHERE
    rank = 1;
```

&nbsp;

## Explanation:

To find the **employees who have reached the highest target under the manager id 13**, I first created a **temporary table** in which I added a new column that ranks all employees based on the targets achieved. By using the **DENSE_RANK()** function those **employees who have reached the same mark get the same position in the ranking**, so there can be more than one person with position 1. In this table, I also filter the records so that only those employees whose manager is 13 are displayed.

```sql
WITH ranking AS (
    SELECT
        first_name,
        target,
        DENSE_RANK() OVER (ORDER BY target DESC) AS rank
    FROM
        salesforce_employees
    WHERE
        manager_id = 13
)
```

Once this is done, it only remains to select the name field and the target of the temporary table. To display only those employees who have obtained the best position, I filter the table using the WHERE clause, indicating that I only want **employees with the 1st position** in the ranking. 

```sql
SELECT
    first_name,
    target
FROM 
    ranking
WHERE
    rank = 1;
```

By executing the **entire query**, I get the desired result:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/highest_target_under_manager_output.png" />
</div>