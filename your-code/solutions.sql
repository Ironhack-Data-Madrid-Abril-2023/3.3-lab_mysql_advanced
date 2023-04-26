Challenge 1 - Most Profiting Authors

----------> Step 1: Calculate the royalties of each sales for each author
select authors.au_id, titles.title_id,(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty 
from authors
inner join titleauthor on authors.au_id =titleauthor.au_id
inner join titles on  titles.title_id = titles.title_id
inner join sales on sales.title_id = titles.title_id


----------> Step 2: Aggregate the total royalties for each title for each author


select authors. au_id, titles.title_id, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id =titleauthor.au_id
inner join titles on  titleauthor.title_id = titles.title_id
inner join sales on sales.title_id = titles.title_id
group by authors.au_id, titles.title_id


----------> Step 3: Calculate the total profits of each author

select subquery.au_id, sum (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from (
select authors. au_id, titles.title_id, sum (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id =titleauthor.au_id
inner join titles on  titleauthor.title_id = titles.title_id
inner join sales on sales.title_id = titles.title_id
group by authors.au_id, titles.title_id
) as subquery
group by subquery.au_id
order by sales_royalty desc

----------> Step 3: the temporary table

create temporary table stores.subquery
select stores.stor_id as storeID, stores.stor_name as store,
select subquery.au_id, sum (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from (
select authors. au_id, titles.title_id, sum (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id =titleauthor.au_id
inner join titles on  titleauthor.title_id = titles.title_id
inner join sales on sales.title_id = titles.title_id
group by authors.au_id, titles.title_id
) as subquery
group by subquery.au_id
order by sales_royalty desc

----------> Challenge 3

create table publications.most_profiting_authors
select authors. au_id, titles.title_id, concat(authors.au_fname, ' ', authors.au_lname) as completename, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as Profit
from authors 
inner join titleauthor on authors.au_id =titleauthor.au_id
inner join titles on  titleauthor.title_id = titles.title_id
inner join sales on sales.title_id = titles.title_id
group by authors.au_id, titles.title_id


