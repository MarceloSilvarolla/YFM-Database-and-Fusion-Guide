DROP TABLE IF EXISTS WeirdFusions;
CREATE TEMPORARY TABLE WeirdFusions AS
SELECT Material1Name, Material2Name, ResultName FROM FusionsPlus
WHERE (Material1Attack >= ResultAttack or Material2Attack >= ResultAttack) and
     (ResultAttack > 0) and Material1Name <= Material2Name