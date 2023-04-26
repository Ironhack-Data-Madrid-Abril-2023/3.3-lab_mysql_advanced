-- challenge 1

-- paso 1

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select  titles.title_id as "TITLE ID",
		titleauthor.au_id as "AUTHOR ID" , 
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from authors
LEFT join titleauthor
on titleauthor.au_id = authors.au_id
LEFT join titles
on titleauthor.title_id = titles.title_id
LEFT join sales
on titles.title_id = sales.title_id
LEFT join roysched

-- paso 2

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select  titles.title_id as "TITLE ID",
		titleauthor.au_id as "AUTHOR ID" , 
		sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
LEFT join titleauthor
on titleauthor.au_id = authors.au_id
LEFT join titles
on titleauthor.title_id = titles.title_id
LEFT join sales
on titles.title_id = sales.title_id
LEFT join roysched
on sales.title_id = roysched.title_id
group by titleauthor.au_id, titles.title_id
order by sales_royalty desc

-- paso 3

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select  titleauthor.au_id as "AUTHOR ID" , 
		sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
LEFT join titleauthor
on titleauthor.au_id = authors.au_id
LEFT join titles
on titleauthor.title_id = titles.title_id
LEFT join sales
on titles.title_id = sales.title_id
LEFT join roysched
on sales.title_id = roysched.title_id
group by titleauthor.au_id
order by sales_royalty desc
limit 3;

-- challenge 2

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
create temporary table author_profits
as
select  titles.title_id as TITLE_ID,
		titleauthor.au_id as AUTHOR_ID , 
		sum(titles.price * sales.qty * 
        titles.royalty / 100 * titleauthor.royaltyper / 100) 
        as sales_royalty
from authors
LEFT join titleauthor
on titleauthor.au_id = authors.au_id
LEFT join titles
on titleauthor.title_id = titles.title_id
LEFT join sales
on titles.title_id = sales.title_id
LEFT join roysched
on sales.title_id = roysched.title_id
group by titleauthor.au_id, titles.title_id
order by sales_royalty desc;

-- challenge  3

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
create table author_royalties
select  titleauthor.au_id as AUTHOR_ID , 
		sum(titles.price * sales.qty * 
        titles.royalty / 100 * titleauthor.royaltyper / 100) 
        as sales_royalty
from authors
LEFT join titleauthor
on titleauthor.au_id = authors.au_id
LEFT join titles
on titleauthor.title_id = titles.title_id
LEFT join sales
on titles.title_id = sales.title_id
LEFT join roysched
on sales.title_id = roysched.title_id
group by titleauthor.au_id, titles.title_id
order by sales_royalty desc;