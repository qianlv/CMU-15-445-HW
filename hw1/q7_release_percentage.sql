WITH month_statistics As (
    SELECT RI.date_year, RI.date_month, count(1) as cnt
    FROM release R
        INNER JOIN release_info RI ON R.id = RI.release
    WHERE (
        (RI.date_year = 2019 and RI.date_month >= 7)
        OR
        (RI.date_year = 2020 and RI.date_month <= 7)
    )
    GROUP BY RI.date_year, RI.date_month
), total_month_statistics AS (
    SELECT sum(cnt) as total
    FROm month_statistics
)

SELECT cast(date_year as varchar) || "." || 
        (
            CASE
                WHEN date_month < 10 then '0'
                ELSE ''
            END
        ) || cast(date_month as varchar) as d,
       round(
            cnt * 100.0 / (
                SELECT SUM(total) FROM total_month_statistics
            ),
            2
       ) 
FROM month_statistics
ORDER BY d;
       
