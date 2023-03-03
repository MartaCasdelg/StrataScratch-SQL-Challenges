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

--Second solution:
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