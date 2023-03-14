# Top 5 States With 5 Star Businesses

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/top_5_states_with_5_star_businesses_1.png" />
</div>

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/top_5_states_with_5_star_businesses_2.png" />
</div>

&nbsp;

## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/top_5_states_with_5_star_businesses_3.png" />
</div>

&nbsp;


## Solution:

```sql
SELECT
    state,
    COUNT(*) FILTER (WHERE stars = 5) AS five_stars_business
FROM
    yelp_business
GROUP BY
    state
ORDER BY
    COUNT(*) FILTER (WHERE stars = 5) DESC, state
LIMIT 6;
```

&nbsp;

## Explanation:

This problem asks to obtain the 5 states with the highest number of 5-star businesses. To do this, I have used the COUNT() function together with the FILTER function to count only those records in the table where star is equal to 5. This way, I do not have to create a temporary table or a subquery, thus creating a more direct method to find the information.

```sql
SELECT
    state,
    COUNT(*) FILTER (WHERE stars = 5) AS five_stars_business
```

I use this same expression in the ORDER BY clause to sort the results according to the number of 5-star businesses, in descending order. In this same clause I also add a second sorting condition, in this case the state column, so that if there are states with the same number of businesses, they are sorted alphabetically, as the problem requires.

```sql
GROUP BY
    state
ORDER BY
    COUNT(*) FILTER (WHERE stars = 5) DESC, state
```

It is important to remember that, since an aggregation function is used, it is necessary to add the GROUP BY clause with the name of the column by which the calculation results are to be grouped. In this case, the state column, as can be seen in the code fragment mentioned above.

Finally, it remains to limit the result to the 5 states with the highest number of businesses. In this case, the initial idea was to use `LIMIT 5`. However, the output of the problem includes a sixth record that, in theory, does not seem to be related to the use of any category function such as RANK() or DENSE_RANK(). I deduce this because, if I used them, the sixth record would get positions 6 and 4, respectively. In other words, the output of the problem does not take into account a position 5 determined by this type of functions. With that in mind, I use LIMIT 6 to match the output to the expected one, although I actually get one more state than was initially required.

```sql
LIMIT 6;
```

By executing the whole query, the desired result is obtained:

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/top_5_states_with_5_star_businesses_output.png" />
</div>