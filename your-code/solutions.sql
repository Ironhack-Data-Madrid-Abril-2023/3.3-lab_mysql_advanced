Challenge 1.

SELECT titles.title_id AS TITLE_ID,
		authors.au_id AS AUTHOR_ID,
        titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS ROYALTIES
FROM titles
		LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
        LEFT JOIN authors ON titleauthor.au_id = authors.au_id
        LEFT JOIN sales ON titles.title_id = sales.title_id
        ;

