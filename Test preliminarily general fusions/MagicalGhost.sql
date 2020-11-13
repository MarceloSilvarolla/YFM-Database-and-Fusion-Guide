-- Test Magical Ghost fusions
--[Spellcaster] + [Zombie] = Magical Ghost (1300/1400)
--                             < Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForMagicalGhost;
DROP TABLE IF EXISTS FusionsForMagicalGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMagicalGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMagicalGhostPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMagicalGhost;

-- Create table with predicted fusions resulting in Magical Ghost

CREATE TEMPORARY TABLE PredictedFusionsForMagicalGhost AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Spellcaster' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1300 AND C2.Attack < 1300);

INSERT INTO PredictedFusionsForMagicalGhost
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMagicalGhost;

-- Create table with actual fusions for Magical Ghost

CREATE TEMPORARY TABLE FusionsForMagicalGhost AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Magical Ghost';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMagicalGhost AS
SELECT * FROM PredictedFusionsForMagicalGhost
EXCEPT 
SELECT * FROM FusionsForMagicalGhost;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMagicalGhostPlus AS
SELECT IncorrectPredictedFusionsForMagicalGhost.Material1Name,
IncorrectPredictedFusionsForMagicalGhost.Material1Type,
IncorrectPredictedFusionsForMagicalGhost.Material1SecTypes,
IncorrectPredictedFusionsForMagicalGhost.Material1Attack,
IncorrectPredictedFusionsForMagicalGhost.Material2Name,
IncorrectPredictedFusionsForMagicalGhost.Material2Type,
IncorrectPredictedFusionsForMagicalGhost.Material2SecTypes,
IncorrectPredictedFusionsForMagicalGhost.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMagicalGhost
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMagicalGhost.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMagicalGhost.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMagicalGhost AS
SELECT * FROM FusionsForMagicalGhost
EXCEPT 
SELECT * FROM PredictedFusionsForMagicalGhost;