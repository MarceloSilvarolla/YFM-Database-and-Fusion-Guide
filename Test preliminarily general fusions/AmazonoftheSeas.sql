-- Test Amazon of the Seas fusions
--[Female] + [Fish]         = Ice Water (1150/900)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600)   
--                          = Enchanting Mermaid (1200/900)
--                          = Amazon of the Seas (1300/1400)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600),
--                                Dark Witch (1800/1700),
--                                Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForAmazonoftheSeas;
DROP TABLE IF EXISTS FusionsForAmazonoftheSeas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForAmazonoftheSeas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForAmazonoftheSeasPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForAmazonoftheSeas;

-- Create table with predicted fusions resulting in Amazon of the Seas

CREATE TEMPORARY TABLE PredictedFusionsForAmazonoftheSeas AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFemale = 1 AND C2.CardType = 'Fish' AND
  C1.Attack < 1300 AND C2.Attack < 1300) AND
  (C1.Attack >= 1200 OR C2.Attack >= 1200);

INSERT INTO PredictedFusionsForAmazonoftheSeas
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForAmazonoftheSeas;

-- Create table with actual fusions for Amazon of the Seas

CREATE TEMPORARY TABLE FusionsForAmazonoftheSeas AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Amazon of the Seas';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForAmazonoftheSeas AS
SELECT * FROM PredictedFusionsForAmazonoftheSeas
EXCEPT 
SELECT * FROM FusionsForAmazonoftheSeas;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForAmazonoftheSeasPlus AS
SELECT IncorrectPredictedFusionsForAmazonoftheSeas.Material1Name,
IncorrectPredictedFusionsForAmazonoftheSeas.Material1Type,
IncorrectPredictedFusionsForAmazonoftheSeas.Material1SecTypes,
IncorrectPredictedFusionsForAmazonoftheSeas.Material1Attack,
IncorrectPredictedFusionsForAmazonoftheSeas.Material2Name,
IncorrectPredictedFusionsForAmazonoftheSeas.Material2Type,
IncorrectPredictedFusionsForAmazonoftheSeas.Material2SecTypes,
IncorrectPredictedFusionsForAmazonoftheSeas.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForAmazonoftheSeas
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForAmazonoftheSeas.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForAmazonoftheSeas.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForAmazonoftheSeas AS
SELECT * FROM FusionsForAmazonoftheSeas
EXCEPT 
SELECT * FROM PredictedFusionsForAmazonoftheSeas;