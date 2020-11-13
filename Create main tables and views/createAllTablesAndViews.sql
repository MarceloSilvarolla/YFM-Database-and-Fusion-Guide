DROP TABLE IF EXISTS main.Cards;
-- Create table Cards and then populate it
CREATE TABLE "Cards" (
	"CardID"	INT,
	"CardName"	TEXT,
	"Description"	TEXT,
	"GuardianStar1"	TEXT,
	"GuardianStar2"	TEXT,
	"Level"	INT,
	"CardType"	INT,
	"Attribute"	TEXT,
	"Attack"	INT,
	"Defense"	INT,
	"Password"	TEXT,
	"StarchipCost"	INT,
	"Droppability" INT,
	"Fusability" INT,
	"Startability" INT,
	"NumSort"	INT,
	"AbcSort"	INT,
	"MaxSort"	INT,
	"AtkSort"	INT,
	"DefSort"	INT,
	"TypSort"	INT,
	"AISort"	INT,
	PRIMARY KEY("CardId")
);

INSERT INTO Cards
SELECT CardID, CardName, Description, GuardianStar1, GuardianStar2,Level, Type AS CardType, Attribute,
  Attack, Defense, Password, StarchipCost, 0 AS Droppability, 0 AS Fusability, 0 AS Startability,
  NumSort, AbcSort, MaxSort, AtkSort, DefSort, TypSort, AISort
FROM FmDatabase.Cards
NATURAL JOIN FmDatabaseWithGS.CardInfo;
DROP TABLE IF EXISTS main.Duelists;
-- Create table Duelists and populate it
CREATE TABLE "Duelists" (
	"DuelistID"	INT,
	"DuelistName"	TEXT,
	"HandSize"	INT,
	"IsMage"	INT,
	PRIMARY KEY("DuelistID")
);

INSERT INTO Duelists
SELECT DuelistID, Name as DuelistName, HandSize, IsMage
FROM FmDatabase.Duelists;DROP TABLE IF EXISTS main.DuelistPoolTypes;
-- Create table DuelistPoolTypes and populate it
CREATE TABLE "DuelistPoolTypes" (
	"DuelistPoolTypeID"	INT,
	"DuelistPoolType"	TEXT,
	PRIMARY KEY("DuelistPoolTypeID")
);

INSERT INTO DuelistPoolTypes
SELECT *
FROM FmDatabase.PoolTypes;DROP TABLE IF EXISTS main.DuelistPoolSamplingRates;
-- Create table DuelistPoolSamplingRates and populate it
CREATE TABLE "DuelistPoolSamplingRates" (
	"DuelistID"	INT,
	"DuelistPoolTypeID"	INT,
	"CardID"	INT,
	"Prob"	INT,
	PRIMARY KEY("DuelistID","DuelistPoolTypeID","CardID"),
	FOREIGN KEY("DuelistID") REFERENCES "Duelists"("DuelistID"),
	FOREIGN KEY("DuelistPoolTypeID") REFERENCES "DuelistPoolTypes"("DuelistPoolTypeID"),
	FOREIGN KEY("CardID") REFERENCES "Cards"("CardID")
);

INSERT INTO DuelistPoolSamplingRates
SELECT *
FROM FmDatabase.DuelistPools;DROP TABLE IF EXISTS main.StarterPools;
-- Create table StarterPools and populate it
CREATE TABLE "StarterPools" (
	"StarterPoolID"	INT,
	"SampleSize"	INT,
	"StarterPoolName" TEXT,
	PRIMARY KEY("StarterPoolID")
);

INSERT INTO StarterPools
SELECT PoolID as StarterPoolID, SampleSize, NULL AS StarterPoolName
FROM StarterGroups;

UPDATE StarterPools
SET StarterPoolName = "ATKplusDEFlt1100"
WHERE StarterPoolID = 1;

UPDATE StarterPools
SET StarterPoolName = "1100leqATKplusDEFlt1600"
WHERE StarterPoolID = 2;

UPDATE StarterPools
SET StarterPoolName = "1600leqATKplusDEFlt2100"
WHERE StarterPoolID = 3;

