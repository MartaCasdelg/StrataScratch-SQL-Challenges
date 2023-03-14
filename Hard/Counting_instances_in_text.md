# Counting instances in text

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/counting_instances_in_text_1.png" />
</div>

&nbsp;

## Expected Output

<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/counting_instances_in_text_2.png" />
</div>

&nbsp;


## Solution:

```sql
SELECT
    word,
    nentry
FROM
    ts_stat('SELECT to_tsvector(contents) FROM google_file_store')
WHERE
    word IN ('bull', 'bear');
```
&nbsp;

## Explanation:

To get the number of times the words 'bull' and 'bear' are mentioned in the contents column, I used the ts_stat function. This function executes a query and returns statistics about each word contained in the query result. 

The query must be written inside the parenthesis in text format and must return as result a column of tsvector type (this data type reduces the text to a list of lexemes). Then, ts_stat executes the query, which in this case returns the contents column in type tsvector, and returns information about each lexeme. The information it can provide is:

* word (text) - the value of a lexeme
* ndoc (integer) - number of documents (tsvectors) the word occurred in
* nentry (integer) - total number of occurrences of the word

In this case we are asked for the result to show the name of the word and the number of times it appears in the column. Therefore, in the SELECT clause I select the columns word and nentry. As a result, I get the expected output.


<div id="header" align="center">
  <img src="https://github.com/MartaCasdelg/StrataScratch-SQL-Challenges/blob/main/Hard/Images/counting_instances_in_text_output.png" />
</div>