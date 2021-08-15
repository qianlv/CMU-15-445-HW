WITH worklen As (
    select WL.type, WL.len, work_type.name
    from
        (SELECT type, max(length(work.name)) as len
         FROM work
         GROUP BY type) as WL,
        work_type
    WHERE WL.type = work_type.id
)

SELECT work.name, worklen.name
FROM work, worklen 
WHERE work.type = worklen.type and length(work.name) = len 
ORDER BY work.type, work.name;
