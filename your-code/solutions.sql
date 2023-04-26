-- Challenge 1
SELECT
    au_id,
    SUM(Sales_Royalty) AS Total_Royalty
FROM
(SELECT 
    titles.title_id, 
    authors.au_id,
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance AS Sales_Royalty
FROM
    authors
    INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id
    )AS sbq
GROUP BY 
    au_id
ORDER BY Total_Royalty DESC
LIMIT 3;

-- Challenge 2    
CREATE TEMPORARY TABLE temp_table AS
SELECT 
    titles.title_id, 
    authors.au_id,
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance AS Sales_Royalty
FROM
    authors
    INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id;

SELECT
    au_id,
    SUM(Sales_Royalty) AS Total_Royalty
FROM
    temp_table
GROUP BY 
    au_id
ORDER BY Total_Royalty DESC;

DROP TEMPORARY TABLE IF EXISTS temp_table
LIMIT 3;

-- Challenge 3

CREATE TABLE most_profiting_authors (
    au_id varchar(11) PRIMARY KEY,
    profits int);
INSERT INTO most_profiting_authors (au_id, profits)
SELECT
    au_id,
    SUM(Sales_Royalty) AS Total_Royalty
FROM
(SELECT 
    titles.title_id, 
    authors.au_id,
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + titles.advance AS Sales_Royalty
FROM
    authors
    INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id
    )AS sbq
GROUP BY 
    au_id
ORDER BY Total_Royalty DESC;
