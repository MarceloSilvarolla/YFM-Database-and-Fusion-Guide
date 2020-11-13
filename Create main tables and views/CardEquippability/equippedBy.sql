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
