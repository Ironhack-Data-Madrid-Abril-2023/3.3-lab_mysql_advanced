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

create temporary table if not exists temporary_table_1
select ta.au_id AS "Author ID",
SUM(ti.advance + (ti.price * s.qty * ti.royalty * ta.royaltyper / 10000)) AS "Total Profits"
from titleauthor ta
inner join titles ti ON ta.title_id = ti.title_id
inner join sales s ON ti.title_id = s.title_id
inner join roysched r ON ti.royalty = r.royalty
group by ta.au_id
order by "Total Profits" DESC
limit 3;

select * from temporary_table_1


challenge 3

create table if not exists temporary_table_2
select ta.au_id AS "Author ID",
SUM(ti.advance + (ti.price * s.qty * ti.royalty * ta.royaltyper / 10000)) AS "Total Profits"
from titleauthor ta
inner join titles ti ON ta.title_id = ti.title_id
inner join sales s ON ti.title_id = s.title_id
inner join roysched r ON ti.royalty = r.royalty
group by ta.au_id
order by "Total Profits" DESC
limit 3;

select * from temporary_table_2
