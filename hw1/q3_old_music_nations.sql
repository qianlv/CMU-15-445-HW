SELECT name, cnt from
    (SELECT area, count(1) as cnt
     FROM artist
     WHERE begin_date_year < 1850
     GROUP BY area
     ORDER BY cnt desc ) as C, area
WHERE C.area = area.id ORDER by cnt desc LIMIT 10;
