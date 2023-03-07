# Count the number of companies in the Information Technology sector in each country

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/count_number_companies_it_sector_1.png" />
</div>

&nbsp;


## Expected Output

Expected output is not available for this question.

&nbsp;


## Solution:

```sql
SELECT 
    country,
    COUNT(company) 
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology'
GROUP BY
    country;
```

To obtain the result, we can simply select the country and use the count function to find the number of companies, grouping the results by each country and filtering so only companies in the information technology sector are shown.

Another option would be to use COUNT() as a window function together with the PARTITION BY clause to create partitions for each country within the country column. At the same time, we use SELECT DISTINCT to output a different country for each row and filter the results again with the WHERE clause.

```sql
SELECT DISTINCT
    country,
    COUNT(company) OVER (PARTITION BY country) AS number_of_companies
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology';
```

In any case, the output would be the same:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/count_number_companies_it_sector_output.png" />
</div>

Although in this question the expected output is not available (as it is part of the premium capability), we can check that the results are correct if we simply look at the original table of the problem, filtering it by the sector field. We will find that there are only two countries, united states and south korea, in the country column and that if we count the rows for each of them, they return 8 and 1 respectively, which is the same as we obtained by the previous queries.

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Easy/Images/count_number_companies_it_sector_output_2.png" />
</div>
