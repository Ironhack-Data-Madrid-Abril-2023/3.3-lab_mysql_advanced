/* Challenge 1*/
	/* Step 1: Calculate the royalties of each sales for each author */
SELECT  authors.au_id AS 'AUTHOR ID', titles.title, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'Royalty'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id = titles.title_id
ORDER BY Royalty DESC;

	/* Step 2: Aggregate the total royalties for each title for each author*/
    
SELECT titleauthor.title_id AS 'Title_ID', titleauthor.au_id AS 'AUTHOR_ID', SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SUMA_ROYALTIES'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id = titles.title_id
GROUP BY  titleauthor.title_id, titleauthor.au_id;

	/*Step 3: Calculate the total profits of each author*/
SELECT au_id, SUM(SUMA_ROYALTIES) AS 'SUMA'
FROM (
SELECT authors.au_id, titles.title_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SUMA_ROYALTIES'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id = titles.title_id
) AS SOLUCION
GROUP BY au_id
ORDER BY SUMA DESC
LIMIT 3;

/* Challenge 2*/

CREATE TEMPORARY TABLE CHALLENGE2SOLUTION AS 

SELECT authors.au_id, titles.title_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SUMA_ROYALTIES'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id = titles.title_id;

SELECT  au_id, SUM(SUMA_ROYALTIES) AS 'SUMA'
FROM CHALLENGE2SOLUTION
GROUP BY au_id
ORDER BY SUMA DESC
LIMIT 3;

/* Challenge 3*/

CREATE TABLE most_profiting_authors (au_id VARCHAR(11) NOT NULL, profits DECIMAL(10,2) NOT NULL);
  
INSERT INTO most_profiting_authors (au_id, profits)
SELECT titleauthor.au_id, SUM(titleauthor.royalty + titleauthor.advance) AS profits
FROM titleauthor
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY titleauthor.au_id
ORDER BY profits DESC;

