drop table if exists PredictedSheepians;
drop table if exists ActualSheepians;

create temporary table PredictedSheepians as
SELECT CardName
FROM SimpleCards
WHERE Attack < 1150 and 
(CardType = 'Fiend' and CardName not in ('Candle of Fate', 'Key Mace #2') or
 GuardianStar1 = 'Moon' and CardType IN ('Aqua', 'Beast', 'Beast-Warrior', 'Dinosaur', 'Dragon', 'Insect', 'Rock', 'Zombie') or
 CardName = 'Blue-eyed Silver Zombie'
 );
 
 create temporary table ActualSheepians as
 select CardName
 from SimpleCards
 where IsSheepian = 1;
 
 drop table if exists IncorrectSheepians;
 create temporary table IncorrectSheepians as
 select *
 from PredictedSheepians
 except 
 select *
 from ActualSheepians;
 
 drop table if exists MissingSheepians;
 create temporary table MissingSheepians as
 select *
 from ActualSheepians
 except 
 select *
 from PredictedSheepians;
 