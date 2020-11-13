ALTER TABLE Cards ADD IsAngelWinged INT;
UPDATE Cards
SET IsAngelWinged = 0;

ALTER TABLE Cards ADD IsBugrothian INT;
UPDATE Cards
SET IsBugrothian = 0;

ALTER TABLE Cards ADD IsDragon INT;
UPDATE Cards
SET IsDragon = 0;

ALTER TABLE Cards ADD IsEgg INT;
UPDATE Cards
SET IsEgg = 0;

ALTER TABLE Cards ADD IsElf INT;
UPDATE Cards
SET IsElf = 0;

ALTER TABLE Cards ADD IsFeatherFromBear INT;
UPDATE Cards
SET IsFeatherFromBear = 0;

ALTER TABLE Cards ADD IsFeatherFromHarpie INT;
UPDATE Cards
SET IsFeatherFromHarpie = 0;

ALTER TABLE Cards ADD IsFeatherFromMachine INT;
UPDATE Cards
SET IsFeatherFromMachine = 0;

ALTER TABLE Cards ADD IsFemale INT;
UPDATE Cards
SET IsFemale = 0;

ALTER TABLE Cards ADD IsJar INT;
UPDATE Cards
SET IsJar = 0;

ALTER TABLE Cards ADD IsKoumorian INT;
UPDATE Cards
SET IsKoumorian = 0;

ALTER TABLE Cards ADD IsMercuryMagicUser INT;
UPDATE Cards
SET IsMercuryMagicUser = 0;

ALTER TABLE Cards ADD IsMercurySpellcaster INT;
UPDATE Cards
SET IsMercurySpellcaster = 0;

ALTER TABLE Cards ADD IsMirror INT;
UPDATE Cards
SET IsMirror = 0;

ALTER TABLE Cards ADD IsMusKingian INT;
UPDATE Cards
SET IsMusKingian = 0;

ALTER TABLE Cards ADD IsMystElfian INT;
UPDATE Cards
SET IsMystElfian = 0;

ALTER TABLE Cards ADD IsPyro INT;
UPDATE Cards
SET IsPyro = 0;

ALTER TABLE Cards ADD IsRainbow INT;
UPDATE Cards
SET IsRainbow = 0;

ALTER TABLE Cards ADD IsSheepian INT;
UPDATE Cards
SET IsSheepian = 0;

ALTER TABLE Cards ADD IsThronian INT;
UPDATE Cards
SET IsThronian = 0;

ALTER TABLE Cards ADD IsTurtle INT;
UPDATE Cards
SET IsTurtle = 0;

ALTER TABLE Cards ADD IsUsableBeast INT;
UPDATE Cards
SET IsUsableBeast = 0;

 
 
DROP TABLE IF EXISTS temp.FusionsAlmostPlus;

CREATE TEMPORARY TABLE temp.FusionsAlmostPlus AS
SELECT C1.CardId AS Material1ID, C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.Attribute AS Material1Attribute, C1.GuardianStar1 AS Material1GuardianStar1, C1.GuardianStar2 AS Material1GuardianStar2, C1.Attack AS Material1Attack,
  C2.CardId AS Material2ID, C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.Attribute AS Material2Attribute, C2.GuardianStar1 AS Material2GuardianStar1, C2.GuardianStar2 AS Material2GuardianStar2, C2.Attack AS Material2Attack,
  Result.CardID AS ResultID, Result.CardName AS ResultName, Result.CardType AS ResultType, Result.Attribute AS ResultAttribute, Result.GuardianStar1 AS ResultGuardianStar1, Result.GuardianStar2 AS ResultGuardianStar2, Result.Attack AS ResultAttack
FROM Fusions, Cards AS C1, Cards AS C2, Cards AS Result
WHERE Material1 = C1.CardID AND Material2 = C2.CardID AND Result = Result.CardID;

UPDATE Cards
SET IsAngelWinged = 1
WHERE CardName IN (
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Type = 'Beast' AND ResultName = 'Garvas' AND (Material1Type <> 'Beast' OR Material1Name = 'Fusionist')
);

UPDATE Cards
SET IsBugrothian = 1
WHERE CardName IN (
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Ground Attacker Bugroth' AND ResultName = 'Amphibious Bugroth'
);

UPDATE Cards
SET IsDragon = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Sanga of the Thunder' AND ResultName = 'Twin-headed Thunder Dragon'
); 

UPDATE Cards
SET IsEgg = 1
WHERE CardName IN ('Monster Egg', 'Wing Egg Elf', 'Gorgon Egg', 'Winged Egg of New Life');

UPDATE Cards
SET IsElf = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Warrior of Tradition' AND ResultName = 'Dark Elf'
); 

UPDATE Cards
SET IsFeatherFromBear = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Bear Trap' AND ResultName = "Harpie's Feather Duster"
);

