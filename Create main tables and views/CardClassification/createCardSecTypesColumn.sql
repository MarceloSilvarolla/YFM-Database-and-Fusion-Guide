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

