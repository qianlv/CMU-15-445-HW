SELECT artist.name, count(distinct artist_alias.name) as cnt
from artist_alias,
    (SELECT id, name
      FROM artist
      WHERE artist.begin_date_year > 1950
      AND artist.area = 221
    ) as artist
WHERE artist.id = artist_alias.artist
GROUP BY artist.name
ORDER BY cnt desc
LIMIT 10;
