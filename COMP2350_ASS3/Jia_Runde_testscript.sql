-- Student Name: Runde Jia
-- Student ID: 44434065
/* USE magicale; */

/* Task 4a */
SELECT * FROM Membership;

-- Test update eMail
UPDATE Membership
SET eMail = 'johnsmith@gmail.com'
WHERE MembershipID = 1;
SELECT * FROM Membership;

-- Test upgrading silver to Gold
UPDATE Membership
SET MembershipLevel = 'Gold'
WHERE MembershipID = 5;
SELECT * FROM Membership;

-- Test upgrading expired membership
UPDATE Membership
SET MembershipLevel = 'Platinum'
WHERE MembershipID = 2;
SELECT * FROM Membership;

-- Test updating MembershipExpDate
UPDATE Membership
SET MemberExpDate = '2022-11-28'
WHERE MembershipID = 2;
SELECT * FROM Membership;

-- Test upgrading membershipLevel after refreshing valid MembershipExpDate
UPDATE Membership
SET MembershipLevel = 'Gold'
WHERE MembershipID = 2;
SELECT * FROM Membership;

-- Test Nothing changed
UPDATE Membership
SET MembershipLevel = 'Platinum'
WHERE MembershipID = 3;
SELECT * FROM Membership;

-- Test updating PK column value
UPDATE Membership
SET MembershipID = '118'
WHERE MembershipID = '1';

SELECT * FROM Campaign;
SELECT * FROM DiscountDetails;

CALL BrandNameCampaign('Penfold');
CALL BrandNameCampaign('Blonde');

/* Task 4b */
SELECT * FROM Product;

-- Insert new records
insert  into `Membership`(`MembershipID`,`FirstName`,`LastName`, `eMail`, `MembershipLevel`, `MemberExpDate`) values
(6, 'Kelly', 'Smith', 'kellysimth@gmail.com','Silver', '2021-12-31'),
(7, 'Ben', 'Lue', 'benlue@gmail.com','Gold', '2022-1-31'),
(8, 'Steph', 'Curry', 'stephcurry@gmail.com','Platinum', '2022-1-31'),
(9, 'Lebron', 'James', 'lebronjames@gmail.com','Silver', '2020-1-31'),
(10, 'Kyrie', 'Irving', 'kyrieirving@gmail.com','Gold', '2020-12-31'),
(11, 'Joe', 'Biden', 'joebiden@gmail.com','Platinum', '2020-3-20');

insert  into `Product`(`ProductID`,`ProductType`,`PackageType`,`YearProduced`,`Price`, `Brand`) values 
(6,'Wine', 'Bottle', '1977', 3000, 'Penfold'),
(7,'Beer', 'Can', '2018', 2500, 'Penfold'),
(8,'Wine', 'Can', '2020', 500, 'Penfold'),
(9,'Wine', 'Bottle', '1927', 8000, 'Penfold'),
(10,'Beer','Can', 2010, 50, 'Blonde'),
(11,'Wine','Can', 2019, 20, 'Blonde'),
(12,'Beer','Can', 2021, 20, 'Blonde'),
(13,'Spirit','Can', 2010, 80, 'Blonde'),
(14,'Beer','Can', 2020, 10, 'VB'),
(15,'Wine','Bottle', 2000, 80, 'VB');

-- Test upgrading silver to platinum
UPDATE Membership
SET MembershipLevel = 'Platinum'
WHERE MembershipID = 6;
SELECT * FROM Membership;

-- Test updating silver to silver
UPDATE Membership
SET MembershipLevel = 'Silver'
WHERE MembershipID = 6;
SELECT * FROM Membership;

-- Test updating silver to Gold
UPDATE Membership
SET MembershipLevel = 'Gold'
WHERE MembershipID = 6;
SELECT * FROM Membership;

-- Test upgrade Gold to Gold
UPDATE Membership
SET MembershipLevel = 'Gold'
WHERE MembershipID = 7;
SELECT * FROM Membership;

-- Test upgrade Gold to Platinum
UPDATE Membership
SET MembershipLevel = 'Platinum'
WHERE MembershipID = 7;
SELECT * FROM Membership;

-- Test expried Membership
UPDATE Membership
SET MembershipLevel = 'Gold'
WHERE MembershipID = 9;
SELECT * FROM Membership;

-- Test expired Membership
UPDATE Membership
SET MembershipLevel = 'Silver'
WHERE MembershipID = '10';
SELECT * FROM Membership;

-- Test updating MemberExpDate to valid date and upgrade
UPDATE Membership
SET MembershipLevel = 'Platinum', MemberExpDate = '2022-12-28'
WHERE MembershipID = '10';
SELECT * FROM Membership;

-- Check brand with more than 5 products
CALL BrandNameCampaign('Penfold');

-- Check brand with 5 products
CALL BrandNameCampaign('Blonde');

-- Check brand less than 5 products
CALL BrandNameCampaign('VB');

SELECT * FROM Campaign;
SELECT * FROM DiscountDetails;