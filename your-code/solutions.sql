-- Challenge 1

-- STEP 1

SELECT a.au_id AS author_id, t.title_id AS title_id, 
	   (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM authors AS a
INNER JOIN titleauthor AS ta
ON a.au_id = ta.au_id
INNER JOIN titles AS t
ON ta.title_id = t.title_id
INNER JOIN sales AS s
ON t.title_id = s.title_id
ORDER BY title_id DESC
;

-- Step 2

SELECT a.au_id AS author_id, t.title_id AS title_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM authors AS a
INNER JOIN titleauthor AS ta
ON a.au_id = ta.au_id
INNER JOIN titles AS t
ON ta.title_id = t.title_id
INNER JOIN sales AS s
ON t.title_id = s.title_id
GROUP BY a.au_id, t.title_id
ORDER BY title_id DESC
;

-- Step 3

CREATE TEMPORARY TABLE temp3
SELECT a.au_id AS author_id, t.title_id AS title_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty, t.advance
FROM authors AS a
INNER JOIN titleauthor AS ta
ON a.au_id = ta.au_id
INNER JOIN titles AS t
ON ta.title_id = t.title_id
INNER JOIN sales AS s
ON t.title_id = s.title_id
GROUP BY a.au_id, t.title_id
;

SELECT author_id, SUM(advance) + SUM(sales_royalty) AS total_earnings
FROM temp3
GROUP BY author_id
ORDER BY author_id DESC
LIMIT 3
;

-- Challenge 2

SELECT author_id, SUM(advance) + SUM(sales_royalty) AS total_earnings
FROM (
    SELECT a.au_id AS author_id, t.title_id AS title_id, SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty, t.advance
    FROM authors AS a
    INNER JOIN titleauthor AS ta
        ON a.au_id = ta.au_id
    INNER JOIN titles AS t
        ON ta.title_id = t.title_id
    INNER JOIN sales AS s
        ON t.title_id = s.title_id
    GROUP BY a.au_id, t.title_id
) AS temp3
GROUP BY author_id
ORDER BY author_id DESC
LIMIT 3;

-- Challenge 3

CREATE TABLE tabla_final3
SELECT author_id, SUM(advance) + SUM(sales_royalty) AS total_earnings
FROM (
    SELECT a.au_id AS author_id, t.title_id AS title_id, SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty, t.advance
    FROM authors AS a
    INNER JOIN titleauthor AS ta
        ON a.au_id = ta.au_id
    INNER JOIN titles AS t
        ON ta.title_id = t.title_id
    INNER JOIN sales AS s
        ON t.title_id = s.title_id
    GROUP BY a.au_id, t.title_id
) AS temp3
GROUP BY author_id
ORDER BY author_id DESC
;