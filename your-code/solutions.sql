create temporary table  if not exists temp1
select t.title_id, au.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id;
select * 
from temp1;

create temporary table if not exists temp2 
select title_id, au_id, sum(sales_royalty) as 'Total Royalties'
from temp1
group by title_id, au_id;

select au_id, ('Total Royalties' + t.advance) as Profits
from temp2
inner join titles as t
on temp2.title_id = t.title_id
order by Profits desc
limit 3;

-- CHALLENGE 2
select au_id, ('Total Royalties' + t.advance) as Profits
from 
(select title_id, au_id, sum(sales_royalty) as 'Total Royalties'
from 
(select t.title_id, au.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) as t1
group by title_id, au_id) as t2
inner join titles as t
on t2.title_id = t.title_id
order by Profits desc;

-- CHALLENGE 3

create table if not exists most_profiting_authors 
select au_id, ('Total Royalties' + t.advance) as Profits
from 
(select title_id, au_id, sum(sales_royalty) as 'Total Royalties'
from 
(select t.title_id, au.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) as t1
group by title_id, au_id) as t2
inner join titles as t
on t2.title_id = t.title_id
order by Profits desc;

-- Esto no tira y ni con yona conseguimos que tirase. No se porque y no encontré porque