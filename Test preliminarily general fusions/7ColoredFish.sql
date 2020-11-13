-- Test 7 Colored Fish fusions
--[Fish] + Hoshiningen      = 7 Colored Fish (1800/800)
--                              < Dark Witch (1800/1700)
--[Fish] + Rainbow Marine Mermaid
--                          = 7 Colored Fish (1800/800)
--                              < Queen of Autumn Leaves (1800/1500),
--                                Dark Witch (1800/1700)
--[Fish] + Rainbow Flower   = 7 Colored Fish (1800/800)
--                              < Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsFor7ColoredFish;
DROP TABLE IF EXISTS FusionsFor7ColoredFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsFor7ColoredFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsFor7ColoredFishPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsFor7ColoredFish;

-- Create table with predicted fusions resulting in 7 Colored Fish

CREATE TEMPORARY TABLE PredictedFusionsFor7ColoredFish AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fish' AND C2.IsRainbow = 1 AND
  C1.Attack < 1800 AND C2.Attack < 1800);

INSERT INTO PredictedFusionsFor7ColoredFish
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsFor7ColoredFish;

-- Create table with actual fusions for 7 Colored Fish

CREATE TEMPORARY TABLE FusionsFor7ColoredFish AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = '7 Colored Fish';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsFor7ColoredFish AS
SELECT * FROM PredictedFusionsFor7ColoredFish
EXCEPT 
SELECT * FROM FusionsFor7ColoredFish;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsFor7ColoredFishPlus AS
SELECT IncorrectPredictedFusionsFor7ColoredFish.Material1Name,
IncorrectPredictedFusionsFor7ColoredFish.Material1Type,
IncorrectPredictedFusionsFor7ColoredFish.Material1SecTypes,
IncorrectPredictedFusionsFor7ColoredFish.Material1Attack,
IncorrectPredictedFusionsFor7ColoredFish.Material2Name,
IncorrectPredictedFusionsFor7ColoredFish.Material2Type,
IncorrectPredictedFusionsFor7ColoredFish.Material2SecTypes,
IncorrectPredictedFusionsFor7ColoredFish.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsFor7ColoredFish
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsFor7ColoredFish.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsFor7ColoredFish.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsFor7ColoredFish AS
SELECT * FROM FusionsFor7ColoredFish
EXCEPT 
SELECT * FROM PredictedFusionsFor7ColoredFish;