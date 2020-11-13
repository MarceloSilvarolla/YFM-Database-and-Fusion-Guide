-- Test Giant Turtle Who Feeds on Flames fusions
--[Pyro] + [Turtle]         = Giant Turtle Who Feeds on Flames (1400/1800)

DROP TABLE IF EXISTS PredictedFusionsForGiantTurtleWhoFeedsonFlames;
DROP TABLE IF EXISTS FusionsForGiantTurtleWhoFeedsonFlames;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlamesPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForGiantTurtleWhoFeedsonFlames;

-- Create table with predicted fusions resulting in Giant Turtle Who Feeds on Flames

CREATE TEMPORARY TABLE PredictedFusionsForGiantTurtleWhoFeedsonFlames AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.IsTurtle = 1 AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForGiantTurtleWhoFeedsonFlames
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForGiantTurtleWhoFeedsonFlames;

-- Create table with actual fusions for Giant Turtle Who Feeds on Flames

CREATE TEMPORARY TABLE FusionsForGiantTurtleWhoFeedsonFlames AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Giant Turtle Who Feeds on Flames';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames AS
SELECT * FROM PredictedFusionsForGiantTurtleWhoFeedsonFlames
EXCEPT 
SELECT * FROM FusionsForGiantTurtleWhoFeedsonFlames;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlamesPlus AS
SELECT IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material1Name,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material1Type,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material1SecTypes,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material1Attack,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material2Name,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material2Type,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material2SecTypes,
IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForGiantTurtleWhoFeedsonFlames.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForGiantTurtleWhoFeedsonFlames AS
SELECT * FROM FusionsForGiantTurtleWhoFeedsonFlames
EXCEPT 
SELECT * FROM PredictedFusionsForGiantTurtleWhoFeedsonFlames;