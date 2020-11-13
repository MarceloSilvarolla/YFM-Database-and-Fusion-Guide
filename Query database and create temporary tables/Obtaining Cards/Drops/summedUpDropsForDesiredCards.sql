SELECT DuelistName, "Rank", SUM(Prob)
FROM DropRates
WHERE CardName IN DesiredCards
GROUP BY DuelistName, "Rank"
ORDER BY SUM(Prob) DESC;
