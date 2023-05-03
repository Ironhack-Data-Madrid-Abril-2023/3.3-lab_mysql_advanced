CREATE TEMPORARY TABLE Challenge_2 AS 
(SELECT titleauthor.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty

FROM titleauthor

JOIN titles ON titles.title_id = titleauthor.title_id

JOIN sales ON sales.title_id = titles.title_id

GROUP BY titleauthor.au_id, titles.title_id

ORDER BY sales_royalty desc

LIMIT 3)


