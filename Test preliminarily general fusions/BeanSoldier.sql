-- Test Bean Soldier fusions
--[Plant] + [Warrior]       = Bean Soldier (1400/1300)

DROP TABLE IF EXISTS PredictedFusionsForBeanSoldier;
DROP TABLE IF EXISTS FusionsForBeanSoldier;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBeanSoldier;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBeanSoldierPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForBeanSoldier;

-- Create table with predicted fusions resulting in Bean Soldier

CREATE TEMPORARY TABLE PredictedFusionsForBeanSoldier AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Plant' AND C2.CardType = 'Warrior' AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForBeanSoldier
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForBeanSoldier;

-- Create table with actual fusions for Bean Soldier

CREATE TEMPORARY TABLE FusionsForBeanSoldier AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Bean Soldier';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBeanSoldier AS
SELECT * FROM PredictedFusionsForBeanSoldier
EXCEPT 
SELECT * FROM FusionsForBeanSoldier;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBeanSoldierPlus AS
SELECT IncorrectPredictedFusionsForBeanSoldier.Material1Name,
IncorrectPredictedFusionsForBeanSoldier.Material1Type,
IncorrectPredictedFusionsForBeanSoldier.Material1SecTypes,
IncorrectPredictedFusionsForBeanSoldier.Material1Attack,
IncorrectPredictedFusionsForBeanSoldier.Material2Name,
IncorrectPredictedFusionsForBeanSoldier.Material2Type,
IncorrectPredictedFusionsForBeanSoldier.Material2SecTypes,
IncorrectPredictedFusionsForBeanSoldier.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForBeanSoldier
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForBeanSoldier.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForBeanSoldier.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForBeanSoldier AS
SELECT * FROM FusionsForBeanSoldier
EXCEPT 
SELECT * FROM PredictedFusionsForBeanSoldier;