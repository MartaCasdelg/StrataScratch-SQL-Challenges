# Popularity Percentage

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/popularity_percentage_1.png" />
</div>

&nbsp;

## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/popularity_percentage_2.png" />
</div>

&nbsp;


## Solution:

```sql
WITH all_friends AS (
    SELECT
        user1,
        user2
    FROM
        facebook_friends
    UNION
    SELECT
        user2 AS user1,
        user1 AS user2
    FROM
        facebook_friends
)

SELECT 
    user1,
    (COUNT(DISTINCT user2)::decimal/(SELECT COUNT(DISTINCT user1) FROM all_friends))*100 AS popularity_percent
FROM
    all_friends
GROUP BY
    user1
ORDER BY
    user1;
```


## Explanation:

This problem asks to obtain the popularity percentage, calculated as the division between the number of friends and total number of users, of each user present in the table.

The **difficulty of the problem lies in the way the data is presented**, since if we had a list of users together with their number of friends, it would be easy to perform the calculation. The issue is that the table contains **two columns, user1 and user2, which represent pairs of friends**. So, there are users that appear in both columns, or in one of them.

In order to obtain the total number of friends per user, it is necessary that all available users appear in a single column, with their respective friends in the other column.  Right now, the data is presented in this way: 

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/popularity_percentage_3.png" />
</div>

In this record we see that user 2 has user 1 as a friend, but there is no record to indicate otherwise. That is, there is no record indicating that 1 has user 2 as a friend.

To make the information be displayed in this way, we can join two tables, one as it originally is, and one with the columns reversed as shown in the following code snippet, in which I use UNION to join these two tables.

```sql
WITH all_friends AS (
    SELECT
        user1,
        user2
    FROM
        facebook_friends
    UNION
    SELECT
        user2 AS user1,
        user1 AS user2
    FROM
        facebook_friends
)
```

Following the previous example (where 2 has 1 as a friend), we would see that the resulting table now also has the inverted pair (1 has 2 as a friend):

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/popularity_percentage_4.png" />
</div>

Now, it remains to **calculate the percentage of popularity**. To do this, I use the **COUNT** function to count the number of total users and the number of friends of each user. It is important to note the use of the **DISTINCT** clause inside this function. This is because the table currently contains repeated users in both columns. I'm interested in getting the **total unique users of the table** and the **total unique friends of each user**.

```sql
SELECT 
    user1,
    (COUNT(DISTINCT user2)::decimal/(SELECT COUNT(DISTINCT user1) FROM all_friends))*100 AS popularity_percent
FROM
    all_friends
GROUP BY
    user1
ORDER BY
    user1;
```

Since the expected output of the problem shows decimal values, I convert the number of friends to decimal. In addition, I multiply the result of the division by 100 to obtain the percentage value.

Since an aggregation function has been used, I use a GROUP BY clause to group the results according to the user. Finally, I sort the table by user ID to obtain the expected result.

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/popularity_percentage_output.png" />
</div>