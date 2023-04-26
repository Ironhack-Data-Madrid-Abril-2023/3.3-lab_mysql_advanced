-- Challenge 1 

-- Step 1 

select authors.au_id, titles.title_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id 
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on  sales.title_id = titles.title_id;

-- step 2

select authors.au_id, titles.title_id, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id 
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on  sales.title_id = titles.title_id
group by authors.au_id, titles.title_id;

-- Step 3 

SELECT subquery.au_id, SUM(subquery.sales_royalty) as royaltytotal
FROM (
    SELECT authors.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
    FROM authors
    INNER JOIN titleauthor
    ON authors.au_id = titleauthor.au_id 
    INNER JOIN titles
    ON titleauthor.title_id = titles.title_id
    INNER JOIN sales
    ON  sales.title_id = titles.title_id
    GROUP BY authors.au_id, titles.title_id
) as subquery
GROUP BY subquery.au_id
ORDER BY royaltytotal DESC    
LIMIT 3;

-- Challenge 2 

create temporary table publication.royalty_total

SELECT subquery.au_id, SUM(subquery.sales_royalty) as royaltytotal
FROM (
    SELECT authors.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
    FROM authors
    INNER JOIN titleauthor
    ON authors.au_id = titleauthor.au_id 
    INNER JOIN titles
    ON titleauthor.title_id = titles.title_id
    INNER JOIN sales
    ON  sales.title_id = titles.title_id
    GROUP BY authors.au_id, titles.title_id
) as subquery
GROUP BY subquery.au_id
ORDER BY royaltytotal DESC    
LIMIT 3;

challenge 3 

CREATE TABLE most_profiting_authors
SELECT subquery.au_id, SUM(subquery.sales_royalty) as royaltytotal
FROM (
    SELECT authors.au_id, titles.title_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
    FROM authors
    INNER JOIN titleauthor
    ON authors.au_id = titleauthor.au_id 
    INNER JOIN titles
    ON titleauthor.title_id = titles.title_id
    INNER JOIN sales
    ON  sales.title_id = titles.title_id
    GROUP BY authors.au_id, titles.title_id
) as subquery
GROUP BY subquery.au_id
ORDER BY royaltytotal DESC    
LIMIT 3;



