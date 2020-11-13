ALTER TABLE Cards ADD TotalSecTypes INT;
UPDATE Cards
SET TotalSecTypes = IsAngelWinged + IsBugrothian + IsDragon + IsEgg + IsElf + IsFeatherFromBear + IsFeatherFromHarpie + IsFeatherFromMachine + IsFemale + IsJar + IsKoumorian + IsMercuryMagicUser + IsMercurySpellcaster + IsMirror + IsMusKingian + IsMystElfian + IsPyro + IsRainbow + IsSheepian + IsThronian + IsTurtle + IsUsableBeast;