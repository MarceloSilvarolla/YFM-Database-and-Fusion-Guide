-- Test Flame Swordsman fusions
--[Pyro] + [Warrior]        = Charubin the Fire Knight (1100/800)
--                              < Zombie Warrior (1200/900),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Flame Swordsman (1800/1600)
--                              < Zombie Warrior (1200/900),
--                                Armored Zombie (1500/0),
--                                Dragon Zombie (1600/0),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Vermillion Sparrow (1900/1500)

DROP TABLE IF EXISTS PredictedFusionsForFlameSwordsman;
DROP TABLE IF EXISTS FusionsForFlameSwordsman;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameSwordsman;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameSwordsmanPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFlameSwordsman;

-- Create table with predicted fusions resulting in Flame Swordsman

CREATE TEMPORARY TABLE PredictedFusionsForFlameSwordsman AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1800 AND C2.Attack < 1800) AND
  (C1.Attack >= 1100 OR C2.Attack >= 1100);

INSERT INTO PredictedFusionsForFlameSwordsman
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFlameSwordsman;

-- Create table with actual fusions for Flame Swordsman

CREATE TEMPORARY TABLE FusionsForFlameSwordsman AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Flame Swordsman';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameSwordsman AS
SELECT * FROM PredictedFusionsForFlameSwordsman
EXCEPT 
SELECT * FROM FusionsForFlameSwordsman;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameSwordsmanPlus AS
SELECT IncorrectPredictedFusionsForFlameSwordsman.Material1Name,
IncorrectPredictedFusionsForFlameSwordsman.Material1Type,
IncorrectPredictedFusionsForFlameSwordsman.Material1SecTypes,
IncorrectPredictedFusionsForFlameSwordsman.Material1Attack,
IncorrectPredictedFusionsForFlameSwordsman.Material2Name,
IncorrectPredictedFusionsForFlameSwordsman.Material2Type,
IncorrectPredictedFusionsForFlameSwordsman.Material2SecTypes,
IncorrectPredictedFusionsForFlameSwordsman.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFlameSwordsman
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFlameSwordsman.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFlameSwordsman.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFlameSwordsman AS
SELECT * FROM FusionsForFlameSwordsman
EXCEPT 
SELECT * FROM PredictedFusionsForFlameSwordsman;