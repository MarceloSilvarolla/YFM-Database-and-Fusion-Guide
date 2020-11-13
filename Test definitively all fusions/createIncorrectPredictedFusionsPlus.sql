DROP TABLE IF EXISTS IncorrectPredictedFusions;
CREATE TEMPORARY TABLE IncorrectPredictedFusions AS
SELECT *
FROM PredictedFusions
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   ResultName
FROM FusionsPlus;

DROP TABLE IF EXISTS IncorrectPredictedFusionsPlus;
CREATE TEMPORARY TABLE IncorrectPredictedFusionsPlus AS
SELECT IPF.Material1Name, IPF.Material1Type, IPF.Material1SecTypes, IPF.Material1Attack,
       IPF.Material2Name, IPF.Material2Type, IPF.Material2SecTypes, IPF.Material2Attack,
	   IPF.PredictedResult, FP.ResultName
FROM IncorrectPredictedFusions AS IPF
LEFT JOIN FusionsPlus AS FP
ON FP.Material1Name = IPF.Material1Name and FP.Material2Name = IPF.Material2Name;