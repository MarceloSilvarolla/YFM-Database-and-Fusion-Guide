-- Test Punished Eagle fusions
--[Winged Beast] + The Judgement Hand
--                           = Punished Eagle (2100/1800)
--                               < Flame Swordsman (1800/1600)

DROP TABLE IF EXISTS PredictedFusionsForPunishedEagle;
DROP TABLE IF EXISTS FusionsForPunishedEagle;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForPunishedEagle;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForPunishedEaglePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForPunishedEagle;

-- Create table with predicted fusions resulting in Punished Eagle

CREATE TEMPORARY TABLE PredictedFusionsForPunishedEagle AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Winged Beast' AND C2.CardName = 'The Judgement Hand' AND
  C1.Attack < 2100 AND C2.Attack < 2100);

INSERT INTO PredictedFusionsForPunishedEagle
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForPunishedEagle;

-- Create table with actual fusions for Punished Eagle

CREATE TEMPORARY TABLE FusionsForPunishedEagle AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Punished Eagle';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForPunishedEagle AS
SELECT * FROM PredictedFusionsForPunishedEagle
EXCEPT 
SELECT * FROM FusionsForPunishedEagle;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForPunishedEaglePlus AS
SELECT IncorrectPredictedFusionsForPunishedEagle.Material1Name,
IncorrectPredictedFusionsForPunishedEagle.Material1Type,
IncorrectPredictedFusionsForPunishedEagle.Material1SecTypes,
IncorrectPredictedFusionsForPunishedEagle.Material1Attack,
IncorrectPredictedFusionsForPunishedEagle.Material2Name,
IncorrectPredictedFusionsForPunishedEagle.Material2Type,
IncorrectPredictedFusionsForPunishedEagle.Material2SecTypes,
IncorrectPredictedFusionsForPunishedEagle.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForPunishedEagle
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForPunishedEagle.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForPunishedEagle.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForPunishedEagle AS
SELECT * FROM FusionsForPunishedEagle
EXCEPT 
SELECT * FROM PredictedFusionsForPunishedEagle;