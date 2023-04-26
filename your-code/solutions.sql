
-- Challenge 1
-- Step 1
SELECT 
	titles.title_id AS tituloID,
    titleauthor.au_id AS autoresID, 
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM 
	sales
	LEFT JOIN titles ON sales.title_id = titles.title_id
	LEFT JOIN titleauthor ON titleauthor.title_id = titles.title_id;

-- Step 2
SELECT 
	titles.title_id AS tituloID,
	titleauthor.au_id AS autoresID, 
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM 
	sales
	LEFT JOIN titles ON sales.title_id = titles.title_id
	LEFT JOIN titleauthor ON titleauthor.title_id = titles.title_id
GROUP BY tituloID, autoresID
ORDER BY sales_royalty DESC;



-- Step 3
SELECT 
	titleauthor.au_id AS autoresID, 
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM 
	sales
	LEFT JOIN titles ON sales.title_id = titles.title_id
	LEFT JOIN titleauthor ON titleauthor.title_id = titles.title_id
GROUP BY  autoresID
ORDER BY sales_royalty DESC
LIMIT 3;

-- Challenge 2
CREATE TEMPORARY TABLE publications.Temporal
SELECT 
	titles.title_id AS tituloID,
    titleauthor.au_id AS autoresID, 
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM 
	sales
	LEFT JOIN titles ON sales.title_id = titles.title_id
	LEFT JOIN titleauthor ON titleauthor.title_id = titles.title_id;

SELECT 
	autoresID,
    SUM(sales_royalty) AS total_royalty
FROM 
	Temporal
	GROUP BY  autoresID
	ORDER BY total_royalty DESC;
    
    
-- Challenge 3
CREATE TABLE most_profiting_authors 
SELECT 
	autoresID,
    SUM(Profit) AS Profits
FROM
	(SELECT
		titleauthor.au_id AS autoresID,
		(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance AS Profit
	FROM 
		sales
		LEFT JOIN titles ON sales.title_id = titles.title_id
		LEFT JOIN titleauthor ON titleauthor.title_id = titles.title_id)
	AS Seleccion
GROUP BY autoresID
ORDER BY Profits DESC;

SELECT * FROM most_profiting_authors;