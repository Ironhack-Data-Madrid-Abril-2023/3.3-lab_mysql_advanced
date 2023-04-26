challenge 1



# step 1

select titles.title_id,
	authors.au_id,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100
from authors
inner join titleauthor
on authors.au_id=titleauthor.au_id
inner join titles
on titleauthor.title_id=titles.title_id
inner join sales
on sales.title_id=titles.title_id
inner join roysched
on roysched.royalty=titles.royalty



# step 2

select titles.title_id,
	authors.au_id,
    sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as agg
from authors
inner join titleauthor
on authors.au_id=titleauthor.au_id
inner join titles
on titleauthor.title_id=titles.title_id
inner join sales
on sales.title_id=titles.title_id
inner join roysched
on roysched.royalty=titles.royalty

group by authors.au_id, titles.title_id

order by agg DESC;




# step 3

select ta.au_id AS "Author ID",
SUM(ti.advance + (ti.price * s.qty * ti.royalty * ta.royaltyper / 10000)) AS "Total Profits"
from titleauthor ta
inner join titles ti ON ta.title_id = ti.title_id
inner join sales s ON ti.title_id = s.title_id
inner join roysched r ON ti.royalty = r.royalty
group by ta.au_id
order by "Total Profits" DESC
limit 3;









challenge 2

# ahora combino estas tres querys y pongo create temporary table :

CREATE TEMPORARY TABLE AS TEMP_TABLE

SELECT 
title_id, 
au_id, 
SUM(price * qty * royalty / 100 * titleauthor.royaltyper / 100 * roysched.royalty / 100) AS agg
FROM 
authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id
INNER JOIN roysched ON titles.royalty = roysched.royalty
GROUP BY 
title_id, au_id
    
SELECT 
    ta.au_id AS "Author ID",
    SUM(ti.advance + (ti.price * s.qty * ti.royalty / 100 * ta.royaltyper / 100 * r.royalty / 100)) AS "Total Profits"
FROM 
    titleauthor ta
    INNER JOIN titles ti ON ta.title_id = ti.title_id
    INNER JOIN TEMP_TABLE ON t.title_id = ti.title_id AND t.au_id = ta.au_id
    INNER JOIN sales s ON ti.title_id = s.title_id
    INNER JOIN roysched r ON ti.royalty = r.royalty
GROUP BY 
    ta.au_id
ORDER BY 
    "Total Profits" DESC
LIMIT 3;


challenge 3

create table most_profiting_authors (au_id varchar(11)primary key, profits int); 
insert into most_profiting_authors(au_id, profits) 
SELECT      au_id AS AUTHOR_ID,     SUM(SALES_ROYALE) AS TOTAL_ROYALE 
FROM  (SELECT a.au_id, t.title_id,(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance AS SALES_ROYALE     
FROM authors AS a     

JOIN titleauthor AS ta 
     ON a.au_id = ta.au_id     
JOIN titles AS t      
     ON ta.title_id = t.title_id     

JOIN sales AS s      ON ta.title_id = s.title_id ) AS subquery 
GROUP BY au_id 
ORDER BY TOTAL_ROYALE DESC;
