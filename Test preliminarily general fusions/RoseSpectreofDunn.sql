-- Test Rose Spectre of Dunn fusions
--[Fiend] + Arlownay        = Rose Spectre of Dunn (2000/1800)
--                              < Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForRoseSpectreofDunn;
DROP TABLE IF EXISTS FusionsForRoseSpectreofDunn;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRoseSpectreofDunn;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRoseSpectreofDunnPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForRoseSpectreofDunn;

-- Create table with predicted fusions resulting in Rose Spectre of Dunn

CREATE TEMPORARY TABLE PredictedFusionsForRoseSpectreofDunn AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' AND C2.CardName = 'Arlownay' AND
  C1.Attack < 2000 AND C2.Attack < 2000);

INSERT INTO PredictedFusionsForRoseSpectreofDunn
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForRoseSpectreofDunn;

-- Create table with actual fusions for Rose Spectre of Dunn

CREATE TEMPORARY TABLE FusionsForRoseSpectreofDunn AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Rose Spectre of Dunn';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRoseSpectreofDunn AS
SELECT * FROM PredictedFusionsForRoseSpectreofDunn
EXCEPT 
SELECT * FROM FusionsForRoseSpectreofDunn;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRoseSpectreofDunnPlus AS
SELECT IncorrectPredictedFusionsForRoseSpectreofDunn.Material1Name,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material1Type,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material1SecTypes,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material1Attack,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material2Name,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material2Type,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material2SecTypes,
IncorrectPredictedFusionsForRoseSpectreofDunn.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForRoseSpectreofDunn
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForRoseSpectreofDunn.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForRoseSpectreofDunn.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForRoseSpectreofDunn AS
SELECT * FROM FusionsForRoseSpectreofDunn
EXCEPT 
SELECT * FROM PredictedFusionsForRoseSpectreofDunn;