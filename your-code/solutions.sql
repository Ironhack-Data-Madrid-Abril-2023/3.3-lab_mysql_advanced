-- Challenge 1 - Most Profiting Authors

SELECT 	ID_AUTOR,
		NOMBRE,
        APELLIDO,
        SUM(ROYALTIES) as TOTAL_ROYALTIES

			FROM
(SELECT A.au_id as 'ID_AUTOR',
		A.au_fname as 'NOMBRE',
        A.au_lname as 'APELLIDO',
		TA.title_id as 'ID_TITULO',
        coalesce(TA.royaltyper,0) as 'ROYAL_AUTHOR',
        T.title as 'TITULO',
        coalesce(T.royalty,0) as 'ROYAL_TITULO',
        coalesce(T.price,0) as 'PRECIO',
        coalesce(T.advance,0) as 'AVANCE',
        coalesce(S.qty,0) as 'CANTIDAD',
        coalesce(S.qty * T.price * T.royalty / 100 * TA.royaltyper / 100,0) as 'ROYALTIES'
		FROM authors as A

INNER JOIN 	titleauthor as TA
			ON TA.au_id = A.au_id

LEFT JOIN	titles as T
			ON T.title_id = TA.title_id
            
LEFT JOIN 	sales as S
			ON S.title_id=T.title_id) ROYAL_AUTOR
            
 group by `ID_AUTOR`
 
 order by TOTAL_ROYALTIES desc LIMIT 3;
 
 -- Challenge 2 - Alternative Solutions

Create temporary table publications.Royals
(SELECT A.au_id as 'ID_AUTOR',
		A.au_fname as 'NOMBRE',
        A.au_lname as 'APELLIDO',
		TA.title_id as 'ID_TITULO',
        coalesce(TA.royaltyper,0) as 'ROYAL_AUTHOR',
        T.title as 'TITULO',
        coalesce(T.royalty,0) as 'ROYAL_TITULO',
        coalesce(T.price,0) as 'PRECIO',
        coalesce(T.advance,0) as 'AVANCE',
        coalesce(S.qty,0) as 'CANTIDAD',
        coalesce(S.qty * T.price * T.royalty / 100 * TA.royaltyper / 100,0) as 'ROYALTIES'
		FROM authors as A

INNER JOIN 	titleauthor as TA
			ON TA.au_id = A.au_id

LEFT JOIN	titles as T
			ON T.title_id = TA.title_id
            
LEFT JOIN 	sales as S
			ON S.title_id=T.title_id);
            
SELECT 	ID_AUTOR,
        SUM(ROYALTIES) as TOTAL_ROYALTIES
        FROM ROYALS

GROUP BY `ID_AUTOR`
order by TOTAL_ROYALTIES desc LIMIT 3;

-- Challenge 3
create table publications.most_profiting_authors
(SELECT 	ID_AUTOR as au_id,
        SUM(ROYALTIES) as profits

			FROM
(SELECT A.au_id as 'ID_AUTOR',
		A.au_fname as 'NOMBRE',
        A.au_lname as 'APELLIDO',
		TA.title_id as 'ID_TITULO',
        coalesce(TA.royaltyper,0) as 'ROYAL_AUTHOR',
        T.title as 'TITULO',
        coalesce(T.royalty,0) as 'ROYAL_TITULO',
        coalesce(T.price,0) as 'PRECIO',
        coalesce(T.advance,0) as 'AVANCE',
        coalesce(S.qty,0) as 'CANTIDAD',
        coalesce(S.qty * T.price * T.royalty / 100 * TA.royaltyper / 100,0) as 'ROYALTIES'
		FROM authors as A

INNER JOIN 	titleauthor as TA
			ON TA.au_id = A.au_id

LEFT JOIN	titles as T
			ON T.title_id = TA.title_id
            
LEFT JOIN 	sales as S
			ON S.title_id=T.title_id) ROYAL_AUTOR
            
 group by `ID_AUTOR`);