SELECT count(distinct a2.artist) 
FROM artist_credit a1
    INNER JOIN artist_credit_name a2 ON a1.id = a2.artist_credit
WHERE a1.name LIKE '%Ariana Grande%'
