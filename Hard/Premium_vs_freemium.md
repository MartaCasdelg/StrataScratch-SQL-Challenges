# Premium vs Freemium

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/premium_vs_freemium_1.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/premium_vs_freemium_2.png" />
</div>

&nbsp;

## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/premium_vs_freemium_3.png" />
</div>

&nbsp;


## Solution:

```sql
SELECT
    d.date,
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'no') AS non_paying_downloads,
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'yes') AS paying_downloads
FROM 
    ms_download_facts d 
    JOIN ms_user_dimension u 
        ON d.user_id = u.user_id 
    JOIN ms_acc_dimension a
        ON u.acc_id = a.acc_id
GROUP BY
    d.date
HAVING
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'no') 
        > SUM(d.downloads) FILTER (WHERE a.paying_customer = 'yes')
ORDER BY
    d.date;
```

This problem asks to **find the number of downloads made by paying and non-paying users, for those dates when the number of downloads of freemium users were higher than those of premium users**. This query allows to obtain the expected result. I will break it down below to explain **how it works**.

First, it is important to note that there are **three different tables**. They can be joined using the JOIN clause via the user_id and acc_id columns.

```sql
FROM 
    ms_download_facts d 
    JOIN ms_user_dimension u 
        ON d.user_id = u.user_id 
    JOIN ms_acc_dimension a
        ON u.acc_id = a.acc_id
```

Once this is done, we have the columns we are interested in. That is, the columns paying_customer (varchar), which defines if the user is premium or freemium (yes/no), date and downloads.

The problem requires that the output contains a column with the dates, the number of downloads by non-paying users and another with the number of downloads made by paying users. 

Then, the **date** column is in the ms_download_facts table, which I have renamed to d. That is why in the SELECT clause it appears as d.date.

On the other hand, you can get the **sum of downloads for each user type** using the **FILTER()** function. This function allows you to filter the result of an aggregate function, as is in this case the SUM() function. As a parameter, we indicate that the filtering condition is that the paying_customer column is equal to 'no', in the case  of non-paying users, and 'yes', for paying users. Then, the SELECT clause is as follows:

```sql
SELECT
    d.date,
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'no') AS non_paying_downloads,
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'yes') AS paying_downloads
```
When using an aggregate function, it is necessary to use the GROUP BY function to group the results, in this case, by date.

Apart from that, **two more requirements are missing**. On the one hand, the problem specified that the result should **show only those records where the sum of downloads of non-paying users is greater than those of paying users**.

To fulfill this requirement it is very important to take into account the SQL order of query execution:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/premium_vs_freemium_4.png" />
</div>

If you notice, the **SELECT clause is executed in fifth place**, while WHERE is in second place. This means that **I cannot use the columns non_paying_downloads and paying_downloads in a WHERE clause** because they are created after the filtering is applied.

Then, what remains (if we want to avoid creating a temporary table with the results) is to use the aggregation function as I put it in the SELECT clause to filter the data. The only inconvenience is that aggregation functions cannot be executed inside WHERE clauses. Therefore, I use the **HAVING clause**.

```sql
HAVING
    SUM(d.downloads) FILTER (WHERE a.paying_customer = 'no') 
        > SUM(d.downloads) FILTER (WHERE a.paying_customer = 'yes')
```
Finally, the output should be sorted by earliest date first. 

```sql
ORDER BY
    d.date;
```
Executing the **whole query**, I get the expected result:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/premium_vs_freemium_output.png" />
</div>