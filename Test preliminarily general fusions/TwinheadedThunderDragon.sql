-- Test Twin-headed Thunder Dragon fusions
-- [Dragon] + [Thunder]      = Thunder Dragon (1600/1500)
--                           = Twin-headed Thunder Dragon (2800/2100)
--                               < Skelgon (1700/1900)

DROP TABLE IF EXISTS PredictedFusionsForTwinHeadedThunderDragon;
DROP TABLE IF EXISTS FusionsForTwinHeadedThunderDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTwinHeadedThunderDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTwinHeadedThunderDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTwinHeadedThunderDragon;

-- Create table with predicted fusions resulting in Twin-headed Thunder Dragon

CREATE TEMPORARY TABLE PredictedFusionsForTwinHeadedThunderDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Thunder' AND
  C1.Attack < 2800 AND C2.Attack < 2800 AND
  (C1.Attack >= 1600 OR C2.Attack >= 1600);

INSERT INTO PredictedFusionsForTwinHeadedThunderDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTwinHeadedThunderDragon;

-- Create table with actual fusions for Twin-headed Thunder Dragon

CREATE TEMPORARY TABLE FusionsForTwinHeadedThunderDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Twin-headed Thunder Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTwinHeadedThunderDragon AS
SELECT * FROM PredictedFusionsForTwinHeadedThunderDragon
EXCEPT 
SELECT * FROM FusionsForTwinHeadedThunderDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTwinHeadedThunderDragonPlus AS
SELECT IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material1Name,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material1Type,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material1SecTypes,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material1Attack,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material2Name,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material2Type,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material2SecTypes,
IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTwinHeadedThunderDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTwinHeadedThunderDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTwinHeadedThunderDragon AS
SELECT * FROM FusionsForTwinHeadedThunderDragon
EXCEPT 
SELECT * FROM PredictedFusionsForTwinHeadedThunderDragon;








