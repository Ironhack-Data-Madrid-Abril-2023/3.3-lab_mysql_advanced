challenge 1
SELECT 
    au_id,
    SUM(titles.advance + royalties) as beneficios 

FROM 
    titles 
    LEFT JOIN (SELECT 
            title_id, 
            au_id, 
            SUM(sales_royalty) as royalties 
        FROM 
            (SELECT 
                titles.title_id, 
                titleauthor.au_id, 
                (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
            FROM 
                titles 
                JOIN titleauthor ON titles.title_id = titleauthor.title_id 
                JOIN sales ON titles.title_id = sales.title_id) as sq 
        GROUP BY 
            au_id,
            title_id) as sq  ON titles.title_id = sq.title_id 
GROUP BY 
    au_id 
ORDER BY 
	beneficios DESC 
LIMIT 3;

challenge2

CREATE TEMPORARY TABLE temporalm (
    title_id VARCHAR(20),
    au_id VARCHAR(20),
    sales_royalty FLOAT
);

INSERT INTO temporalm (title_id, au_id, sales_royalty)
SELECT 
    titles.title_id, 
    titleauthor.au_id, 
    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
FROM 
    titles 
    JOIN titleauthor ON titles.title_id = titleauthor.title_id 
    JOIN sales ON titles.title_id = sales.title_id;

SELECT 
    au_id,
    SUM(titles.advance + royalties) as beneficios 
FROM 
    titles 
    LEFT JOIN (SELECT 
            title_id, 
            au_id, 
            SUM(sales_royalty) as royalties 
        FROM 
            temporalm
        GROUP BY 
            au_id,
            title_id) as sq  ON titles.title_id = sq.title_id 
GROUP BY 
    au_id 
ORDER BY 
    beneficios DESC 
LIMIT 3;

DROP TEMPORARY TABLE temporalm;

challenge 3

SELECT 
    au_id,
    SUM(titles.advance + royalties) as beneficios 

FROM 
    titles 
    LEFT JOIN (SELECT 
            title_id, 
            au_id, 
            SUM(sales_royalty) as royalties 
        FROM 
            (SELECT 
                titles.title_id, 
                titleauthor.au_id, 
                (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
            FROM 
                titles 
                JOIN titleauthor ON titles.title_id = titleauthor.title_id 
                JOIN sales ON titles.title_id = sales.title_id) as sq 
        GROUP BY 
            au_id,
            title_id) as sq  ON titles.title_id = sq.title_id 
GROUP BY 
    au_id 
ORDER BY 
	beneficios DESC 
LIMIT 3;