UPDATE Cards
SET IsFeatherFromHarpie = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Harpie Lady' AND ResultName = "Harpie's Feather Duster"
);

UPDATE Cards
SET IsFeatherFromMachine = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Machine Conversion Factory' AND ResultName = "Harpie's Feather Duster"
);

UPDATE Cards
SET IsFemale = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Stone Ogre Grotto' AND ResultName = 'Mystical Sand'
); 

UPDATE Cards
SET IsJar = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Right Leg of the Forbidden One' AND ResultName = 'Ushi Oni'
);

UPDATE Cards
SET IsKoumorian = 1
WHERE CardName IN(
	SELECT DISTINCT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Winged Dragon #1' AND ResultName = 'Koumori Dragon'
);

UPDATE Cards
SET IsMercuryMagicUser = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Wing Egg Elf' AND ResultName = 'Dark Elf'
) OR CardName = 'Dark Elf'; 

UPDATE Cards
SET IsMercurySpellcaster = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Dragon Piper' AND ResultName = 'Ushi Oni'
); 

UPDATE Cards
SET IsMirror = 1
WHERE CardName IN ('Fiend Refrection #1', 'Fiend Refrection #2',
                   'Job-change Mirror', 'Wicked Mirror') OR
      (CardName LIKE 'Fiend%' AND CardName LIKE '%Mirror'); 

UPDATE Cards
SET IsMusKingian = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Hibikime' AND ResultName = 'Musician King'
); 

UPDATE Cards
SET IsMystElfian = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Dancing Elf' AND ResultName = 'Mystical Elf'
); 

UPDATE Cards
SET IsPyro = 1
WHERE CardName IN(
	SELECT DISTINCT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Punished Eagle' AND ResultName = 'Crimson Sunbird'
); 

UPDATE Cards
SET IsRainbow = 1
WHERE CardName IN('Hoshiningen', 'Rainbow Marine Mermaid', 'Rainbow Flower'); 

UPDATE Cards
SET IsSheepian = 1
WHERE CardName IN(
	SELECT DISTINCT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Mystical Sheep #2' AND ResultName = 'Mystical Sheep #1'
);

UPDATE Cards
SET IsThronian = 1
WHERE CardName IN(
	SELECT DISTINCT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Protector of the Throne' AND ResultName = 'Invader of the Throne'
);

UPDATE Cards
SET IsTurtle = 1
WHERE CardType NOT IN ('Equip', 'Magic', 'Ritual', 'Trap') AND 
	 (CardName LIKE '%turtle%' OR 
      CardName LIKE '%Turtle%' OR
      CardName LIKE '%tortoise%' OR
      CardName LIKE '%Tortoise%'); 

UPDATE Cards
SET IsUsableBeast = 1
WHERE CardName IN(
	SELECT Material1Name AS CardName
	FROM temp.FusionsAlmostPlus
	WHERE Material2Name = 'Vermillion Sparrow' AND ResultName = 'Flame Cerebrus'
);  
 
ALTER TABLE Cards ADD CardSecTypes TEXT;
UPDATE Cards
SET CardSecTypes = '';

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'AngelWinged '
WHERE IsAngelWinged = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Bugrothian '
WHERE IsBugrothian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Dragon '
WHERE IsDragon = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Egg '
WHERE IsEgg = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Elf '
WHERE IsElf = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'FeatherFromBear '
WHERE IsFeatherFromBear = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'FeatherFromHarpie '
WHERE IsFeatherFromHarpie = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'FeatherFromMachine '
WHERE IsFeatherFromMachine = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Female '
WHERE IsFemale = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Jar '
WHERE IsJar = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Koumorian '
WHERE IsKoumorian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'MercuryMagicUser '
WHERE IsMercuryMagicUser = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'MercurySpellcaster '
WHERE IsMercurySpellcaster = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Mirror '
WHERE IsMirror = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'MusKingian '
WHERE IsMusKingian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'MystElfian '
WHERE IsMystElfian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Pyro '
WHERE IsPyro = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Rainbow '
WHERE IsRainbow = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Sheepian '
WHERE IsSheepian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Thronian '
WHERE IsThronian = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'Turtle '
WHERE IsTurtle = 1;

UPDATE Cards
SET CardSecTypes = CardSecTypes || 'UsableBeast '
WHERE IsUsableBeast = 1;

 
 
ALTER TABLE Cards ADD TotalSecTypes INT;
UPDATE Cards
SET TotalSecTypes = IsAngelWinged + IsBugrothian + IsDragon + IsEgg + IsElf + IsFeatherFromBear + IsFeatherFromHarpie + IsFeatherFromMachine + IsFemale + IsJar + IsKoumorian + IsMercuryMagicUser + IsMercurySpellcaster + IsMirror + IsMusKingian + IsMystElfian + IsPyro + IsRainbow + IsSheepian + IsThronian + IsTurtle + IsUsableBeast;