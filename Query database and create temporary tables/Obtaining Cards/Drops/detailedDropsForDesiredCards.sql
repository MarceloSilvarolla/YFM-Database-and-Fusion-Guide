SELECT DuelistName, "Rank", Q.CardName, C.CardType, C.Attack, Prob, TotalProb
FROM (SELECT DR1.DuelistName, DR1."Rank", DR1.CardName, DR1.Prob, TotalProb
FROM DropRates AS DR1
JOIN (SELECT DuelistName, "Rank", SUM(Prob) AS TotalProb
FROM DropRates
WHERE CardName IN DesiredCards
GROUP BY DuelistName, "Rank"
ORDER BY TotalProb DESC) AS DR2
ON DR1.DuelistName = DR2.DuelistName AND DR1."Rank" = DR2."Rank"
WHERE CardName IN DesiredCards 
ORDER BY TotalProb DESC, DR1.DuelistName DESC, DR1."Rank" DESC, DR1.Prob DESC, DR1.CardName ASC) AS Q
JOIN Cards AS C
ON   Q.CardName = C.CardName
