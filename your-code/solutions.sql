#Challege 1 Step 1

SELECT a.au_id AS 'AUTHOR ID', 
		t.title_id AS 'TITLE ID', 
		t.price*s.qty*t.royalty/100*ta.royaltyper AS 'SALES ROYALTY'
FROM authors a 
JOIN titleauthor ta ON a.au_id = ta.au_id 
JOIN titles t ON t.title_id = ta.title_id 
JOIN sales s ON s.title_id = t.title_id
order by (t.price*s.qty*t.royalty/100*ta.royaltyper) desc;

#Challenge 1 Step 2

SELECT a.au_id AS 'AUTHOR ID', 
		t.title_id AS 'TITLE ID', 
		sum(t.price*s.qty*t.royalty/100*ta.royaltyper/100) AS 'SALES ROYALTY'
FROM authors a 
JOIN titleauthor ta ON a.au_id = ta.au_id 
JOIN titles t ON t.title_id = ta.title_id 
JOIN sales s ON s.title_id = t.title_id
group by a.au_id, t.title_id;


#Challenge 1 Step 3

SELECT a.au_id AS 'AUTHOR ID', 
		sum(t.price*s.qty*t.royalty/100*ta.royaltyper/100) + t.advance AS 'PROFITS'
FROM authors a 
JOIN titleauthor ta ON a.au_id = ta.au_id 
JOIN titles t ON t.title_id = ta.title_id 
JOIN sales s ON s.title_id = t.title_id
group by a.au_id, t.title_id
order by "PROFITS" Desc;


#Challenge 2

CREATE TEMPORARY TABLE temp_table 
SELECT a.au_id AS 'AUTHOR ID', 
		sum(t.price*s.qty*t.royalty/100*ta.royaltyper/100) + t.advance AS 'PROFITS'
FROM authors a 
JOIN titleauthor ta ON a.au_id = ta.au_id 
JOIN titles t ON t.title_id = ta.title_id 
JOIN sales s ON s.title_id = t.title_id
group by a.au_id, t.title_id
order by "PROFITS" Desc;

#Challenge 3

CREATE TABLE most_profiting_authors
SELECT a.au_id as "Author ID", (sum(t.price*s.qty*t.royalty/100*ta.royaltyper/100) + t.advance) as "Profits"

FROM authors a 
JOIN titleauthor ta ON a.au_id = ta.au_id 
JOIN titles t ON t.title_id = ta.title_id 
JOIN sales s ON s.title_id = t.title_id
group by a.au_id, t.title_id
order by "PROFITS" Desc;

