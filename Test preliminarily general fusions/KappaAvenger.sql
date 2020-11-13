-- Test Kappa Avenger fusions
--[Fiend] + Psychic Kappa (400/1000) 
--                          = Kappa Avenger (1200/900)

DROP TABLE IF EXISTS PredictedFusionsForKappaAvenger;
DROP TABLE IF EXISTS FusionsForKappaAvenger;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKappaAvenger;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKappaAvengerPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForKappaAvenger;

-- Create table with predicted fusions resulting in Kappa Avenger

CREATE TEMPORARY TABLE PredictedFusionsForKappaAvenger AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' AND C2.CardName = 'Psychic Kappa' AND
  C1.Attack < 1200 AND C2.Attack < 1200);

INSERT INTO PredictedFusionsForKappaAvenger
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForKappaAvenger;

-- Create table with actual fusions for Kappa Avenger

CREATE TEMPORARY TABLE FusionsForKappaAvenger AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Kappa Avenger';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKappaAvenger AS
SELECT * FROM PredictedFusionsForKappaAvenger
EXCEPT 
SELECT * FROM FusionsForKappaAvenger;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKappaAvengerPlus AS
SELECT IncorrectPredictedFusionsForKappaAvenger.Material1Name,
IncorrectPredictedFusionsForKappaAvenger.Material1Type,
IncorrectPredictedFusionsForKappaAvenger.Material1SecTypes,
IncorrectPredictedFusionsForKappaAvenger.Material1Attack,
IncorrectPredictedFusionsForKappaAvenger.Material2Name,
IncorrectPredictedFusionsForKappaAvenger.Material2Type,
IncorrectPredictedFusionsForKappaAvenger.Material2SecTypes,
IncorrectPredictedFusionsForKappaAvenger.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForKappaAvenger
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForKappaAvenger.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForKappaAvenger.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForKappaAvenger AS
SELECT * FROM FusionsForKappaAvenger
EXCEPT 
SELECT * FROM PredictedFusionsForKappaAvenger;