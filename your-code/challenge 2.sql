create temporary table temp_table as
SELECT
        a.au_id,
        t.title_id,
        t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS SALES_ROYALE
    FROM authors AS a
    JOIN titleauthor AS ta 
    ON a.au_id = ta.au_id
    JOIN titles AS t 
    ON ta.title_id = t.title_id
    JOIN sales AS s 
    ON ta.title_id = s.title_id;
SELECT 
    au_id AS AUTHOR_ID,
    SUM(SALES_ROYALE) AS TOTAL_ROYALE
from temp_table
GROUP BY au_id
ORDER BY TOTAL_ROYALE DESC;
drop temporary table if exists temp_table;