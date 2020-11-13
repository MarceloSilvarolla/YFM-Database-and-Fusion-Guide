-- Test Spirit of the Books fusions
--[Winged Beast] + Boo Koo   = Spirit of the Books (1400/1200)

DROP TABLE IF EXISTS PredictedFusionsForSpiritoftheBooks;
DROP TABLE IF EXISTS FusionsForSpiritoftheBooks;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSpiritoftheBooks;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSpiritoftheBooksPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSpiritoftheBooks;

-- Create table with predicted fusions resulting in Spirit of the Books

CREATE TEMPORARY TABLE PredictedFusionsForSpiritoftheBooks AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Winged Beast' AND C2.CardName = 'Boo Koo' AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForSpiritoftheBooks
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSpiritoftheBooks;

-- Create table with actual fusions for Spirit of the Books

CREATE TEMPORARY TABLE FusionsForSpiritoftheBooks AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Spirit of the Books';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSpiritoftheBooks AS
SELECT * FROM PredictedFusionsForSpiritoftheBooks
EXCEPT 
SELECT * FROM FusionsForSpiritoftheBooks;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSpiritoftheBooksPlus AS
SELECT IncorrectPredictedFusionsForSpiritoftheBooks.Material1Name,
IncorrectPredictedFusionsForSpiritoftheBooks.Material1Type,
IncorrectPredictedFusionsForSpiritoftheBooks.Material1SecTypes,
IncorrectPredictedFusionsForSpiritoftheBooks.Material1Attack,
IncorrectPredictedFusionsForSpiritoftheBooks.Material2Name,
IncorrectPredictedFusionsForSpiritoftheBooks.Material2Type,
IncorrectPredictedFusionsForSpiritoftheBooks.Material2SecTypes,
IncorrectPredictedFusionsForSpiritoftheBooks.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSpiritoftheBooks
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSpiritoftheBooks.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSpiritoftheBooks.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSpiritoftheBooks AS
SELECT * FROM FusionsForSpiritoftheBooks
EXCEPT 
SELECT * FROM PredictedFusionsForSpiritoftheBooks;