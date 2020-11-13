-- Test 30,000-Year White Turtle fusions
--[Spellcaster] + [Turtle] = 30,000-Year White Turtle (1250/2100)

DROP TABLE IF EXISTS PredictedFusionsFor30000YearWhiteTurtle;
DROP TABLE IF EXISTS FusionsFor30000YearWhiteTurtle;
DROP TABLE IF EXISTS IncorrectPredictedFusionsFor30000YearWhiteTurtle;
DROP TABLE IF EXISTS IncorrectPredictedFusionsFor30000YearWhiteTurtlePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsFor30000YearWhiteTurtle;

-- Create table with predicted fusions resulting in 30,000-Year White Turtle

CREATE TEMPORARY TABLE PredictedFusionsFor30000YearWhiteTurtle AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Spellcaster' AND C2.IsTurtle = 1 AND
  C1.Attack < 1250 AND C2.Attack < 1250);

INSERT INTO PredictedFusionsFor30000YearWhiteTurtle
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsFor30000YearWhiteTurtle;

-- Create table with actual fusions for 30,000-Year White Turtle

CREATE TEMPORARY TABLE FusionsFor30000YearWhiteTurtle AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = '30,000-Year White Turtle';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsFor30000YearWhiteTurtle AS
SELECT * FROM PredictedFusionsFor30000YearWhiteTurtle
EXCEPT 
SELECT * FROM FusionsFor30000YearWhiteTurtle;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsFor30000YearWhiteTurtlePlus AS
SELECT IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material1Name,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material1Type,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material1SecTypes,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material1Attack,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material2Name,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material2Type,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material2SecTypes,
IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsFor30000YearWhiteTurtle
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsFor30000YearWhiteTurtle.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsFor30000YearWhiteTurtle AS
SELECT * FROM FusionsFor30000YearWhiteTurtle
EXCEPT 
SELECT * FROM PredictedFusionsFor30000YearWhiteTurtle;