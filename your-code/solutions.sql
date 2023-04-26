-- challenge 1 y 2
create temporary table newschema.royalty_summary

SELECT
	titles.title_id,
    authors.au_id,
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty

FROM 
titles
		left join sales on titles.title_id = sales.title_id
        left join titleauthor on sales.title_id = titleauthor.title_id
        left join authors on titleauthor.au_id = authors.au_id
GROUP BY
		titles.title_id, 	
        authors.au_id	
		ORDER BY sales_royalty desc
        limit 3
;
-- challenge 3	

create table newschema.most_profiting_authors

SELECT
    authors.au_id,
	SUM(titles.advance + titles.royalty) AS profits

FROM 
titles
		left join sales on titles.title_id = sales.title_id
        left join titleauthor on sales.title_id = titleauthor.title_id
        left join authors on titleauthor.au_id = authors.au_id
GROUP BY
        authors.au_id	
		ORDER BY profits desc
        limit 3
;