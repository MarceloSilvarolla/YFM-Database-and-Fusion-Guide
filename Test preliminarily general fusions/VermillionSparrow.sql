-- Test Vermillion Sparrow fusions
--[Pyro] + [Warrior]        = Charubin the Fire Knight (1100/800)
--                              < Zombie Warrior (1200/900),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Flame Swordsman (1800/1600)
--                              < Zombie Warrior (1200/900),
--                                Armored Zombie (1500/0),
--                                Dragon Zombie (1600/0),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Vermillion Sparrow (1900/1500)

DROP TABLE IF EXISTS PredictedFusionsForVermillionSparrow;
DROP TABLE IF EXISTS FusionsForVermillionSparrow;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForVermillionSparrow;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForVermillionSparrowPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForVermillionSparrow;

-- Create table with predicted fusions resulting in Vermillion Sparrow

CREATE TEMPORARY TABLE PredictedFusionsForVermillionSparrow AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1900 AND C2.Attack < 1900) AND
  (C1.Attack >= 1800 OR C2.Attack >= 1800);

INSERT INTO PredictedFusionsForVermillionSparrow
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForVermillionSparrow;

-- Create table with actual fusions for Vermillion Sparrow

CREATE TEMPORARY TABLE FusionsForVermillionSparrow AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Vermillion Sparrow';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForVermillionSparrow AS
SELECT * FROM PredictedFusionsForVermillionSparrow
EXCEPT 
SELECT * FROM FusionsForVermillionSparrow;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForVermillionSparrowPlus AS
SELECT IncorrectPredictedFusionsForVermillionSparrow.Material1Name,
IncorrectPredictedFusionsForVermillionSparrow.Material1Type,
IncorrectPredictedFusionsForVermillionSparrow.Material1SecTypes,
IncorrectPredictedFusionsForVermillionSparrow.Material1Attack,
IncorrectPredictedFusionsForVermillionSparrow.Material2Name,
IncorrectPredictedFusionsForVermillionSparrow.Material2Type,
IncorrectPredictedFusionsForVermillionSparrow.Material2SecTypes,
IncorrectPredictedFusionsForVermillionSparrow.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForVermillionSparrow
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForVermillionSparrow.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForVermillionSparrow.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForVermillionSparrow AS
SELECT * FROM FusionsForVermillionSparrow
EXCEPT 
SELECT * FROM PredictedFusionsForVermillionSparrow;