UPDATE StarterPools
SET StarterPoolName = "2100leqATKplusDEF"
WHERE StarterPoolID = 4;

UPDATE StarterPools
SET StarterPoolName = "PureMagic"
WHERE StarterPoolID = 5;

UPDATE StarterPools
SET StarterPoolName = "Field"
WHERE StarterPoolID = 6;

UPDATE StarterPools
SET StarterPoolName = "Equip"
WHERE StarterPoolID = 7;DROP TABLE IF EXISTS main.StarterPoolSamplingRates;
-- Create table StarterPoolSamplingRates and populate it
CREATE TABLE "StarterPoolSamplingRates" (
	"StarterPoolID"	INT,
	"CardID"	INT,
	"Prob"	INT,
	PRIMARY KEY("StarterPoolID","CardID"),
	FOREIGN KEY("StarterPoolID") REFERENCES StarterPools("StarterPoolID"),
	FOREIGN KEY("CardID") REFERENCES Cards("CardID")
);

INSERT INTO StarterPoolSamplingRates
SELECT PoolID AS StarterPoolID, CardID, Prob
FROM FmDatabase.StarterPools;DROP TABLE IF EXISTS main.Equipping;
-- Create table Equipping and populate it
CREATE TABLE "Equipping" (
	"EquipID"	INT,
	"EquippedID"	INT,
	PRIMARY KEY("EquipID","EquippedID"),
	FOREIGN KEY("EquipID") REFERENCES Cards("CardID"),
	FOREIGN KEY("EquippedID") REFERENCES Cards("CardID")
);

INSERT INTO Equipping
SELECT EquipID AS EquipID, CardID AS EquippedID
FROM FmDatabaseWithGS.EquipInfo;

DROP TABLE IF EXISTS main.Fusions;
-- Create table Fusions and populate it
CREATE TABLE "Fusions" (
	"Material1"	INT,
	"Material2"	INT,
	"Result"	TEXT,
	PRIMARY KEY("Material1","Material2"),
	FOREIGN KEY("Material1") REFERENCES Cards("CardID"),
	FOREIGN KEY("Material2") REFERENCES Cards("CardID"),
	FOREIGN KEY("Result") REFERENCES Cards("CardID")
);

INSERT INTO Fusions
SELECT Material_1 AS Material1, Material_2 AS Material2, Result as Result
FROM FmDatabaseWithGS.Fusions
UNION
SELECT Material_2 AS Material2, Material_1 AS Material1, Result as Result
FROM FmDatabaseWithGS.Fusions;

DROP TABLE IF EXISTS main.Rituals;
-- Create table Rituals and populate it
CREATE TABLE "Rituals" (
	"Tribute1"	INT,
	"Tribute2"	INT,
	"Tribute3"	INT,
	"RitualCard" INT,
	"Result"	INT,
	PRIMARY KEY("Tribute1","Tribute2","Tribute3"),
	FOREIGN KEY("Tribute1") REFERENCES Cards("CardID"),
	FOREIGN KEY("Tribute2") REFERENCES Cards("CardID"),
	FOREIGN KEY("Tribute3") REFERENCES Cards("CardID"),
	FOREIGN KEY("RitualCard") REFERENCES Cards("CardID"),
	FOREIGN KEY("Result") REFERENCES Cards("CardID")
);

INSERT INTO Rituals
SELECT Material_1 AS Tribute1, Material_2 AS Tribute2, Material_3 AS Tribute3, CardId AS RitualCard, Result AS Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_1, Material_3, Material_2, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_2, Material_1, Material_3, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_2, Material_3, Material_1, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_3, Material_1, Material_2, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_3, Material_2, Material_1, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo;





DROP TABLE IF EXISTS GSBeats;

CREATE TABLE GSBeats (
   WinnerGS TEXT,
   LoserGS TEXT
);

INSERT INTO GSBeats
VALUES
   ('Mercury', 'Sun'),
   ('Sun', 'Moon'),
   ('Moon', 'Venus'),
   ('Venus', 'Mercury'),
   ('Mars', 'Jupiter'),
   ('Jupiter', 'Saturn'),
   ('Saturn', 'Uranus'),
   ('Uranus', 'Pluto'),
   ('Pluto', 'Neptune'),
   ('Neptune', 'Mars'); 
 
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
 
