create temporary table if not exists ChoiceCosts AS
SELECT *
FROM ChoiceTypes;

create temporary table if not exists DecompsPlus AS
SELECT ChoiceType, AnimationType, Position
FROM Decomps
NATURAL JOIN AnimTypes
NATURAL JOIN ChoiceTypes;

create temporary table if not exists FixedAdvsPlus AS
select *
from FixedAdvs
NATURAL JOIN AnimTypes;

create temporary table if not exists VariableAdvsPlus AS
SELECT *
FROM VariableAdvs
NATURAL JOIN AnimTypes;