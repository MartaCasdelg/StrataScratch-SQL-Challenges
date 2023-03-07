-- Count the number of companies in the Information Technology sector in each country
SELECT 
    country,
    COUNT(company) 
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology'
GROUP BY
    country;

--Other solution
SELECT DISTINCT
    country,
    COUNT(company) OVER (PARTITION BY country) AS number_of_companies
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Information Technology';