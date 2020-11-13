drop table if exists PredictedKoumorians;
drop table if exists ActualKoumorians;

create temporary table PredictedKoumorians as
SELECT CardName
FROM Cards
WHERE Attack < 1500 and 
( 
 GuardianStar1 = 'Moon' and CardType IN ('Beast', 'Beast-Warrior', 'Dinosaur', 'Dragon', 'Fiend', 'Insect') or
 CardName in ('Kuriboh', 'Mammoth Graveyard')
 );
 
 create temporary table ActualKoumorians as
 select CardName
 from Cards
 where IsKoumorian = 1;
 
 drop table if exists IncorrectKoumorians;
 create temporary table IncorrectKoumorians as
 select *
 from PredictedKoumorians
 except 
 select *
 from ActualKoumorians;
 
 drop table if exists MissingKoumorians;
 create temporary table MissingKoumorians as
 select *
 from ActualKoumorians
 except 
 select *
 from PredictedKoumorians;
 