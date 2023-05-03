/*paso 1*/

SELECT titles.title_id, authors.au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty

FROM titles

LEFT JOIN sales ON titles.title_id = sales.title_id

LEFT JOIN titleauthor ON sales.title_id = titleauthor.title_id

LEFT JOIN authors ON titleauthor.au_id = authors.au_id;

/*paso 2*/

SELECT titleauthor.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty

FROM titleauthor

JOIN titles ON titles.title_id = titleauthor.title_id

JOIN sales ON sales.title_id = titles.title_id

GROUP BY titleauthor.au_id, titles.title_id

/*paso 3*/

ORDER BY sales_royalty desc

LIMIT 3;

/*Challenge 2*/

CREATE TEMPORARY TABLE Challenge_2 AS 
(SELECT titleauthor.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty

FROM titleauthor

JOIN titles ON titles.title_id = titleauthor.title_id

JOIN sales ON sales.title_id = titles.title_id

GROUP BY titleauthor.au_id, titles.title_id

ORDER BY sales_royalty desc

LIMIT 3)
