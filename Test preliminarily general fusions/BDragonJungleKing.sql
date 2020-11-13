-- Test B. Dragon Jungle King fusions
-- [Dragon] + [Plant]        = B. Dragon Jungle King (2100/1800)
DROP TABLE IF EXISTS PredictedFusionsForBDragonJungleKing;
DROP TABLE IF EXISTS FusionsForBDragonJungleKing;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBDragonJungleKing;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBDragonJungleKingPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForBDragonJungleKing;

-- Create table with predicted fusions resulting in B. Dragon Jungle King

CREATE TEMPORARY TABLE PredictedFusionsForBDragonJungleKing AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Plant' AND
  C1.Attack < 2100 AND C2.Attack < 2100;

INSERT INTO PredictedFusionsForBDragonJungleKing
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForBDragonJungleKing;

-- Create table with actual fusions for B. Dragon Jungle King

CREATE TEMPORARY TABLE FusionsForBDragonJungleKing AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'B. Dragon Jungle King';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBDragonJungleKing AS
SELECT * FROM PredictedFusionsForBDragonJungleKing
EXCEPT 
SELECT * FROM FusionsForBDragonJungleKing;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBDragonJungleKingPlus AS
SELECT IncorrectPredictedFusionsForBDragonJungleKing.Material1Name,
IncorrectPredictedFusionsForBDragonJungleKing.Material1Type,
IncorrectPredictedFusionsForBDragonJungleKing.Material1SecTypes,
IncorrectPredictedFusionsForBDragonJungleKing.Material1Attack,
IncorrectPredictedFusionsForBDragonJungleKing.Material2Name,
IncorrectPredictedFusionsForBDragonJungleKing.Material2Type,
IncorrectPredictedFusionsForBDragonJungleKing.Material2SecTypes,
IncorrectPredictedFusionsForBDragonJungleKing.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForBDragonJungleKing
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForBDragonJungleKing.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForBDragonJungleKing.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForBDragonJungleKing AS
SELECT * FROM FusionsForBDragonJungleKing
EXCEPT 
SELECT * FROM PredictedFusionsForBDragonJungleKing;








