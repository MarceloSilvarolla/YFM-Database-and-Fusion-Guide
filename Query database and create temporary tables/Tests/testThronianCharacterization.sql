drop table if exists PredictedThronians;
drop table if exists ActualThronians;

create temporary table PredictedThronians as
SELECT CardName
FROM SimpleCards
WHERE Attack < 1350 and 
(CardType = 'Fiend' and CardName <> 'Candle of Fate' or
 GuardianStar1 = 'Moon' and CardType IN ('Aqua', 'Beast', 'Beast-Warrior', 'Dinosaur', 'Insect', 'Warrior') and CardName not in ('Air Marmot of Nefariousness', 'Obese Marmot of Nefariousness', 'Moon Envoy') or
 CardName = 'Mammoth Graveyard'
 );
 
 create temporary table ActualThronians as
 select CardName
 from SimpleCards
 where IsThronian = 1;
 
 drop table if exists IncorrectThronians;
 create temporary table IncorrectThronians as
 select *
 from PredictedThronians
 except 
 select *
 from ActualThronians;
 
 drop table if exists MissingThronians;
 create temporary table MissingThronians as
 select *
 from ActualThronians
 except 
 select *
 from PredictedThronians;
 