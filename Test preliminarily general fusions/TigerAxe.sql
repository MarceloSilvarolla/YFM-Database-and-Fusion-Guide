-- Test Tiger Axe fusions
--[UsableBeast] + [Warrior] = Tiger Axe (1300/1100 Jupiter/Neptune)
--                              < Flame Cerebrus (2100/1800),
--                                Nekogal #2 (1900/2000)
DROP TABLE IF EXISTS PredictedFusionsForTigerAxe;
DROP TABLE IF EXISTS FusionsForTigerAxe;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTigerAxe;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTigerAxePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTigerAxe;

-- Create table with predicted fusions resulting in Tiger Axe

CREATE TEMPORARY TABLE PredictedFusionsForTigerAxe AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsUsableBeast = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1300 AND C2.Attack < 1300;

INSERT INTO PredictedFusionsForTigerAxe
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTigerAxe;

-- Create table with actual fusions for Tiger Axe

CREATE TEMPORARY TABLE FusionsForTigerAxe AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Tiger Axe';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTigerAxe AS
SELECT * FROM PredictedFusionsForTigerAxe
EXCEPT 
SELECT * FROM FusionsForTigerAxe;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTigerAxePlus AS
SELECT IncorrectPredictedFusionsForTigerAxe.Material1Name,
IncorrectPredictedFusionsForTigerAxe.Material1Type,
IncorrectPredictedFusionsForTigerAxe.Material1SecTypes,
IncorrectPredictedFusionsForTigerAxe.Material1Attack,
IncorrectPredictedFusionsForTigerAxe.Material2Name,
IncorrectPredictedFusionsForTigerAxe.Material2Type,
IncorrectPredictedFusionsForTigerAxe.Material2SecTypes,
IncorrectPredictedFusionsForTigerAxe.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTigerAxe
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTigerAxe.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTigerAxe.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTigerAxe AS
SELECT * FROM FusionsForTigerAxe
EXCEPT 
SELECT * FROM PredictedFusionsForTigerAxe;