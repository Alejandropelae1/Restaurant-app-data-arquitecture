-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Subscriton`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscriton` (
  `SubscirptionID` INT NOT NULL,
  `Subscrition` CHAR(2) NOT NULL,
  `SubscritionOptionsID` INT NOT NULL,
  PRIMARY KEY (`SubscirptionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `IDcustomers` INT NOT NULL AUTO_INCREMENT,
  `Customer_Lastname` VARCHAR(45) NOT NULL,
  `Customer_Firstname` VARCHAR(45) NOT NULL,
  `Phone` CHAR(10) NOT NULL,
  `SubscirptionID` INT NOT NULL,
  PRIMARY KEY (`IDcustomers`),
  INDEX `fk_Customers_Subscriton1_idx` (`SubscirptionID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Subscriton1`
    FOREIGN KEY (`SubscirptionID`)
    REFERENCES `mydb`.`Subscriton` (`SubscirptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Restaurant` (
  `IDRestaurant` INT NOT NULL AUTO_INCREMENT,
  `Restaurant_Name` VARCHAR(50) NOT NULL,
  `Phone` CHAR(10) NOT NULL,
  `IDcustomer` INT NOT NULL,
  `SubscirptionID` INT NULL,
  PRIMARY KEY (`IDRestaurant`),
  INDEX `customerID_idx` (`IDcustomer` ASC) VISIBLE,
  INDEX `fk_Restaurant_Subscriton1_idx` (`SubscirptionID` ASC) VISIBLE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`IDcustomer`)
    REFERENCES `mydb`.`Customers` (`IDcustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_Subscriton1`
    FOREIGN KEY (`SubscirptionID`)
    REFERENCES `mydb`.`Subscriton` (`SubscirptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `AddresID` INT NOT NULL,
  `Addresline1` VARCHAR(150) NOT NULL,
  `Addresline2` VARCHAR(150) NULL,
  `Postalcode` CHAR(10) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `State` CHAR(2) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `IDRestaurant` INT NOT NULL,
  `IDcustomers` INT NOT NULL,
  PRIMARY KEY (`AddresID`),
  INDEX `fk_Address_Restaurant1_idx` (`IDRestaurant` ASC) VISIBLE,
  INDEX `fk_Address_Customers1_idx` (`IDcustomers` ASC) VISIBLE,
  CONSTRAINT `fk_Address_Restaurant1`
    FOREIGN KEY (`IDRestaurant`)
    REFERENCES `mydb`.`Restaurant` (`IDRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Customers1`
    FOREIGN KEY (`IDcustomers`)
    REFERENCES `mydb`.`Customers` (`IDcustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservation` (
  `IDReservation` INT NOT NULL AUTO_INCREMENT,
  `ReservationNumber` INT NOT NULL,
  `Time` TIME NOT NULL,
  `reservationdate` DATE NOT NULL,
  `Month` CHAR(3) NOT NULL,
  `year` YEAR(4) NOT NULL,
  `IDRestaurant` INT NOT NULL,
  `IDcustomers` INT NOT NULL,
  PRIMARY KEY (`IDReservation`),
  INDEX `restaurantID_idx` (`IDRestaurant` ASC) VISIBLE,
  INDEX `fk_Reservation_Customers1_idx` (`IDcustomers` ASC) VISIBLE,
  CONSTRAINT `restaurantID`
    FOREIGN KEY (`IDRestaurant`)
    REFERENCES `mydb`.`Restaurant` (`IDRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Customers1`
    FOREIGN KEY (`IDcustomers`)
    REFERENCES `mydb`.`Customers` (`IDcustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RestaurantStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RestaurantStatus` (
  `RetaurantStatusID` INT NOT NULL AUTO_INCREMENT,
  `RestaurantStatus` CHAR(2) NOT NULL,
  `Statuswatingtime` TIME NOT NULL,
  `StatusNumberOfCustumerAhead` CHAR(3) NOT NULL,
  `RestaurantID` INT NOT NULL,
  PRIMARY KEY (`RetaurantStatusID`),
  INDEX `restaurantid_idx` (`RestaurantID` ASC) VISIBLE,
  CONSTRAINT `restaurantid`
    FOREIGN KEY (`RestaurantID`)
    REFERENCES `mydb`.`Restaurant` (`IDRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderpaymentID`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderpaymentID` (
  `OrederpaymentID` INT NOT NULL,
  `Orderpayment` CHAR(2) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrederpaymentID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customers` (`IDcustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Saleproducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Saleproducts` (
  `saleProductsID` INT NOT NULL,
  `Quantity` VARCHAR(45) NOT NULL,
  `PriceEach` VARCHAR(45) NOT NULL,
  `OrderpaymentID` INT NOT NULL,
  `IDReservation` INT NOT NULL,
  PRIMARY KEY (`saleProductsID`),
  INDEX `Orderpayment _idx` (`OrderpaymentID` ASC) VISIBLE,
  INDEX `fk_Saleproducts_Reservation1_idx` (`IDReservation` ASC) VISIBLE,
  CONSTRAINT `OrderpaymentID`
    FOREIGN KEY (`OrderpaymentID`)
    REFERENCES `mydb`.`OrderpaymentID` (`OrederpaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Saleproducts_Reservation1`
    FOREIGN KEY (`IDReservation`)
    REFERENCES `mydb`.`Reservation` (`IDReservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `Productcode` CHAR(5) NOT NULL,
  `ProductlineID` VARCHAR(20) NOT NULL,
  `RestaurantID` INT NOT NULL,
  `Saleproducts_saleProductsID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `restaurantID_idx` (`RestaurantID` ASC) VISIBLE,
  INDEX `fk_Product_Saleproducts1_idx` (`Saleproducts_saleProductsID` ASC) VISIBLE,
  CONSTRAINT `restaurantID`
    FOREIGN KEY (`RestaurantID`)
    REFERENCES `mydb`.`Restaurant` (`IDRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Saleproducts1`
    FOREIGN KEY (`Saleproducts_saleProductsID`)
    REFERENCES `mydb`.`Saleproducts` (`saleProductsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StatusComplete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StatusComplete` (
  `StatusCompleteID` INT NOT NULL,
  `StatusComplete` CHAR(2) NOT NULL,
  `ReservationstatusID` INT NOT NULL,
  PRIMARY KEY (`StatusCompleteID`),
  INDEX `Reservation_idx` (`ReservationstatusID` ASC) VISIBLE,
  CONSTRAINT `Reservation`
    FOREIGN KEY (`ReservationstatusID`)
    REFERENCES `mydb`.`Reservation` (`IDReservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Message` (
  `MessageID` INT NOT NULL,
  `Message` VARCHAR(50) NOT NULL,
  `statuscompleID` INT NOT NULL,
  PRIMARY KEY (`MessageID`),
  INDEX `statuscompleteID_idx` (`statuscompleID` ASC) VISIBLE,
  CONSTRAINT `statuscompleteID`
    FOREIGN KEY (`statuscompleID`)
    REFERENCES `mydb`.`StatusComplete` (`StatusCompleteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subscriptionoptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscriptionoptions` (
  `IDSubscriptionOptions` INT NOT NULL,
  `Subscriptionoptions` VARCHAR(45) NOT NULL,
  `SubscirptionID` INT NOT NULL,
  PRIMARY KEY (`IDSubscriptionOptions`),
  INDEX `fk_Subscriptionoptions_Subscriton1_idx` (`SubscirptionID` ASC) VISIBLE,
  CONSTRAINT `fk_Subscriptionoptions_Subscriton1`
    FOREIGN KEY (`SubscirptionID`)
    REFERENCES `mydb`.`Subscriton` (`SubscirptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
