SELECT 
    subquery.au_id AS AUTHOR_ID,
    SUM(SALES_ROYALE) AS TOTAL_ROYALE
FROM 
    (SELECT
        a.au_id,
        t.title_id,
        (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance AS SALES_ROYALE
    FROM authors AS a
    JOIN titleauthor AS ta 
    ON a.au_id = ta.au_id
    JOIN titles AS t 
    ON ta.title_id = t.title_id
    JOIN sales AS s 
    ON ta.title_id = s.title_id
) AS subquery
GROUP BY au_id
ORDER BY TOTAL_ROYALE DESC
limit 3;