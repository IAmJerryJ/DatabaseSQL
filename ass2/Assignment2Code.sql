-- 44434065 Runde Jia


-- -----------------------------------------------------
-- Task4 1. Create Tables
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


drop table if exists Product, Branch, Campaign, Member, ProductStock, DiscountLV;

-- -----------------------------------------------------
-- Table `Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Product` (
  `ProductID` VARCHAR(10) NOT NULL,
  `ProductType` VARCHAR(45) NULL,
  `PackageType` VARCHAR(45) NULL,
  `YearProduced` INT NULL,
  `Price` DOUBLE NULL,
  `Brand` VARCHAR(45) NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Campaign` (
  `campaignID` VARCHAR(10) NOT NULL,
  `CampaignStartDate` DATE NULL,
  `CampaignEndDate` DATE NULL,
  PRIMARY KEY (`campaignID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Branch` (
  `BranchID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`BranchID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Member` (
  `MemberID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `eMail` VARCHAR(45) NULL,
  `MembershipLevel` VARCHAR(45) NULL,
  `MemberExpDate` DATE NULL,
  `BranchID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`MemberID`),
   INDEX `fk_Branch_has_Member_idx` (`BranchID` ASC),
  CONSTRAINT `fk_Branch_has_Member`
    FOREIGN KEY (`BranchID`)
    REFERENCES `Branch` (`BranchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProductStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProductStock` (
  `ProductID` VARCHAR(10) NOT NULL,
  `BranchID` VARCHAR(10) NOT NULL,
  `StockLevel` INT NULL,
  PRIMARY KEY (`BranchID`, `ProductID`),
  INDEX `fk_Branch_has_Product_idx` (`ProductID` ASC),
  CONSTRAINT `fk_Branch_has_Product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_Branch_has_Product_idx2` (`BranchID` ASC),
  CONSTRAINT `fk_Branch_has_Product2`
    FOREIGN KEY (`BranchID`)
    REFERENCES `Branch` (`BranchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DiscountLV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DiscountLV` (
  `MembershipLevel` VARCHAR(45) NOT NULL,
  `campaignID` VARCHAR(10) NOT NULL,
  `ProductID` VARCHAR(10) NOT NULL,
  `Discount` VARCHAR(10) NULL,
  PRIMARY KEY (`MembershipLevel`, `campaignID`, `ProductID`),
  INDEX `fk_campaignID_idx` (`campaignID` ASC),
  CONSTRAINT `fk_campaignID`
    FOREIGN KEY (`campaignID`)
    REFERENCES `Campaign` (`campaignID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
INDEX `fk_ProductID_idx` (`ProductID` ASC),
  CONSTRAINT `fk_ProductID`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Task 4 2. Insert Values
-- -----------------------------------------------------

-- --------------------------------------
-- Insert into 'Product' 
-- --------------------------------------
INSERT INTO Product values ('12345', 'wine', 'bottle', '2010', '25.00', 'Penfold Grange');
INSERT INTO Product values ('12346', 'beer', 'can', '2019', '8.50', 'Corona Extra');
INSERT INTO Product values ('12347', 'beer', 'can', '2018', '10.50', 'Victoria Bitter');
INSERT INTO Product values ('12348', 'spirit', 'bottle', '2008', '50.00', 'Absolut Vodaka');
INSERT INTO Product values ('12349', 'wine', 'bottle', '2008', '30.00', 'Penfold Grange');

-- --------------------------------------
-- Insert into 'Branch' 
-- --------------------------------------
INSERT INTO Branch values ('1');
INSERT INTO Branch values ('2');
INSERT INTO Branch values ('3');
INSERT INTO Branch values ('4');
INSERT INTO Branch values ('5');

-- --------------------------------------
-- Insert into 'Campaign' 
-- --------------------------------------
INSERT INTO Campaign values ('a01', '2021-12-10', '2021-12-31');
INSERT INTO Campaign values ('a02', '2021-01-01', '2021-05-31');
INSERT INTO Campaign values ('a03', '2019-05-05', '2019-07-05');
INSERT INTO Campaign values ('a04', '2022-12-10', '2022-12-31');
INSERT INTO Campaign values ('a05', '2020-09-30', '2020-10-10');

-- --------------------------------------
-- Insert into 'Member' 
-- --------------------------------------
INSERT INTO Member values ('1999', 'Nash', 'Steve', 'nashs@xx.mail', 'Gold', '2021-11-05', '1');
INSERT INTO Member values ('1998', 'Simone', 'Singh', 'simones@xx.mail', 'Gold', '2021-11-20','2');
INSERT INTO Member values ('2000', 'Kiki', 'West', 'kikiw@xx.mail', 'Silver', '2021-12-20','3');
INSERT INTO Member values ('1987', 'Dickson', 'Wu', 'dicksonw@xx.mail', 'Platitum', '2021-12-30','1');
INSERT INTO Member values ('2001', 'Tom', 'Jerry', 'tomj@xx.mail', 'Silver', '2022-01-05','1');
INSERT INTO Member values ('1982', 'Lara', 'Howard', 'larah@xx.mail', 'Gold', '2023-11-05','4');
INSERT INTO Member values ('2015', 'Fisher', 'Derrick', 'fisherd@xx.mail', 'Platitum', '2022-05-05','5');

-- --------------------------------------
-- Insert into 'ProductStock' 
-- --------------------------------------
INSERT INTO ProductStock values ('12345', '1', '10');
INSERT INTO ProductStock values ('12345', '2', '30');
INSERT INTO ProductStock values ('12347', '1', '8');
INSERT INTO ProductStock values ('12348', '3', '100');
INSERT INTO ProductStock values ('12349', '2', '1');
INSERT INTO ProductStock values ('12346', '4', '10');
INSERT INTO ProductStock values ('12346', '5', '50');

-- --------------------------------------
-- Insert into 'DiscountLV' 
-- --------------------------------------
INSERT INTO DiscountLV values ('Gold', 'a01', '12346', '20%');
INSERT INTO DiscountLV values ('Gold', 'a01', '12347', '20%');
INSERT INTO DiscountLV values ('Platitum', 'a01', '12348', '40%');
INSERT INTO DiscountLV values ('Platitum', 'a02', '12348', '35%');
INSERT INTO DiscountLV values ('Silver', 'a01', '12346', '10%');
INSERT INTO DiscountLV values ('Silver', 'a05', '12345', '10%');

-- -----------------------------------------------------
-- Task 4 3. SELECT *
-- -----------------------------------------------------
SELECT * FROM Product;
SELECT * FROM Branch;
SELECT * FROM Campaign;
SELECT * FROM Member;
SELECT * FROM ProductStock;
SELECT * FROM DiscountLV;

-- --------------------------------------
-- Task 5
-- Query 1 
-- --------------------------------------
SELECT BranchID
FROM ProductStock
WHERE ProductID = (
	SELECT ProductID
    FROM Product
    WHERE PackageType = 'bottle'
    AND Brand = 'Penfold Grange'
    AND YearProduced = '2010'
) AND StockLevel >= 5;

-- --------------------------------------
-- Query 2 
-- --------------------------------------
SELECT *
FROM Product
WHERE ProductID IN (
	SELECT ProductID
    FROM DiscountLV
    WHERE Discount = '20%'
    AND MembershipLevel = (
		SELECT MembershipLevel
        FROM Member
        WHERE FirstName =  'Simone'
        AND LastName = 'Singh'
    )
    AND campaignID = (
		SELECT campaignID 
        FROM Campaign
        WHERE '2021-12-24' BETWEEN CampaignStartDate AND CampaignEndDate
    )
);

-- --------------------------------------
-- Query 3
-- --------------------------------------
SELECT eMail
FROM Member
WHERE MemberExpDate BETWEEN DATE_SUB(
    LAST_DAY(
        DATE_ADD(NOW(), INTERVAL 2 MONTH)
    ), 
    INTERVAL DAY(
        LAST_DAY(
            DATE_ADD(NOW(), INTERVAL 2 MONTH)
        )
    )-1 DAY) AND LAST_DAY(
    DATE_ADD(NOW(), INTERVAL 2 MONTH)
)
ORDER BY BranchID ASC,
MemberExpDate ASC,
eMail ASC;

-- --------------------------------------
-- Query 4
-- --------------------------------------
SELECT COUNT(*)
FROM DiscountLV
WHERE ProductID = (
	SELECT ProductID
    FROM Product
    WHERE Brand = 'Penfold Grange' AND YearProduced = '2010'
)
AND campaignID in (
	SELECT campaignID 
    FROM Campaign
    WHERE (CampaignEndDate BETWEEN '2020-03-01' AND curdate())
    OR (CampaignStartDate BETWEEN '2020-03-01' AND curdate())
);