DROP VIEW IF EXISTS DropRates;
CREATE VIEW DropRates AS
SELECT DuelistName, DuelistPoolType as "Rank", CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
NATURAL JOIN Duelists
WHERE DuelistPoolType <> 'Deck' AND Prob > 0; 
 
DROP VIEW IF EXISTS DuelistDecks;
CREATE VIEW DuelistDecks AS
SELECT DuelistName, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN Duelists
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
WHERE Prob > 0 AND DuelistPoolType = 'Deck'; 
 
DROP VIEW IF EXISTS EquippingPlus;

CREATE VIEW EquippingPlus AS
SELECT C1.CardName AS EquipName, C2.CardName AS EquippedName, 
 	   C2.GuardianStar1 AS EquippedGuardianStar1, C2.GuardianStar2 AS EquippedGuardianStar2,
 	   C2.CardType AS EquippedType, C2.Attack AS EquippedAttack, C2.Defense AS EquippedDefense
FROM Equipping AS E
JOIN Cards AS C1
ON   EquipID = C1.CardID
JOIN Cards AS C2
ON   EquippedID = C2.CardID;
 
 
DROP VIEW IF EXISTS FusionsPlus;
CREATE VIEW FusionsPlus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
       Result.CardName AS ResultName, Result.CardType AS ResultType, Result.CardSecTypes AS ResultSecTypes, Result.Attack AS ResultAttack
FROM Fusions, Cards AS C1, Cards AS C2, Cards AS Result
WHERE Material1 = C1.CardID AND Material2 = C2.CardID AND Result = Result.CardID; 
 
DROP VIEW IF EXISTS StarterRates;
CREATE VIEW StarterRates AS
SELECT StarterPools.StarterPoolID, StarterPools.StarterPoolName, StarterPools.SampleSize, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM StarterPoolSamplingRates
NATURAL JOIN StarterPools
JOIN Cards
ON   Cards.CardID = StarterPoolSamplingRates.CardID
WHERE Prob > 0; 
 
 
 
DROP TABLE IF EXISTS Droppabilities;
CREATE TEMPORARY TABLE Droppabilities AS
SELECT CardName, MAX(Prob) AS Droppability
FROM DropRates
GROUP BY CardName
ORDER BY MAX(Prob) DESC;

UPDATE Cards
SET Droppability = 0;

UPDATE Cards
SET Droppability = (SELECT Droppability
					FROM   Droppabilities
					WHERE CardName = Cards.CardName);

---------------------------------------------------------------
DROP TABLE IF EXISTS Fusabilities;
CREATE TEMPORARY TABLE Fusabilities AS
SELECT ResultName AS CardName, COUNT(*)AS Fusability
FROM FusionsPlus
GROUP BY ResultName;

UPDATE Cards
SET Fusability = 0;

UPDATE Cards
SET Fusability = (SELECT Fusability
				  FROM   Fusabilities
				  WHERE  CardName = Cards.CardName);
---------------------------------------------------------------
DROP TABLE IF EXISTS Startabilities;
CREATE TEMPORARY TABLE Startabilities AS
SELECT StarterPoolID, StarterPoolName, CardName, SampleSize * Prob AS Startability
FROM StarterRates;

UPDATE Cards
SET Startability = 0;

UPDATE Cards
SET Startability = (SELECT Startability
				  FROM   Startabilities
				  WHERE  CardName = Cards.CardName); 
 
ALTER TABLE Cards ADD IsEquippedByAxeofDespair INT;
UPDATE Cards
SET IsEquippedByAxeofDespair = 0;
UPDATE Cards
SET IsEquippedByAxeofDespair = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Axe of Despair");

ALTER TABLE Cards ADD IsEquippedByBeastFangs INT;
UPDATE Cards
SET IsEquippedByBeastFangs = 0;
UPDATE Cards
SET IsEquippedByBeastFangs = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Beast Fangs");

