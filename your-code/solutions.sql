SELECT 
    sales.title_id AS 'Title ID',
    titleauthor.au_id AS 'Author ID',
    authors.au_fname AS 'First Name',
    authors.au_lname AS 'Last Name',
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
	
FROM 
    sales 
    JOIN titles ON sales.title_id = titles.title_id
    JOIN titleauthor ON sales.title_id = titleauthor.title_id
    JOIN authors ON titleauthor.au_id = authors.au_id
    
ORDER BY 
    titleauthor.au_id,
    sales.title_id;

**********************************

SELECT subq.title_id, subq.au_id, SUM(subq.sales_royalty) AS total_royalties
FROM (
  SELECT titles.title_id, titleauthor.au_id,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
  FROM titles
  INNER JOIN sales ON titles.title_id = sales.title_id
  INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
) AS subq
GROUP BY subq.title_id, subq.au_id;


**********************************

SELECT 
    authors.au_id,
    authors.au_fname,
    authors.au_lname,
    SUM(titles.advance) AS total_advance,
    SUM(subq.total_royalties) AS total_royalties,
    SUM(titles.advance) + SUM(subq.total_royalties) AS total_profit
FROM 
    (SELECT subq.title_id, subq.au_id, SUM(subq.sales_royalty) AS total_royalties
    FROM (
      SELECT titles.title_id, titleauthor.au_id,
        titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
      FROM titles
      INNER JOIN sales ON titles.title_id = sales.title_id
      INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
    ) AS subq
    GROUP BY subq.title_id, subq.au_id) AS subq
    JOIN titleauthor ON subq.title_id = titleauthor.title_id AND subq.au_id = titleauthor.au_id
    JOIN authors ON titleauthor.au_id = authors.au_id
    JOIN titles ON subq.title_id = titles.title_id
GROUP BY 
    authors.au_id,
    authors.au_fname,
    authors.au_lname
ORDER BY 
    total_profit DESC;