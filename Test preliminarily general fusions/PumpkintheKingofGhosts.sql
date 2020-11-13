-- Test Pumpking the King of Ghosts fusions
--[Plant] + [Zombie]        = Wood Remains (1000/900)
--                          = Pumpking the King of Ghosts (1800/2000)

DROP TABLE IF EXISTS PredictedFusionsForPumpkingtheKingofGhosts;
DROP TABLE IF EXISTS FusionsForPumpkingtheKingofGhosts;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForPumpkingtheKingofGhosts;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForPumpkingtheKingofGhostsPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForPumpkingtheKingofGhosts;

-- Create table with predicted fusions resulting in Pumpking the King of Ghosts

CREATE TEMPORARY TABLE PredictedFusionsForPumpkingtheKingofGhosts AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Plant' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1800 AND C2.Attack < 1800) AND
  (C1.Attack >= 1000 OR C2.Attack >= 1000);

INSERT INTO PredictedFusionsForPumpkingtheKingofGhosts
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForPumpkingtheKingofGhosts;

-- Create table with actual fusions for Pumpking the King of Ghosts

CREATE TEMPORARY TABLE FusionsForPumpkingtheKingofGhosts AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Pumpking the King of Ghosts';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForPumpkingtheKingofGhosts AS
SELECT * FROM PredictedFusionsForPumpkingtheKingofGhosts
EXCEPT 
SELECT * FROM FusionsForPumpkingtheKingofGhosts;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForPumpkingtheKingofGhostsPlus AS
SELECT IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material1Name,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material1Type,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material1SecTypes,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material1Attack,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material2Name,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material2Type,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material2SecTypes,
IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForPumpkingtheKingofGhosts
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForPumpkingtheKingofGhosts.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForPumpkingtheKingofGhosts AS
SELECT * FROM FusionsForPumpkingtheKingofGhosts
EXCEPT 
SELECT * FROM PredictedFusionsForPumpkingtheKingofGhosts;