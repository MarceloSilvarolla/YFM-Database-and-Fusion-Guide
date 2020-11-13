-- Test Ice Water fusions
--[Female] + [Fish]         = Ice Water (1150/900)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600)   
--                          = Enchanting Mermaid (1200/900)
--                          = Amazon of the Seas (1300/1400)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600),
--                                Dark Witch (1800/1700),
--                                Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForIceWater;
DROP TABLE IF EXISTS FusionsForIceWater;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForIceWater;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForIceWaterPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForIceWater;

-- Create table with predicted fusions resulting in Ice Water

CREATE TEMPORARY TABLE PredictedFusionsForIceWater AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFemale = 1 AND C2.CardType = 'Fish' AND
  C1.Attack < 1150 AND C2.Attack < 1150);

INSERT INTO PredictedFusionsForIceWater
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForIceWater;

-- Create table with actual fusions for Ice Water

CREATE TEMPORARY TABLE FusionsForIceWater AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Ice Water';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForIceWater AS
SELECT * FROM PredictedFusionsForIceWater
EXCEPT 
SELECT * FROM FusionsForIceWater;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForIceWaterPlus AS
SELECT IncorrectPredictedFusionsForIceWater.Material1Name,
IncorrectPredictedFusionsForIceWater.Material1Type,
IncorrectPredictedFusionsForIceWater.Material1SecTypes,
IncorrectPredictedFusionsForIceWater.Material1Attack,
IncorrectPredictedFusionsForIceWater.Material2Name,
IncorrectPredictedFusionsForIceWater.Material2Type,
IncorrectPredictedFusionsForIceWater.Material2SecTypes,
IncorrectPredictedFusionsForIceWater.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForIceWater
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForIceWater.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForIceWater.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForIceWater AS
SELECT * FROM FusionsForIceWater
EXCEPT 
SELECT * FROM PredictedFusionsForIceWater;