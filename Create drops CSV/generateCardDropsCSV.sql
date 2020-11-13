select Duelist, PoolType, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Password, StarchipCost, IsDragon, IsThunder, CardProb
from (
	select CardId, CardName, GuardianStar1 as GuardianStar1, GuardianStar2 as GuardianStar2, Type as CardType, Attack, Defense, Password, StarchipCost, IsDragon, IsThunder
	from FmDatabase.Cards
	natural join FmDatabaseWithGS.CardInfo)
natural join FmDatabaseWithGS.DropPools
where PoolType <> 'Deck';