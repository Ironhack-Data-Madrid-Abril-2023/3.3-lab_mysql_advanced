-- CHALLENGE 1

-- STEP 1

SELECT authors.au_id AS AUTHOR_ID,
	titles.title_id AS TITLE_ID,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as SALES_ROYALTY
FROM authors
JOIN titleauthor 
ON authors.au_id = titleauthor.au_id
JOIN titles 
ON titleauthor.title_id = titles.title_id
JOIN sales
ON titles.title_id = sales.title_id
JOIN roysched
ON titles.title_id = roysched.title_id;

-- STEP 2

SELECT authors.au_id AS AUTHOR_ID,
	titles.title_id AS TITLE_ID,
    SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as SALES_ROYALTY
FROM authors
JOIN titleauthor 
ON authors.au_id = titleauthor.au_id
JOIN titles 
ON titleauthor.title_id = titles.title_id
JOIN sales
ON titles.title_id = sales.title_id
JOIN roysched
ON titles.title_id = roysched.title_id
GROUP BY AUTHOR_ID, TITLE_ID;

-- STEP 3

SELECT authors.au_id AS AUTHOR_ID,
	(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance) AS PROFIT
FROM authors
LEFT JOIN titleauthor 
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles 
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
LEFT JOIN roysched
ON titles.title_id = roysched.title_id
GROUP BY AUTHOR_ID, titles.title_id
ORDER BY PROFIT DESC LIMIT 3;

-- CHALLENGE 2

-- TABLA TEMPORAL

CREATE TEMPORARY TABLE total_royalties
SELECT authors.au_id AS AUTHOR_ID,
	(SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance) AS PROFIT
FROM authors
LEFT JOIN titleauthor 
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles 
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
LEFT JOIN roysched
ON titles.title_id = roysched.title_id
GROUP BY AUTHOR_ID, titles.title_id;

-- TABLA DERIVADA

-- creo la tabla derivada a partir de la tabla temporal

CREATE TABLE tabla_derivada 
SELECT AUTHOR_ID, SUM(PROFIT) AS TOTAL_PROFIT
FROM total_royalties
GROUP BY AUTHOR_ID;

-- CHALLENGE 3

-- primero me creo una tabla vacía y luego la lleno

CREATE TABLE most_profiting_authors (
  au_id VARCHAR(50),
  profits FLOAT
);

-- una vez creada le meto la información de mi temporary table

INSERT INTO most_profiting_authors (au_id, profits)
SELECT AUTHOR_ID, SUM(PROFIT) AS PROFITS
FROM total_royalties
GROUP BY AUTHOR_ID;

-- aquí he tenido que borrar algunas tablas y volveras a crear porque me daban fallos

DROP TEMPORARY TABLE total_royalties;
DROP TABLE tabla_derivada;
DROP TABLE most_profiting_authors;





