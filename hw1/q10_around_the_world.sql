WITH dubbed AS (
    SELECT row_number() OVER (ORDER BY artist_alias.id) as rowid,
            artist_alias.name as artist_name
    FROM artist_alias
        INNER JOIN artist ON artist.id = artist_alias.artist
    WHERE artist.name = 'The Beatles'
    ORDER BY artist_alias.id ASC
),
contact(x, id) AS (
    VALUES("", 0)
    UNION ALL
    SELECT x ||
        (
            CASE
                WHEN id = 0 then ''
                ELSE ', '
            END
        ) || cast(dubbed.artist_name as varchar), id+1
    FROM contact INNER JOIN dubbed ON dubbed.rowid = contact.id+1
)
select x
FROM contact
ORDER by id DESC
LIMIT 1;