ALTER TABLE Cards ADD IsEquippedByBlackPendant INT;
UPDATE Cards
SET IsEquippedByBlackPendant = 0;
UPDATE Cards
SET IsEquippedByBlackPendant = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Black Pendant");

ALTER TABLE Cards ADD IsEquippedByBookofSecretArts INT;
UPDATE Cards
SET IsEquippedByBookofSecretArts = 0;
UPDATE Cards
SET IsEquippedByBookofSecretArts = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Book of Secret Arts");

ALTER TABLE Cards ADD IsEquippedByBrightCastle INT;
UPDATE Cards
SET IsEquippedByBrightCastle = 0;
UPDATE Cards
SET IsEquippedByBrightCastle = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Bright Castle");

ALTER TABLE Cards ADD IsEquippedByCyberShield INT;
UPDATE Cards
SET IsEquippedByCyberShield = 0;
UPDATE Cards
SET IsEquippedByCyberShield = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Cyber Shield");

ALTER TABLE Cards ADD IsEquippedByDarkEnergy INT;
UPDATE Cards
SET IsEquippedByDarkEnergy = 0;
UPDATE Cards
SET IsEquippedByDarkEnergy = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Dark Energy");

ALTER TABLE Cards ADD IsEquippedByDragonTreasure INT;
UPDATE Cards
SET IsEquippedByDragonTreasure = 0;
UPDATE Cards
SET IsEquippedByDragonTreasure = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Dragon Treasure");

ALTER TABLE Cards ADD IsEquippedByElectrowhip INT;
UPDATE Cards
SET IsEquippedByElectrowhip = 0;
UPDATE Cards
SET IsEquippedByElectrowhip = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Electro-whip");

ALTER TABLE Cards ADD IsEquippedByElegantEgotist INT;
UPDATE Cards
SET IsEquippedByElegantEgotist = 0;
UPDATE Cards
SET IsEquippedByElegantEgotist = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Elegant Egotist");

ALTER TABLE Cards ADD IsEquippedByElfsLight INT;
UPDATE Cards
SET IsEquippedByElfsLight = 0;
UPDATE Cards
SET IsEquippedByElfsLight = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Elf's Light");

ALTER TABLE Cards ADD IsEquippedByFollowWind INT;
UPDATE Cards
SET IsEquippedByFollowWind = 0;
UPDATE Cards
SET IsEquippedByFollowWind = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Follow Wind");

ALTER TABLE Cards ADD IsEquippedByHornofLight INT;
UPDATE Cards
SET IsEquippedByHornofLight = 0;
UPDATE Cards
SET IsEquippedByHornofLight = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Horn of Light");

ALTER TABLE Cards ADD IsEquippedByHornoftheUnicorn INT;
UPDATE Cards
SET IsEquippedByHornoftheUnicorn = 0;
UPDATE Cards
SET IsEquippedByHornoftheUnicorn = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Horn of the Unicorn");

ALTER TABLE Cards ADD IsEquippedByInsectArmorwithLaserCannon INT;
UPDATE Cards
SET IsEquippedByInsectArmorwithLaserCannon = 0;
UPDATE Cards
SET IsEquippedByInsectArmorwithLaserCannon = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Insect Armor with Laser Cannon");

ALTER TABLE Cards ADD IsEquippedByInvigoration INT;
UPDATE Cards
SET IsEquippedByInvigoration = 0;
UPDATE Cards
SET IsEquippedByInvigoration = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Invigoration");

ALTER TABLE Cards ADD IsEquippedByKunaiwithChain INT;
UPDATE Cards
SET IsEquippedByKunaiwithChain = 0;
UPDATE Cards
SET IsEquippedByKunaiwithChain = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Kunai with Chain");

ALTER TABLE Cards ADD IsEquippedByLaserCannonArmor INT;
UPDATE Cards
SET IsEquippedByLaserCannonArmor = 0;
UPDATE Cards
SET IsEquippedByLaserCannonArmor = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Laser Cannon Armor");

ALTER TABLE Cards ADD IsEquippedByLegendarySword INT;
UPDATE Cards
SET IsEquippedByLegendarySword = 0;
UPDATE Cards
SET IsEquippedByLegendarySword = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Legendary Sword");

