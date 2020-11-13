-- Test Nekogal #2 fusions
--[UsableBeast] + [Female]  = Nekogal #2 (1900/2000 Jupiter/Uranus)
DROP TABLE IF EXISTS PredictedFusionsForNekogal2;
DROP TABLE IF EXISTS FusionsForNekogal2;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForNekogal2;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForNekogal2Plus;
DROP TABLE IF EXISTS MissingPredictedFusionsForNekogal2;

-- Create table with predicted fusions resulting in Nekogal #2

CREATE TEMPORARY TABLE PredictedFusionsForNekogal2 AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  (C1.IsUsableBeast = 1 AND C2.IsFemale = 1 AND
  C1.Attack < 1900 AND C2.Attack < 1900);

INSERT INTO PredictedFusionsForNekogal2
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForNekogal2;

-- Create table with actual fusions for Nekogal #2

CREATE TEMPORARY TABLE FusionsForNekogal2 AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Nekogal #2';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForNekogal2 AS
SELECT * FROM PredictedFusionsForNekogal2
EXCEPT 
SELECT * FROM FusionsForNekogal2;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForNekogal2Plus AS
SELECT IncorrectPredictedFusionsForNekogal2.Material1Name,
IncorrectPredictedFusionsForNekogal2.Material1Type,
IncorrectPredictedFusionsForNekogal2.Material1SecTypes,
IncorrectPredictedFusionsForNekogal2.Material1Attack,
IncorrectPredictedFusionsForNekogal2.Material2Name,
IncorrectPredictedFusionsForNekogal2.Material2Type,
IncorrectPredictedFusionsForNekogal2.Material2SecTypes,
IncorrectPredictedFusionsForNekogal2.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForNekogal2
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForNekogal2.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForNekogal2.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForNekogal2 AS
SELECT * FROM FusionsForNekogal2
EXCEPT 
SELECT * FROM PredictedFusionsForNekogal2;








