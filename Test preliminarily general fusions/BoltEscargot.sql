-- Test Bolt Escargot fusions
--[Aqua] + [Thunder]        = Bolt Escargot (1400/1500 Pluto/Jupiter)

DROP TABLE IF EXISTS PredictedFusionsForBoltEscargot;
DROP TABLE IF EXISTS FusionsForBoltEscargot;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBoltEscargot;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBoltEscargotPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForBoltEscargot;

-- Create table with predicted fusions resulting in Bolt Escargot

CREATE TEMPORARY TABLE PredictedFusionsForBoltEscargot AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Aqua' AND C2.CardType = 'Thunder' AND
  C1.Attack < 1400 AND C2.Attack < 1400;

INSERT INTO PredictedFusionsForBoltEscargot
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForBoltEscargot;

-- Create table with actual fusions for Bolt Escargot

CREATE TEMPORARY TABLE FusionsForBoltEscargot AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Bolt Escargot';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBoltEscargot AS
SELECT * FROM PredictedFusionsForBoltEscargot
EXCEPT 
SELECT * FROM FusionsForBoltEscargot;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBoltEscargotPlus AS
SELECT IncorrectPredictedFusionsForBoltEscargot.Material1Name,
IncorrectPredictedFusionsForBoltEscargot.Material1Type,
IncorrectPredictedFusionsForBoltEscargot.Material1SecTypes,
IncorrectPredictedFusionsForBoltEscargot.Material1Attack,
IncorrectPredictedFusionsForBoltEscargot.Material2Name,
IncorrectPredictedFusionsForBoltEscargot.Material2Type,
IncorrectPredictedFusionsForBoltEscargot.Material2SecTypes,
IncorrectPredictedFusionsForBoltEscargot.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForBoltEscargot
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForBoltEscargot.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForBoltEscargot.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForBoltEscargot AS
SELECT * FROM FusionsForBoltEscargot
EXCEPT 
SELECT * FROM PredictedFusionsForBoltEscargot;