ALTER TABLE Cards ADD IsEquippedByMachineConversionFactory INT;
UPDATE Cards
SET IsEquippedByMachineConversionFactory = 0;
UPDATE Cards
SET IsEquippedByMachineConversionFactory = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Machine Conversion Factory");

ALTER TABLE Cards ADD IsEquippedByMagicalLabyrinth INT;
UPDATE Cards
SET IsEquippedByMagicalLabyrinth = 0;
UPDATE Cards
SET IsEquippedByMagicalLabyrinth = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Magical Labyrinth");

ALTER TABLE Cards ADD IsEquippedByMalevolentNuzzler INT;
UPDATE Cards
SET IsEquippedByMalevolentNuzzler = 0;
UPDATE Cards
SET IsEquippedByMalevolentNuzzler = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Malevolent Nuzzler");

ALTER TABLE Cards ADD IsEquippedByMegamorph INT;
UPDATE Cards
SET IsEquippedByMegamorph = 0;
UPDATE Cards
SET IsEquippedByMegamorph = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Megamorph");

ALTER TABLE Cards ADD IsEquippedByMetalmorph INT;
UPDATE Cards
SET IsEquippedByMetalmorph = 0;
UPDATE Cards
SET IsEquippedByMetalmorph = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Metalmorph");

ALTER TABLE Cards ADD IsEquippedByMysticalMoon INT;
UPDATE Cards
SET IsEquippedByMysticalMoon = 0;
UPDATE Cards
SET IsEquippedByMysticalMoon = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Mystical Moon");

ALTER TABLE Cards ADD IsEquippedByPowerofKaishin INT;
UPDATE Cards
SET IsEquippedByPowerofKaishin = 0;
UPDATE Cards
SET IsEquippedByPowerofKaishin = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Power of Kaishin");

ALTER TABLE Cards ADD IsEquippedByRaiseBodyHeat INT;
UPDATE Cards
SET IsEquippedByRaiseBodyHeat = 0;
UPDATE Cards
SET IsEquippedByRaiseBodyHeat = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Raise Body Heat");

ALTER TABLE Cards ADD IsEquippedBySalamandra INT;
UPDATE Cards
SET IsEquippedBySalamandra = 0;
UPDATE Cards
SET IsEquippedBySalamandra = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Salamandra");

ALTER TABLE Cards ADD IsEquippedBySilverBowandArrow INT;
UPDATE Cards
SET IsEquippedBySilverBowandArrow = 0;
UPDATE Cards
SET IsEquippedBySilverBowandArrow = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Silver Bow and Arrow");

ALTER TABLE Cards ADD IsEquippedBySteelShell INT;
UPDATE Cards
SET IsEquippedBySteelShell = 0;
UPDATE Cards
SET IsEquippedBySteelShell = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Steel Shell");

ALTER TABLE Cards ADD IsEquippedBySwordofDarkDestruction INT;
UPDATE Cards
SET IsEquippedBySwordofDarkDestruction = 0;
UPDATE Cards
SET IsEquippedBySwordofDarkDestruction = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Sword of Dark Destruction");

ALTER TABLE Cards ADD IsEquippedByVileGerms INT;
UPDATE Cards
SET IsEquippedByVileGerms = 0;
UPDATE Cards
SET IsEquippedByVileGerms = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Vile Germs");

ALTER TABLE Cards ADD IsEquippedByVioletCrystal INT;
UPDATE Cards
SET IsEquippedByVioletCrystal = 0;
UPDATE Cards
SET IsEquippedByVioletCrystal = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Violet Crystal");

ALTER TABLE Cards ADD IsEquippedByWingedTrumpeter INT;
UPDATE Cards
SET IsEquippedByWingedTrumpeter = 0;
UPDATE Cards
SET IsEquippedByWingedTrumpeter = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "Winged Trumpeter");

