WITH decades As (
    SELECT R.id, SUBSTR(cast(date_year as TEXT), 1, 3) || '0s' decade
    FROM release R
        INNER JOIN release_info RI ON R.id = RI.release
    WHERE R.status = 1 AND RI.date_year >= 1900
)

SELECT decade, count(1) as cnt
FROM decades
GROUP BY decade
ORDER BY cnt desc, decade desc;
