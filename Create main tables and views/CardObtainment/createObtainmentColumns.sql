DROP TABLE IF EXISTS Droppabilities;
CREATE TEMPORARY TABLE Droppabilities AS
SELECT CardName, MAX(Prob) AS Droppability
FROM DropRates
GROUP BY CardName
ORDER BY MAX(Prob) DESC;

UPDATE Cards
SET Droppability = 0;

UPDATE Cards
SET Droppability = (SELECT Droppability
					FROM   Droppabilities
					WHERE CardName = Cards.CardName);

---------------------------------------------------------------
DROP TABLE IF EXISTS Fusabilities;
CREATE TEMPORARY TABLE Fusabilities AS
SELECT ResultName AS CardName, COUNT(*)AS Fusability
FROM FusionsPlus
GROUP BY ResultName;

UPDATE Cards
SET Fusability = 0;

UPDATE Cards
SET Fusability = (SELECT Fusability
				  FROM   Fusabilities
				  WHERE  CardName = Cards.CardName);
---------------------------------------------------------------
DROP TABLE IF EXISTS Startabilities;
CREATE TEMPORARY TABLE Startabilities AS
SELECT StarterPoolID, StarterPoolName, CardName, SampleSize * Prob AS Startability
FROM StarterRates;

UPDATE Cards
SET Startability = 0;

UPDATE Cards
SET Startability = (SELECT Startability
				  FROM   Startabilities
				  WHERE  CardName = Cards.CardName);