DROP TABLE IF EXISTS DesiredCards;

CREATE TEMPORARY TABLE DesiredCards AS
SELECT CardName
FROM Cards
WHERE Attack >= 2500 or (
	  Attack >= 2000 and (GuardianStar1 = 'Mercury' or GuardianStar2 = 'Mercury')
	  );