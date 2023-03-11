# Acceptance Rate by Date

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/acceptance_rate_by_date_1.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/acceptance_rate_by_date_2.png" />
</div>

&nbsp;


## Solution:

```sql
WITH sent AS (
    SELECT
        date,
        user_id_sender,
        user_id_receiver
    FROM 
        fb_friend_requests
    WHERE
        action = 'sent'
),

accepted AS (
    SELECT
        user_id_sender,
        user_id_receiver
    FROM 
        fb_friend_requests
    WHERE
        action = 'accepted'
)

SELECT
    s.date,
    (COUNT(a.user_id_receiver)/(COUNT(s.user_id_sender))::decimal) AS percentage_acceptance
FROM
    sent s LEFT JOIN
    accepted a ON 
        s.user_id_sender = a.user_id_sender AND
        s.user_id_receiver = a.user_id_receiver
GROUP BY
    s.date;
```

This problem asks for the overall friend acceptance rate by date, which is calculated as the division between the number of accepted requests and the total number of requests created. The statement of the exercise asks us to group the results by date. Specifically, it refers to the dates on which the requests are created since a request can be accepted on a date other than the one on which it was received.

Now, **I will break down the query at the top to explain how it works**.

First, I create **two temporary tables** (CTEs). The **first one contains all the requests sent** regardless of whether they were finally accepted or not. To filter the records of the original table, I use the WHERE clause and indicate that I want the rows where action is equal to 'sent'.

```sql
WITH sent AS (
    SELECT
        date,
        user_id_sender,
        user_id_receiver
    FROM 
        fb_friend_requests
    WHERE
        action = 'sent'
)
```

The **second table contains only the requests that were accepted**. To get them, I use the WHERE clause again, except I indicate that action must be equal to 'accepted'.

```sql
accepted AS (
    SELECT
        user_id_sender,
        user_id_receiver
    FROM 
        fb_friend_requests
    WHERE
        action = 'accepted'
)
```

If you notice, in the 'sent' table, in addition to the ids, I also retrieved information about the dates. This is because, as I pointed out earlier, the problem asks us to group the results according to request submission date. Therefore, I do not need the date on which the request is accepted, so I do not require this information in the second table.

Having both tables, it remains to **obtain the overall friend acceptance rate by date**. To this end, it is important to **note that**:

* It's calculated as the division between the number of accepted requests and the total number of requests.
* The total number of accepted requests is obtained by counting the number of records in the 'accepted' table.
* The total number of requests is obtained by counting the records in the 'sent' table.

With that in mind, **it is necessary to consider how to join the tables** so that the calculations are correct. The premise is as follows, **all accepted requests are in the 'sent' table, but not all sent requests are in the 'accepted' table**. This is simply because not all requests have to be accepted.

Then, in order to avoid deleting information by accident, we could join the tables in such a way that all the requests are kept and, in addition, values are added in new columns for those that were accepted. In this way, we can identify which records correspond to accepted requests.

At this point, you may wonder why all this is necessary if in the original table there is a column that indicates precisely whether a request was accepted. The reason is that in that table there are duplicate requests. That is, if a request was accepted, it appears twice in the table, although possibly with different values in the date field. This means that we cannot directly calculate the number of accepted requests according to the request date.

Returning to the matter of how to join the tables, we can use a **LEFT JOIN to keep all the records of the 'sent' table and add the data of the accepted requests**. Those requests that were not accepted will have null values in the corresponding columns of the 'accepted' table. We can use the ids to join the tables in this way.

```sql
FROM
    sent s LEFT JOIN
    accepted a ON 
        s.user_id_sender = a.user_id_sender AND
        s.user_id_receiver = a.user_id_receiver
```

To better understand this, I will show what you would get if you run a query in which you select all the records from both tables, joined by a LEFT JOIN. It would be the following:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/acceptance_rate_by_date_3.png" height="400" />
</div>

You can see how, **for those requests that were not accepted, null records are displayed. Thanks to this, if we use a COUNT() function on this column we will obtain the total of accepted requests**, as COUNT() count the number of non-NULL items in the specified column. On the other hand, if we use the function on any of the columns that belongs to the 'sent' table, we get the number of total requests.

And that's exactly what I do in the SELECT clause, where in addition to selecting the date from the 'sent' table, I calculate the overall rate of acceptance of friends by using this function. At the same time, I convert one of the columns to decimal type to match what the problem asks for.

```sql
SELECT
    s.date,
    (COUNT(a.user_id_receiver)/(COUNT(s.user_id_sender))::decimal) AS percentage_acceptance
```
Since aggregation functions are being used, I add the GROUP BY clause and indicate the column according to which the results should be grouped.

```sql
GROUP BY
    s.date;
```

When executing the **whole query**, I get the desired result:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/acceptance_rate_by_date_output.png" />
</div>