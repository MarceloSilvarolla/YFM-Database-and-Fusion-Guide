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