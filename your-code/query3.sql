CREATE TABLE most_profiting_authors (
    au_id VARCHAR(11) NOT NULL,
    profits DECIMAL(10,2) NOT NULL
);

INSERT INTO most_profiting_authors (au_id, profits)
SELECT 
    royalties.au_id AS `Author ID`,
    SUM(royalties.`Aggregated royalties of each title for each author`) + titles.advance AS `Profits of each author`
FROM (
    SELECT 
        title_id, 
        au_id, 
        SUM(royalty) AS `Aggregated royalties of each title for each author`
    FROM (
        SELECT 
            titles.title_id, 
            titleauthor.au_id, 
            titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS `royalty`
        FROM 
            authors 
            JOIN titleauthor ON authors.au_id = titleauthor.au_id
            JOIN titles ON titleauthor.title_id = titles.title_id
            JOIN sales ON titles.title_id = sales.title_id
    ) AS royalties
    GROUP BY 
        title_id, au_id
) AS royalties
JOIN titleauthor ON royalties.au_id = titleauthor.au_id AND royalties.title_id = titleauthor.title_id
JOIN titles ON royalties.title_id = titles.title_id
GROUP BY 
    royalties.au_id
ORDER BY 
    `Profits of each author` DESC;

SELECT * FROM most_profiting_authors;
