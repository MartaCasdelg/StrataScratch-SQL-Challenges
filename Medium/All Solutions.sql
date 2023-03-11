-- Workers with the highest salaries
WITH best_paid AS(
    SELECT
        worker_id,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM
        worker
)

SELECT
    title.worker_title AS best_paid_title
FROM
    best_paid JOIN
    title ON best_paid.worker_id = title.worker_ref_id
WHERE
    rank = 1;

--Other solution:
SELECT
    title.worker_title
FROM
    worker JOIN 
    title ON worker.worker_id = title.worker_ref_id
WHERE
    worker.salary = (SELECT MAX(salary) FROM worker);



-- Finding User Purchases
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



-- Classify Business Type
SELECT DISTINCT
    business_name,
    CASE
        WHEN LOWER(business_name) LIKE '%restaurant%' THEN 'restaurant'
        WHEN LOWER(business_name) LIKE '%cafe%' OR 
             LOWER(business_name) LIKE'%café%' OR 
             LOWER(business_name) LIKE'%coffee%'
            THEN 'cafe'
        WHEN LOWER(business_name) LIKE '%school%' THEN 'school'
        ELSE 'other'
    END AS business_type
FROM
    sf_restaurant_health_violations;



-- Most Profitable Companies
SELECT 
    company,
    profits
FROM
    forbes_global_2010_2014
ORDER BY
    RANK() OVER (ORDER BY profits DESC)
LIMIT 3;



-- Users by Average Session Time
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



-- Acceptance Rate by Date
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