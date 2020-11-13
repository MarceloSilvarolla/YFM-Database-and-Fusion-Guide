DROP TABLE IF EXISTS DesiredCards;

CREATE TEMPORARY TABLE DesiredCards AS
SELECT CardName
FROM Cards
WHERE Attack >= 3000 or (
	  Attack >= 2500 and (GuardianStar1 = 'Mercury' or GuardianStar2 = 'Mercury')
	  );