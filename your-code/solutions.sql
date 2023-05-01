select a.au_id as Author_id, 
t.title_id as Title, 
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from authors as a
left join titleauthor as ta on a.au_id=ta.au_id
left join titles as t on t.title_id=ta.title_id
left join sales as s on t.title_id=s.title_id
order by sales_royalty desc; 



select a.au_id as Author_id,
t.title_id as Title,
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from authors as a
left join titleauthor as ta on a.au_id=ta.au_id
left join titles as t on t.title_id=ta.title_id
left join sales as s on t.title_id=s.title_id

group by a.au_id, t.title_id
order by sales_royalty desc;


select a.au_id as Author_id,
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from authors as a
left join titleauthor as ta on a.au_id=ta.au_id
left join titles as t on t.title_id=ta.title_id
left join sales as s on t.title_id=s.title_id

group by a.au_id
order by sales_royalty desc
limit 3;


create temporary table table2
select a.au_id as Author_id, 
t.title_id as Title, 
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

from authors as a
left join titleauthor as ta on a.au_id=ta.au_id
left join titles as t on t.title_id=ta.title_id
left join sales as s on t.title_id=s.title_id
order by sales_royalty desc; 



select Author_id, Title , sales_royalty
from table2;


select Author_id, sales_royalty

from table2;



create table most_profiting_authors
select Author_id, sales_royalty as profits
from table2