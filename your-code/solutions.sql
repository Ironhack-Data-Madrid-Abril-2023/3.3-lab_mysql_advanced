-- Challenge 1
-- Step 1

SELECT titles.title_id AS Title_ID, 
 au_id AS Author_ID,
 (titles.price*sales.qty* titles.royalty/100*titleauthor.royaltyper/100) AS Sales_Royalty
FROM 
  titles
  INNER JOIN titleauthor
  ON titles.title_id = titleauthor.title_id
  INNER JOIN sales 
  ON titles.title_id = sales.title_id
ORDER BY titles.title_id;

-- Step 2 

SELECT titles.title_id AS Title_ID, 
 au_id AS Author_ID,
 sum(titles.price*sales.qty* titles.royalty/100*titleauthor.royaltyper/100) AS Sales_Royalty
FROM 
  titles
  INNER JOIN titleauthor
  ON titles.title_id = titleauthor.title_id
  INNER JOIN sales 
  ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id
ORDER BY Title_ID, titleauthor.au_id DESC;

-- Step 3

DROP TABLE IF EXISTS temp3;
CREATE TEMPORARY TABLE temp3 AS( 
SELECT titles.title_id AS Title_ID, 
 titleauthor.au_id AS Author_ID,
 sum(titles.price*sales.qty* titles.royalty/100*titleauthor.royaltyper/100) AS Sales_Royalty,
 titles.advance AS Advance
FROM 
  titles
  INNER JOIN titleauthor
  ON titles.title_id = titleauthor.title_id
  INNER JOIN sales 
  ON titles.title_id = sales.title_id
GROUP BY titles.title_id, titleauthor.au_id
);

SELECT Author_ID,  
SUM(Sales_Royalty)+sum(Advance) AS Total_Profit
FROM temp3
GROUP BY Author_ID
ORDER BY Total_Profit DESC
LIMIT 3; 

-- Challenge 2: Subquery

select 
Author_ID,
sum(Advance) + sum(Sales_Royalty) as Total_Profits
from 
(SELECT titles.title_id AS Title_ID, 
 au_id AS Author_ID,
 titles.price*sales.qty* titles.royalty/100*titleauthor.royaltyper/100 AS Sales_Royalty,
 titles.advance AS Advance
FROM 
  titles
  INNER JOIN titleauthor
  ON titles.title_id = titleauthor.title_id
  INNER JOIN sales 
  ON titles.title_id = sales.title_id) as sub
GROUP BY Author_ID
ORDER BY Total_Profits DESC 
LIMIT 3;

-- Challenge 3
CREATE TABLE most_profiting_authors
select 
Author_ID,
sum(Advance) + sum(Sales_Royalty) as Total_Profits
from 
(SELECT titles.title_id AS Title_ID, 
 au_id AS Author_ID,
 titles.price*sales.qty* titles.royalty/100*titleauthor.royaltyper/100 AS Sales_Royalty,
 titles.advance AS Advance
FROM 
  titles
  INNER JOIN titleauthor
  ON titles.title_id = titleauthor.title_id
  INNER JOIN sales 
  ON titles.title_id = sales.title_id) as sub
GROUP BY Author_ID
ORDER BY Total_Profits DESC 
LIMIT 3;