-- Test Harpie's Feather Duster fusions
--[FeatherFromBear] + Bear Trap = Harpie's Feather Duster
--[FeatherFromMachine] + Machine Conversion Factory = Harpie's Feather Duster
--[FeatherFromHarpie] + {Harpie Lady, Harpie Lady Sisters} = Harpie's Feather Duster
--Invisible Wire + Flying Penguin = Harpie's Feather Duster

DROP TABLE IF EXISTS PredictedFusionsForHarpiesFeatherDuster;
DROP TABLE IF EXISTS FusionsForHarpiesFeatherDuster;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHarpiesFeatherDuster;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHarpiesFeatherDusterPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForHarpiesFeatherDuster;

-- Create table with predicted fusions resulting in Harpie's Feather Duster

CREATE TEMPORARY TABLE PredictedFusionsForHarpiesFeatherDuster AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFeatherFromBear = 1 AND C2.CardName = 'Bear Trap') OR
  (C1.IsFeatherFromMachine = 1 AND C2.CardName = 'Machine Conversion Factory') OR
  (C1.IsFeatherFromHarpie = 1 AND C2.CardName IN ('Harpie Lady', 'Harpie Lady Sisters'));


INSERT INTO PredictedFusionsForHarpiesFeatherDuster
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForHarpiesFeatherDuster;

-- Create table with actual fusions for Harpie's Feather Duster

CREATE TEMPORARY TABLE FusionsForHarpiesFeatherDuster AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = "Harpie's Feather Duster";

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHarpiesFeatherDuster AS
SELECT * FROM PredictedFusionsForHarpiesFeatherDuster
EXCEPT 
SELECT * FROM FusionsForHarpiesFeatherDuster;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHarpiesFeatherDusterPlus AS
SELECT IncorrectPredictedFusionsForHarpiesFeatherDuster.Material1Name,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material1Type,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material1SecTypes,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material1Attack,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material2Name,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material2Type,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material2SecTypes,
IncorrectPredictedFusionsForHarpiesFeatherDuster.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForHarpiesFeatherDuster
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForHarpiesFeatherDuster.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForHarpiesFeatherDuster.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForHarpiesFeatherDuster AS
SELECT * FROM FusionsForHarpiesFeatherDuster
EXCEPT 
SELECT * FROM PredictedFusionsForHarpiesFeatherDuster;