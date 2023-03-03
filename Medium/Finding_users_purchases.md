# Finding User Purchases

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/finding_user_purchases_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/finding_user_purchases_2.png" />
</div>

&nbsp;


## Solution:

```sql
WITH previous_purchases AS (
    SELECT
        user_id,
        created_at,
        LAG(created_at, 1) OVER (PARTITION BY user_id ORDER BY created_at) AS previous_purchase
    FROM
        amazon_transactions
)

SELECT DISTINCT
    user_id
FROM
    previous_purchases
WHERE
    DATE_PART('day', created_at::timestamp - previous_purchase::timestamp) < 8
ORDER BY
    user_id;
```
To obtain a list with the ids of users that have made a second purchase within 7 days of any other of their purchases I have created a temporary table to, in a new column, place the date of the purchase prior to the current one.

Specifically, I have used the LAG function, which is a window function used to access the row that comes before the current row within a specific offset. In this case, LAG() acts on the created_at column and fetches the value of that same column, but from the row before the one being evaluated (offset = 1). At the same time, with PARTITION BY I make sure that the function is applied taking into account sets of rows belonging to the same client. ORDER BY is used to sort this set of rows according to the date of creation of the purchase.

Once this is done, I choose the unique ids of the temporary table in which the difference between both dates is less than 8 days. The function used for this is DATE_PART(), very similar to DATEDIFF() of SQL Server. It is important that the dates to be evaluated have the correct data type, that is why I use the shortcut ::timestamp inside the function. Finally, I order the rows resulting from the query according to the user_id so that the output is equal to the expected one.


<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/finding_user_purchases_output.png" />
</div>