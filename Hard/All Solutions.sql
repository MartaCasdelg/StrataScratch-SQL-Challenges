-- Counting instances in text
SELECT
    word,
    nentry
FROM
    ts_stat('SELECT to_tsvector(contents) FROM google_file_store')
WHERE
    word IN ('bull', 'bear');