ALTER TABLE Cards ADD TotalEquips INT;
UPDATE Cards
SET    TotalEquips = IsEquippedByAxeofDespair + IsEquippedByBeastFangs + IsEquippedByBlackPendant + IsEquippedByBookofSecretArts + IsEquippedByBrightCastle + IsEquippedByCyberShield + IsEquippedByDarkEnergy + IsEquippedByDragonTreasure + IsEquippedByElectrowhip + IsEquippedByElegantEgotist + IsEquippedByElfsLight + IsEquippedByFollowWind + IsEquippedByHornofLight + IsEquippedByHornoftheUnicorn + IsEquippedByInsectArmorwithLaserCannon + IsEquippedByInvigoration + IsEquippedByKunaiwithChain + IsEquippedByLaserCannonArmor + IsEquippedByLegendarySword + IsEquippedByMachineConversionFactory + IsEquippedByMagicalLabyrinth + IsEquippedByMalevolentNuzzler + IsEquippedByMegamorph + IsEquippedByMetalmorph + IsEquippedByMysticalMoon + IsEquippedByPowerofKaishin + IsEquippedByRaiseBodyHeat + IsEquippedBySalamandra + IsEquippedBySilverBowandArrow + IsEquippedBySteelShell + IsEquippedBySwordofDarkDestruction + IsEquippedByVileGerms + IsEquippedByVioletCrystal + IsEquippedByWingedTrumpeter;ALTER TABLE Cards ADD EquippedBy TEXT;
UPDATE Cards
SET    EquippedBy = '';
UPDATE Cards
SET EquippedBy = EquippedBy || 'AxeofDespair '
WHERE IsEquippedByAxeofDespair = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'BeastFangs '
WHERE IsEquippedByBeastFangs = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'BlackPendant '
WHERE IsEquippedByBlackPendant = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'BookofSecretArts '
WHERE IsEquippedByBookofSecretArts = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'BrightCastle '
WHERE IsEquippedByBrightCastle = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'CyberShield '
WHERE IsEquippedByCyberShield = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'DarkEnergy '
WHERE IsEquippedByDarkEnergy = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'DragonTreasure '
WHERE IsEquippedByDragonTreasure = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'Electrowhip '
WHERE IsEquippedByElectrowhip = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'ElegantEgotist '
WHERE IsEquippedByElegantEgotist = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'ElfsLight '
WHERE IsEquippedByElfsLight = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'FollowWind '
WHERE IsEquippedByFollowWind = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'HornofLight '
WHERE IsEquippedByHornofLight = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'HornoftheUnicorn '
WHERE IsEquippedByHornoftheUnicorn = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'InsectArmorwithLaserCannon '
WHERE IsEquippedByInsectArmorwithLaserCannon = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'Invigoration '
WHERE IsEquippedByInvigoration = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'KunaiwithChain '
WHERE IsEquippedByKunaiwithChain = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'LaserCannonArmor '
WHERE IsEquippedByLaserCannonArmor = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'LegendarySword '
WHERE IsEquippedByLegendarySword = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'MachineConversionFactory '
WHERE IsEquippedByMachineConversionFactory = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'MagicalLabyrinth '
WHERE IsEquippedByMagicalLabyrinth = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'MalevolentNuzzler '
WHERE IsEquippedByMalevolentNuzzler = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'Megamorph '
WHERE IsEquippedByMegamorph = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'Metalmorph '
WHERE IsEquippedByMetalmorph = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'MysticalMoon '
WHERE IsEquippedByMysticalMoon = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'PowerofKaishin '
WHERE IsEquippedByPowerofKaishin = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'RaiseBodyHeat '
WHERE IsEquippedByRaiseBodyHeat = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'Salamandra '
WHERE IsEquippedBySalamandra = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'SilverBowandArrow '
WHERE IsEquippedBySilverBowandArrow = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'SteelShell '
WHERE IsEquippedBySteelShell = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'SwordofDarkDestruction '
WHERE IsEquippedBySwordofDarkDestruction = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'VileGerms '
WHERE IsEquippedByVileGerms = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'VioletCrystal '
WHERE IsEquippedByVioletCrystal = 1;
UPDATE Cards
SET EquippedBy = EquippedBy || 'WingedTrumpeter '
WHERE IsEquippedByWingedTrumpeter = 1;
