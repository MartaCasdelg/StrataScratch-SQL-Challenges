-- Counting instances in text
SELECT
    word,
    nentry
FROM
    ts_stat('SELECT to_tsvector(contents) FROM google_file_store')
WHERE
    word IN ('bull', 'bear');



-- Monthly percentage difference
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



-- Premium vs freemium
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



-- Popularity percentage
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