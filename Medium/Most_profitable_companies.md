# Most Profitable Companies

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/most_profitable_companies_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/most_profitable_companies_2.png" />
</div>

&nbsp;


## Solution:

```sql
SELECT 
    company,
    profits
FROM
    forbes_global_2010_2014
ORDER BY
    RANK() OVER (ORDER BY profits DESC)
LIMIT 3;
```

&nbsp;

## Explanation:

To obtain the top 3 companies with the best profits, I used the RANK() function to create the ranking based on the value of the profits column. 

RANK() is a window function, so it occupies the sixth position in terms of order of operations. This means that it cannot be included within FROM, WHERE, GROUP BY or HAVING clauses. Consequently, I have used it within the ORDER BY clause, since the expected output does not include the number of the position in the ranking, but the name of the company and the value of its profits. When executing the query we get the expected result:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/most_profitable_companies_output.png" />
</div>

Another alternative could have been to include this function in the SELECT of a CTE, and then reference this table and filter it to show only the results where the ranking position is equal to or less than 3. However, the method I have ended up using is more direct.