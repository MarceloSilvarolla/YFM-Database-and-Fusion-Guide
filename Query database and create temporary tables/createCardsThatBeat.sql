DROP TABLE IF EXISTS CardsThatBeat;
CREATE TEMPORARY TABLE CardsThatBeat AS
SELECT C1.CardName, C1.GuardianStar1, C1.GuardianStar2, C1.CardType, C1.CardSecTypes, C1.Attack, C1.Defense
FROM Cards AS C1
JOIN Cards AS C2
WHERE C2.CardName = 'Twin-headed Thunder Dragon' AND (
        MAX(C1.Attack, C1.Defense) >= C2.Attack OR ( 
	      ( (C1.GuardianStar1, C2.GuardianStar1) IN GSBeats OR (C1.GuardianStar2, C2.GuardianStar1) IN GSBeats) AND
          MAX(C1.Attack, C1.Defense) >= C2.Attack - 500
	    )
	  );