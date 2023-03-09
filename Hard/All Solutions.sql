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