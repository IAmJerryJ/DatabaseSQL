-- Student Name: Runde Jia
-- Student ID: 44434065

/* USE magicale; */
/* Task2 */
DELIMITER //
	DROP TRIGGER if exists CHECK_MEMBERSHIP_UPDATE;
//
DELIMITER //
CREATE TRIGGER CHECK_MEMBERSHIP_UPDATE
	BEFORE UPDATE ON Membership
    FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
 
 -- Stop updating PK column value
    IF(NEW.MembershipID != OLD.MembershipID) THEN
    SET msg = 'Cannot update PK colunm value';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
    
-- Check if upgrading MembershipLevel
	IF (NEW.MembershipID = OLD.MembershipID AND NEW.FirstName = OLD.FirstName AND NEW.LastName = OLD.LastName AND NEW.eMail = OLD.eMail
    AND NEW.MembershipLevel=OLD.MembershipLevel AND NEW.MemberExpDate = OLD.MemberExpDate) THEN
    SET msg = 'Nothing updated!';
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     END IF;
     
    IF (NEW.MembershipLevel != OLD.MembershipLevel) THEN
    
-- Check if the Membership has expired
    IF NEW.MemberExpDate < curdate() THEN
     SET msg = 'Membership expired!';
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
    
-- Only Silver can be upgraded to Gold
    IF (OLD.MembershipLevel != 'Silver' AND NEW.MembershipLevel = 'Gold') THEN
		SET msg = 'Membership update failed, only Silver can upgrade to Gold';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =msg;
	END IF;
    
-- Only Gold can be upgraded to Platinum
    IF (OLD.MembershipLevel != 'Gold' AND NEW.MembershipLevel = 'Platinum') THEN
		SET msg = 'Membership update failed, only Gold can upgrade to Platinum';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =msg;
	END IF;
    
    END IF;
END //

DELIMITER ;

/* Task3 */
DELIMITER //
	DROP PROCEDURE IF EXISTS BrandNameCampaign;
//
DELIMITER //
CREATE PROCEDURE BrandNameCampaign(
					IN in_Brand varchar(255)
                    )
BEGIN
	DECLARE v_finished INT DEFAULT 0;
	DECLARE c_ID INT DEFAULT null;
    DECLARE s_date date DEFAULT null;
    DECLARE e_date date DEFAULT null;
    DECLARE p_ID INT DEFAULT 0;
    
-- Create cursor for Top 5 expensive product
    DECLARE campaign_rec CURSOR FOR
			SELECT ProductID 
            FROM Product
            WHERE Product.Brand = in_Brand
            ORDER BY Product.Price DESC
            LIMIT 5;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
-- Create new campaign    
    SELECT (COUNT(*) + 1) 
    INTO c_ID 
    FROM Campaign;

-- Campaign starts in 2 weeks after the creation
	SELECT DATE_ADD(curdate(), INTERVAL 14 DAY)
    INTO s_date;

-- The duration of the campaign is 4 weeks, 6 weeks after creation    
    SELECT DATE_ADD(curdate(), INTERVAL 42 DAY)
    INTO e_date;
    
    insert  into `Campaign`(`CampaignID`,`CampaignStartDate`,`CampaignEndDate`) values 
    (c_ID, s_date, e_date);
 
-- Insert cursor and other attributes to create dicsountdetails for members 
    OPEN campaign_rec;
    REPEAT
		FETCH campaign_rec INTO p_ID;
        IF not(v_finished = 1) THEN
			INSERT INTO `DiscountDetails`(`ProductID`,`CampaignID`,`MembershipLevel`, `Discount`) values 
            (p_ID, c_ID, 'Silver', 10),
            (p_ID, c_ID, 'Gold', 20),
            (p_ID, c_ID, 'Platinum', 30);
		END IF;
        UNTIL v_finished
        END REPEAT;
        CLOSE campaign_rec;
    
END //
DELIMITER ;