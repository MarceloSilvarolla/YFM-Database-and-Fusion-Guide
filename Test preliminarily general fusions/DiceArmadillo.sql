-- Test Dice Armadillo fusions
--[UsableBeast] + [Machine] = Giga-tech Wolf (1200/1400 Jupiter/Uranus)
--                              < Flame Cerebrus (2100/1800)
--                          = Dice Armadillo (1650/1800 Jupiter/Pluto)
--                              < Flame Cerebrus (2100/1800)
DROP TABLE IF EXISTS PredictedFusionsForDiceArmadillo;
DROP TABLE IF EXISTS FusionsForDiceArmadillo;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDiceArmadillo;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDiceArmadilloPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDiceArmadillo;

-- Create table with predicted fusions resulting in Dice Armadillo

CREATE TEMPORARY TABLE PredictedFusionsForDiceArmadillo AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsUsableBeast = 1 AND C2.CardType = 'Machine' AND
  C1.Attack < 1650 AND C2.Attack < 1650 AND
  (C1.Attack >= 1200 OR C2.Attack >= 1200);

INSERT INTO PredictedFusionsForDiceArmadillo
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDiceArmadillo;

-- Create table with actual fusions for Dice Armadillo

CREATE TEMPORARY TABLE FusionsForDiceArmadillo AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dice Armadillo';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDiceArmadillo AS
SELECT * FROM PredictedFusionsForDiceArmadillo
EXCEPT 
SELECT * FROM FusionsForDiceArmadillo;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDiceArmadilloPlus AS
SELECT IncorrectPredictedFusionsForDiceArmadillo.Material1Name,
IncorrectPredictedFusionsForDiceArmadillo.Material1Type,
IncorrectPredictedFusionsForDiceArmadillo.Material1SecTypes,
IncorrectPredictedFusionsForDiceArmadillo.Material1Attack,
IncorrectPredictedFusionsForDiceArmadillo.Material2Name,
IncorrectPredictedFusionsForDiceArmadillo.Material2Type,
IncorrectPredictedFusionsForDiceArmadillo.Material2SecTypes,
IncorrectPredictedFusionsForDiceArmadillo.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDiceArmadillo
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDiceArmadillo.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDiceArmadillo.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDiceArmadillo AS
SELECT * FROM FusionsForDiceArmadillo
EXCEPT 
SELECT * FROM PredictedFusionsForDiceArmadillo;








