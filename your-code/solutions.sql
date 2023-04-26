-- STEP 1

SELECT ta.title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty 
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN roysched as r
ON ta.title_id = r.title_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
;

-- STEP 2

SELECT ta.title_id, ta.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN roysched as r
ON ta.title_id = r.title_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY t.title_id, ta.au_id

;

-- STEP 3

SELECT ta.au_id, t.advance + sales_royalty as profits

FROM 

(SELECT ta.title_id, ta.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN roysched as r
ON ta.title_id = r.title_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY t.title_id, ta.au_id) as s_royal

JOIN titleauthor AS ta 
ON s_royal.au_id = ta.au_id AND s_royal.title_id = ta.title_id
JOIN titles AS t 
ON s_royal.title_id = t.title_id

ORDER BY total DESC
LIMIT 3
;

-- Alternativa 

CREATE TEMPORARY TABLE IF NOT EXISTS sumatorio AS (
SELECT ta.title_id, ta.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN roysched as r
ON ta.title_id = r.title_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY t.title_id, ta.au_id )

;


SELECT ta.au_id, t.advance + sales_royalty as profits
FROM sumatorio AS s_royal
INNER JOIN titleauthor AS ta 
ON s_royal.au_id = ta.au_id AND s_royal.title_id = ta.title_id
INNER JOIN titles AS t 
ON s_royal.title_id = t.title_id

ORDER BY profits DESC
LIMIT 3

;

-- CHALLENGE 3
/* CREATE TABLE most_profiting_authors (

SELECT ta.au_id, t.advance + sales_royalty as profits

FROM 

(SELECT ta.title_id, ta.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN roysched as r
ON ta.title_id = r.title_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY t.title_id, ta.au_id) as s_royal

JOIN titleauthor AS ta 
ON s_royal.au_id = ta.au_id AND s_royal.title_id = ta.title_id
JOIN titles AS t 
ON s_royal.title_id = t.title_id)

;*/

