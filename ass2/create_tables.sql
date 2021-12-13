SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


drop table if exists Product, Campaign, Member, ProductStock, DiscountLV;

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
-- Table `Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Member` (
  `MemberID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `eMail` VARCHAR(45) NULL,
  `MembershipLevel` VARCHAR(45) NULL,
  `MemberExpDate` DATE NULL,
  `BranchID` INT NULL,
  PRIMARY KEY (`MemberID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProductStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProductStock` (
  `ProductID` VARCHAR(10) NOT NULL,
  `BranchID` INT NOT NULL,
  `StockLevel` INT NULL,
  PRIMARY KEY (`BranchID`, `ProductID`),
  INDEX `fk_Branch_has_Product_idx` (`ProductID` ASC),
  CONSTRAINT `fk_Branch_has_Product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DiscountLV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DiscountLV` (
  `MembershipLevel` INT NOT NULL,
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