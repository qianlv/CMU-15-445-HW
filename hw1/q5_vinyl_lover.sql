WITH vinyl as (
    SELECT distinct release
    FROM medium,
         (SELECT id
          FROM medium_format
          WHERE name like '%Vinyl%' and name not like '%VinylDisc%'
         ) as medium_format
    WHERE medium.format = medium_format.id
),
coldplay as (
    SELECT artist_credit.id 
    FROM artist_credit, artist_credit_name
    WHERE artist_credit.id = artist_credit_name.artist_credit AND
          artist_credit_name.name = 'Coldplay'
)
--  SELECT COUNT(1) from vinyl;

SELECT distinct R.name
FROM
    (SELECT release.id, name
    FROM vinyl, release, coldplay
    WHERE vinyl.release = release.id AND
          coldplay.id = release.artist_credit) as R,
    release_info
WHERE R.id = release_info.release
ORDER BY release_info.date_year,
         release_info.date_month,
         release_info.date_day
