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
