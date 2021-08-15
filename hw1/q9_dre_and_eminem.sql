WITH share_credit As (
    SELECT acn.artist_credit as artist_credit, artist.name as name, artist.id as id, r.id as release
    FROM artist_credit_name acn
        INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
        INNER JOIN release r ON ac.id = r.artist_credit
        INNER JOIN artist ON acn.artist = artist.id
    WHERE 
        r.language = 120 AND
        artist.type = 1 AND
        artist.begin_date_year > 1960
),
share_count AS (
    SELECT sh1.name as parter1, sh2.name as parter2, count(1) as total
    FROM share_credit sh1
        INNER JOIN share_credit sh2 ON sh1.artist_credit = sh2.artist_credit AND sh1.release = sh2.release
    WHERE sh1.name < sh2.name
    GROUP BY sh1.id, sh2.id
)

select * FROM (
    SELECT RANK() OVER (
        ORDER BY total desc, parter1, parter2
    ), parter1, parter2, total
    FROM share_count
)
WHERE parter1 = 'Dr. Dre' AND parter2 = 'Eminem'
