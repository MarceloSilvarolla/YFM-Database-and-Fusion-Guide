-- Test Stone Ghost fusions
--[Rock] + [Zombie] = Stone Ghost (1200/1000)

DROP TABLE IF EXISTS PredictedFusionsForStoneGhost;
DROP TABLE IF EXISTS FusionsForStoneGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForStoneGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForStoneGhostPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForStoneGhost;

-- Create table with predicted fusions resulting in Stone Ghost

CREATE TEMPORARY TABLE PredictedFusionsForStoneGhost AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Rock' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1200 AND C2.Attack < 1200);

INSERT INTO PredictedFusionsForStoneGhost
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForStoneGhost;

-- Create table with actual fusions for Stone Ghost

CREATE TEMPORARY TABLE FusionsForStoneGhost AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Stone Ghost';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForStoneGhost AS
SELECT * FROM PredictedFusionsForStoneGhost
EXCEPT 
SELECT * FROM FusionsForStoneGhost;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForStoneGhostPlus AS
SELECT IncorrectPredictedFusionsForStoneGhost.Material1Name,
IncorrectPredictedFusionsForStoneGhost.Material1Type,
IncorrectPredictedFusionsForStoneGhost.Material1SecTypes,
IncorrectPredictedFusionsForStoneGhost.Material1Attack,
IncorrectPredictedFusionsForStoneGhost.Material2Name,
IncorrectPredictedFusionsForStoneGhost.Material2Type,
IncorrectPredictedFusionsForStoneGhost.Material2SecTypes,
IncorrectPredictedFusionsForStoneGhost.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForStoneGhost
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForStoneGhost.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForStoneGhost.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForStoneGhost AS
SELECT * FROM FusionsForStoneGhost
EXCEPT 
SELECT * FROM PredictedFusionsForStoneGhost;