# Monthly percentage difference

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/Monthly_percentage_change_1.png" />
</div>

&nbsp;

## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/monthly_percentage_change_2.png" />
</div>

&nbsp;


## Solution:

```sql
WITH revenue_by_date AS (
    SELECT
        to_char(created_at, 'YYYY-MM') AS date,
        SUM(value) AS revenue,
        LAG(SUM(value), 1) OVER () AS revenue_last_month
    FROM
        sf_transactions
    GROUP BY
        date
    ORDER BY
        date ASC
)

SELECT
    date,
    ROUND(((revenue - revenue_last_month)/revenue_last_month)*100, 2) AS revenue_diff_pct
FROM
    revenue_by_date;
```
Next, **I will break down the query into parts to explain how it works**:

To get the percentage change in revenue month to month, I first create a **temporary table with the date, revenue and previous month's revenue columns**. The **date** column is found from the PostgreSQL function **to_char()**, which converts a date column to another format. In the problem they ask for the format 'YYYYY-MM', so that is the one I use in the function arguments.

```sql
to_char(created_at, 'YYYY-MM') AS date
```

On the other hand, the **revenue** is obtained by summing the values of the value column, grouped by the newly created date column. The **revenue of the previous month** can be found using the **LAG()** function, a window function that takes as parameters the value to be returned (revenue) and the offset, of value 1 to indicate to bring the value of the row immediately preceding the current one. The OVER() clause indicates the size of the window on which the calculation is performed, which in this case is the entire table (that is why neither PARTITION BY nor ORDER BY is added). 

```sql
LAG(SUM(value), 1) OVER () AS revenue_last_month
```

Additionally, I **order** the temporary table using the date field to fulfill the requirement of the problem statement, so that the **temporary table looks like this**.

```sql
WITH revenue_by_date AS (
    SELECT
        to_char(created_at, 'YYYY-MM') AS date,
        SUM(value) AS revenue,
        LAG(SUM(value), 1) OVER () AS revenue_last_month
    FROM
        sf_transactions
    GROUP BY
        date
    ORDER BY
        date ASC
)
```

Finally, I **select the date field and calculate the percentage change in revenue** using the columns of the temporary table. The formula simply calculates the difference in revenue between the current month and the previous month, and divides it by the value of the latter. The whole is multiplied by 100 to get the percentage and rounded to two decimal places using ROUND() to meet the requirements of the problem.

```sql
SELECT
    date,
    ROUND(((revenue - revenue_last_month)/revenue_last_month)*100, 2) AS revenue_diff_pct
FROM
    revenue_by_date;
```

Executing the **whole query**, I get the expected result:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/monthly_percentage_change_output.png" />
</div>