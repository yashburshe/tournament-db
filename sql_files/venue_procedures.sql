-- Venue Procedures

-- Get all venues

drop procedure if exists GetAllVenues;
DELIMITER $$
CREATE PROCEDURE GetAllVenues(
) 
BEGIN
    select name from venue;
END$$
DELIMITER ;

-- Get venue details

drop procedure if exists GetVenue;
DELIMITER $$
CREATE PROCEDURE GetVenue(
in venue_name varchar(100)
) 
BEGIN
    select * from venue where name = venue_name;
END$$
DELIMITER ;

-- Add a venue

drop procedure if exists AddVenue;
DELIMITER $$
CREATE PROCEDURE AddVenue(
    IN venue_name VARCHAR(100),
    IN venue_street_number INT,
    IN venue_street_name VARCHAR(100),
    IN venue_city VARCHAR(100),
    IN venue_state VARCHAR(100),
    IN venue_country VARCHAR(100),
    IN venue_zip_code VARCHAR(20)
)
BEGIN
    IF EXISTS (SELECT 1 FROM venue WHERE name = venue_name) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A venue with this name already exists';
    ELSE
        INSERT INTO venue (name, street_number, street_name, city, state, country, zip_code)
        VALUES (venue_name, venue_street_number, venue_street_name, venue_city, venue_state, venue_country, venue_zip_code);
    END IF;
END$$
DELIMITER ;

-- Update venue address

drop procedure if exists UpdateVenue;
DELIMITER $$
CREATE PROCEDURE UpdateVenue(
    IN venue_name VARCHAR(100),
    IN venue_street_number INT,
    IN venue_street_name VARCHAR(100),
    IN venue_city VARCHAR(100),
    IN venue_state VARCHAR(100),
    IN venue_country VARCHAR(100),
    IN venue_zip_code VARCHAR(20)
)
BEGIN
        UPDATE venue
        set
        street_number = venue_street_number,
        street_name = venue_street_name,
        city = venue_city,
        state = venue_state,
        country = venue_country,
        zip_code = venue_zip_code
        where
        name = venue_name;
END$$
DELIMITER ;

-- Delete venue

drop procedure if exists DeleteVenue;
DELIMITER $$
CREATE PROCEDURE DeleteVenue(
    IN venue_name VARCHAR(100)
) 
BEGIN
    IF EXISTS (SELECT 1 FROM tournament WHERE venue = venue_name) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This venue is associated to a tournament';
    ELSE
        delete from venue where name = venue_name;
    END IF;
END$$
DELIMITER ;