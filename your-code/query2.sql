-- CREATE TEMPORARY TABLE temp_sales (
--     title_id VARCHAR(20) NOT NULL,
--     au_id VARCHAR(11) NOT NULL,
--     royalties DECIMAL(10,2) NOT NULL,
--     PRIMARY KEY (title_id, au_id)
-- );

-- INSERT INTO temp_sales
-- SELECT 
--     titles.title_id, 
--     titleauthor.au_id, 
--     titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS royalties
-- FROM 
--     authors 
--     JOIN titleauthor ON authors.au_id = titleauthor.au_id
--     JOIN titles ON titleauthor.title_id = titles.title_id
--     JOIN sales ON titles.title_id = sales.title_id;


-- CREATE TEMPORARY TABLE temp_royalties (
--     title_id VARCHAR(20) NOT NULL,
--     au_id VARCHAR(11) NOT NULL,
--     royalties DECIMAL(10,2) NOT NULL,
--     PRIMARY KEY (title_id, au_id)
-- );

-- INSERT INTO temp_royalties
-- SELECT 
--     title_id,
--     au_id,
--     SUM(royalties) AS royalties
-- FROM 
--     temp_sales
-- GROUP BY 
--     title_id, au_id;


SELECT 
    titleauthor.au_id AS `Author ID`,
    SUM(temp_royalties.royalties) + titles.advance AS `Profits of each author`
FROM 
    temp_royalties 
    JOIN titleauthor ON temp_royalties.title_id = titleauthor.title_id AND temp_royalties.au_id = titleauthor.au_id
    JOIN titles ON temp_royalties.title_id = titles.title_id
GROUP BY 
    titleauthor.au_id
ORDER BY 
    `Profits of each author` DESC
LIMIT 3;
