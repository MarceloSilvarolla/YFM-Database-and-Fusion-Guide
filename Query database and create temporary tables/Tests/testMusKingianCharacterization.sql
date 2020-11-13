drop table if exists PredictedMusKingians;
drop table if exists ActualMusKingians;

create temporary table PredictedMusKingians as
SELECT CardName
FROM Cards
WHERE Attack < 1750 and 
( 
 IsElf = 0 and GuardianStar1 = 'Sun' and CardType IN ('Fairy', 'Spellcaster', 'Warrior') and CardName <> 'Ray & Temperature' or
 CardName in ('Faith Bird', 'Guardian of the Throne Room', 'Lunar Queen Elzaim', 'Moon Envoy')
 );
 
 create temporary table ActualMusKingians as
 select CardName
 from Cards
 where IsMusKingian = 1;
 
 drop table if exists IncorrectMusKingians;
 create temporary table IncorrectMusKingians as
 select *
 from PredictedMusKingians
 except 
 select *
 from ActualMusKingians;
 
 drop table if exists MissingMusKingians;
 create temporary table MissingMusKingians as
 select *
 from ActualMusKingians
 except 
 select *
 from PredictedMusKingians;
 