DROP TABLE IF EXISTS CardClassification;
-- Create table CardClassification and populate it
CREATE TABLE CardClassification AS
SELECT CardID, CardName, Attack, Defense, CardType,
  NULL AS IsAngelWinged, NULL AS IsBugrothian, NULL AS IsMercuryMagicUser, NULL AS IsDragon, NULL AS IsElf,
  NULL AS IsFeatherian, 
  NULL AS IsFemale, NULL AS IsJar, NULL AS IsKoumorian, NULL AS IsMystElfian, NULL AS IsPyro, 
  NULL AS IsTurtle, NULL AS IsUsableBeast,
  NULL AS Total
FROM Cards;

-- Fill in columns of table CardClassification
UPDATE CardClassification
SET IsAngelWinged = 0;

UPDATE CardClassification
SET IsAngelWinged = 1
WHERE CardID IN (
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Type = 'Beast' AND ResultName = 'Garvas' AND (Material1Type <> 'Beast' OR Material1Name = 'Fusionist')
); 
 
UPDATE CardClassification
SET IsBugrothian = 0;

UPDATE CardClassification
SET IsBugrothian = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Ground Attacker Bugroth' AND ResultName = 'Amphibious Bugroth'
); 
 
UPDATE CardClassification
SET IsMercuryMagicUser = 0;

UPDATE CardClassification
SET IsMercuryMagicUser = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Wing Egg Elf' AND ResultName = 'Dark Elf'
); 


UPDATE CardClassification
SET IsDragon = 0;

UPDATE CardClassification
SET IsDragon = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Sanga of the Thunder' AND ResultName = 'Twin-headed Thunder Dragon'
); 


UPDATE CardClassification
SET IsElf = 0;

UPDATE CardClassification
SET IsElf = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Warrior of Tradition' AND ResultName = 'Dark Elf'
); 
 
UPDATE CardClassification
SET IsFeatherian = 0;

UPDATE CardClassification
SET IsFeatherian = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Bear Trap' AND ResultName = 'Harpie''s Feather Duster'
); 
 
UPDATE CardClassification
SET IsFemale = 0;

UPDATE CardClassification
SET IsFemale = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Stone Ogre Grotto' AND ResultName = 'Mystical Sand'
); 
 
UPDATE CardClassification
SET IsJar = 0;

UPDATE CardClassification
SET IsJar = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Right Leg of the Forbidden One' AND ResultName = 'Ushi Oni'
); 
 
UPDATE CardClassification
SET IsKoumorian = 0;

UPDATE CardClassification
SET IsKoumorian = 1
WHERE CardID IN(
	SELECT DISTINCT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Type = 'Dragon' AND Material2Name NOT IN ('Wicked Dragon with the Ersatz Head', 'Lesser Dragon') AND ResultName = 'Koumori Dragon'
); 
 
UPDATE CardClassification
SET IsMystElfian = 0;

UPDATE CardClassification
SET IsMystElfian = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Wing Egg Elf' AND ResultName = 'Mystical Elf'
); 
 
UPDATE CardClassification
SET IsPyro = 0;

UPDATE CardClassification
SET IsPyro = 1
WHERE CardID IN(
	SELECT DISTINCT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Punished Eagle' AND ResultName = 'Crimson Sunbird'
); 
 
UPDATE CardClassification
SET IsTurtle = 0;

UPDATE CardClassification
SET IsTurtle = 1
WHERE CardID IN(
	SELECT DISTINCT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Type = 'Winged Beast' AND ResultName = 'Turtle Bird'
) OR CardName = 'Turtle Bird'; 
 
UPDATE CardClassification
SET IsUsableBeast = 0;

UPDATE CardClassification
SET IsUsableBeast = 1
WHERE CardID IN(
	SELECT Material1ID AS CardID
	FROM FusionsPlus
	WHERE Material2Name = 'Vermillion Sparrow' AND ResultName = 'Flame Cerebrus'
); 
 
UPDATE CardClassification
SET Total = IsAngelWinged+ IsBugrothian + IsMercuryMagicUser + IsDragon + IsElf
 + IsFeatherian + IsFemale + IsJar + IsKoumorian + IsMystElfian + IsPyro
 + IsTurtle + IsUsableBeast;