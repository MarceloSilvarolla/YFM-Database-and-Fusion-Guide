-- Test Cyber Soldier fusions
--[Machine] + [Warrior]     = Cyber Soldier (1500/1700)
--                              < Charubin the Fire Knight (1100/800),
--                                Flame Swordsman (1800/1600)

DROP TABLE IF EXISTS PredictedFusionsForCyberSoldier;
DROP TABLE IF EXISTS FusionsForCyberSoldier;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCyberSoldier;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCyberSoldierPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCyberSoldier;

-- Create table with predicted fusions resulting in Cyber Soldier

CREATE TEMPORARY TABLE PredictedFusionsForCyberSoldier AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Machine' AND C2.CardType = 'Warrior' AND
  C1.Attack < 1500 AND C2.Attack < 1500);

INSERT INTO PredictedFusionsForCyberSoldier
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCyberSoldier;

-- Create table with actual fusions for Cyber Soldier

CREATE TEMPORARY TABLE FusionsForCyberSoldier AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Cyber Soldier';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCyberSoldier AS
SELECT * FROM PredictedFusionsForCyberSoldier
EXCEPT 
SELECT * FROM FusionsForCyberSoldier;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCyberSoldierPlus AS
SELECT IncorrectPredictedFusionsForCyberSoldier.Material1Name,
IncorrectPredictedFusionsForCyberSoldier.Material1Type,
IncorrectPredictedFusionsForCyberSoldier.Material1SecTypes,
IncorrectPredictedFusionsForCyberSoldier.Material1Attack,
IncorrectPredictedFusionsForCyberSoldier.Material2Name,
IncorrectPredictedFusionsForCyberSoldier.Material2Type,
IncorrectPredictedFusionsForCyberSoldier.Material2SecTypes,
IncorrectPredictedFusionsForCyberSoldier.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCyberSoldier
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCyberSoldier.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCyberSoldier.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCyberSoldier AS
SELECT * FROM FusionsForCyberSoldier
EXCEPT 
SELECT * FROM PredictedFusionsForCyberSoldier;