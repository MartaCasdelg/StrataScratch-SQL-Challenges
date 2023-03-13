# Classify Business Type

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/classify_business_type_1.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/classify_business_type_2.png" />
</div>

&nbsp;


## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/classify_business_type_3.png" />
</div>

&nbsp;


## Solution:

```sql
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
```

&nbsp;

## Explanation:

In order to classify the restaurants, I have used the CASE function, which returns a result if a certain condition is met. In this case, that the name of the business contains a keyword, from which it is categorized as restaurant, cafe, school or other. 

It is important to note that businesses can have these keywords written in several ways. With all letters in uppercase, the first letter in uppercase and the rest in lowercase, only lowercase, .... To solve this problem I apply the LOWER function to the business_name column inside the CASE. 

On the other hand, it should be noted that in the question we are told that the coffees have three keywords. Instead of creating a new condition for each word, we can create a multiple condition by using OR.

By doing this I obtain the expected result.

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Medium/Images/classify_business_type_output.png" />
</div>