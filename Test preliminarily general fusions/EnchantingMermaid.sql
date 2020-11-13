-- Test Enchanting Mermaid fusions
--[Female] + [Fish]         = Ice Water (1150/900)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600)   
--                          = Enchanting Mermaid (1200/900)
--                          = Amazon of the Seas (1300/1400)
--                              < Wow Warrior (1250/900),
--                                Tatsunootoshigo (1350/1600),
--                                Dark Witch (1800/1700),
--                                Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForEnchantingMermaid;
DROP TABLE IF EXISTS FusionsForEnchantingMermaid;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForEnchantingMermaid;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForEnchantingMermaidPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForEnchantingMermaid;

-- Create table with predicted fusions resulting in Enchanting Mermaid

CREATE TEMPORARY TABLE PredictedFusionsForEnchantingMermaid AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFemale = 1 AND C2.CardType = 'Fish' AND
  C1.Attack < 1200 AND C2.Attack < 1200) AND
  (C1.Attack >= 1150 OR C2.Attack >= 1150);

INSERT INTO PredictedFusionsForEnchantingMermaid
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForEnchantingMermaid;

-- Create table with actual fusions for Enchanting Mermaid

CREATE TEMPORARY TABLE FusionsForEnchantingMermaid AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Enchanting Mermaid';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForEnchantingMermaid AS
SELECT * FROM PredictedFusionsForEnchantingMermaid
EXCEPT 
SELECT * FROM FusionsForEnchantingMermaid;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForEnchantingMermaidPlus AS
SELECT IncorrectPredictedFusionsForEnchantingMermaid.Material1Name,
IncorrectPredictedFusionsForEnchantingMermaid.Material1Type,
IncorrectPredictedFusionsForEnchantingMermaid.Material1SecTypes,
IncorrectPredictedFusionsForEnchantingMermaid.Material1Attack,
IncorrectPredictedFusionsForEnchantingMermaid.Material2Name,
IncorrectPredictedFusionsForEnchantingMermaid.Material2Type,
IncorrectPredictedFusionsForEnchantingMermaid.Material2SecTypes,
IncorrectPredictedFusionsForEnchantingMermaid.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForEnchantingMermaid
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForEnchantingMermaid.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForEnchantingMermaid.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForEnchantingMermaid AS
SELECT * FROM FusionsForEnchantingMermaid
EXCEPT 
SELECT * FROM PredictedFusionsForEnchantingMermaid;