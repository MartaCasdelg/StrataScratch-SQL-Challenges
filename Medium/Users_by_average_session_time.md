# Users by average session time

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/users_by_average_session_time_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/users_by_average_session_time_2.png" />
</div>

&nbsp;


## Solution:

```sql
WITH page_loads AS (
    SELECT
        user_id,
        DATE(timestamp) AS date,
        MAX(timestamp) AS latest_page_load
    FROM
        facebook_web_log
    WHERE
        action = 'page_load'
    GROUP BY
        user_id,
        DATE(timestamp)
),

page_exits AS (
    SELECT
        user_id,
        DATE(timestamp) AS date,
        MIN(timestamp) AS earliest_page_exit
    FROM
        facebook_web_log
    WHERE
        action = 'page_exit'
    GROUP BY
        user_id,
        DATE(timestamp)
)

SELECT 
    e.user_id,
    AVG(earliest_page_exit - latest_page_load) AS avg
FROM
    page_exits e LEFT JOIN
    page_loads l ON l.user_id = e.user_id AND l.date = e.date
GROUP BY
    e.user_id;
```
The problem asks us to find the average session time of each user in the database. To obtain it, I first create two temporary tables (CTEs). The first one (page_loads) contains the id of each user, the date in day format and the timestamp of the moment when the user loaded the page. The second one (page_exits), on the other hand, contains the same data but for the time when the user leaves the page.  

It is important to note that the problem tells us to assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit. To meet this requirement I use the MAX() function to get the latest page_load and MIN() to get the earliest page_exit.

Having these two tables, I join them together to find the average of the difference between the timestamp of the load and the exit, as well as the user_id. 

The type of join between the tables is LEFT JOIN (an INNER JOIN would also have been useful in this case) because I am interested in getting the records of users who have both logged in and logged out of the site. If we run the two temporary tables separately we will notice that there is a user_id 2 in the load table that does not appear in the output table. I am not interested in this user because I cannot get his session time until he has left the page.

&nbsp;

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/users_by_average_session_time_3.png"  width="400" height="400" />
</div>

&nbsp;

However, there is something very important to keep in mind about the way the boards are joined. We cannot simply use the user_id to create the join as there are repeated values in this field. This is because a user may have logged in or logged out on different days. 

In order to make the join between the tables unambiguous, it is necessary to use both the user_id and the date field in day format (since the timestamp column will not necessarily match between the tables).

Finally, I use GROUP BY so that the result of AVG() is displayed for each user and I get the expected result.

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/users_by_average_session_time_output.png" />
</div>