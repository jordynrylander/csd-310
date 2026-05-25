/*
    Title: create_outland_adventures_db_updated.sql
    Date: 23 May 2026
    Description: outland adventures database initialization script with expanded seed data and updated equipment business rules.
*/

-- drop database if exists and create a new one
DROP DATABASE IF EXISTS outland_adventures;
CREATE DATABASE outland_adventures;
USE outland_adventures;

-- drop database user if exists
DROP USER IF EXISTS 'outland_user'@'localhost';

-- create outland_user and grant them all privileges to the outland_adventures database
CREATE USER 'outland_user'@'localhost' IDENTIFIED BY 'Password123!!';
GRANT ALL PRIVILEGES ON outland_adventures.* TO 'outland_user'@'localhost';

-- create the Employee_Role table
CREATE TABLE Employee_Role (
    role_id INT NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (role_id)
);

-- create the Customer table
CREATE TABLE Customer (
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    PRIMARY KEY (customer_id)
);

-- create the Employee table
CREATE TABLE Employee (
    employee_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    CONSTRAINT fk_employee_role
        FOREIGN KEY (role_id)
        REFERENCES Employee_Role(role_id)
);

-- create the Trip table
CREATE TABLE Trip (
    trip_id INT NOT NULL,
    trip_name VARCHAR(100) NOT NULL,
    trip_date DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    guide_id INT NOT NULL,
    PRIMARY KEY (trip_id),
    CONSTRAINT fk_trip_employee
        FOREIGN KEY (guide_id)
        REFERENCES Employee(employee_id)
);

-- create the Booking table
CREATE TABLE Booking (
    booking_id INT NOT NULL,
    customer_id INT NOT NULL,
    trip_id INT NOT NULL,
    booking_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),
    CONSTRAINT fk_booking_trip
        FOREIGN KEY (trip_id)
        REFERENCES Trip(trip_id)
);

-- create the Equipment table with additional columns for equipment age and manufacture date
CREATE TABLE Equipment (
    equipment_id INT NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    condition_status VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL,
    needs_inspection BOOLEAN NOT NULL DEFAULT FALSE,
    equipment_age INT, -- added new column to track equipment age
    manufacture_date DATE, -- added new column to track manufacture date
    PRIMARY KEY (equipment_id)
);

-- create the Equipment_Purchase table
CREATE TABLE Equipment_Purchase (
    purchase_id INT NOT NULL,
    customer_id INT NOT NULL,
    equipment_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    transaction_date DATE NOT NULL,
    PRIMARY KEY (purchase_id),
    CONSTRAINT fk_purchase_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),
    CONSTRAINT fk_purchase_equipment
        FOREIGN KEY (equipment_id)
        REFERENCES Equipment(equipment_id)
);

-- insert sample data into the tables
INSERT INTO Employee_Role (role_id, role_name) VALUES
    (1, 'Guide'),
    (2, 'Marketing'),
    (3, 'Inventory'),
    (4, 'Admin'),
    (5, 'Software Developer');

INSERT INTO Customer (customer_id, first_name, last_name, email, phone) VALUES
    (1, 'John', 'Smith', 'john@email.com', '1234567890'),
    (2, 'Maria', 'Lopez', 'maria@email.com', '1234567891'),
    (3, 'David', 'Johnson', 'david@email.com', '1234567892'),
    (4, 'Sarah', 'Williams', 'sarah@email.com', '1234567893'),
    (5, 'James', 'Brown', 'james@email.com', '1234567894'),
    (6, 'Linda', 'Davis', 'linda@email.com', '1234567895'),
    (7, 'Robert', 'Miller', 'robert@email.com', '1234567896'),
    (8, 'Patricia', 'Wilson', 'patricia@email.com', '1234567897'),
    (9, 'Michael', 'Moore', 'michael@email.com', '1234567898'),
    (10, 'Elizabeth', 'Taylor', 'elizabeth@email.com', '1234567899'),
    (11, 'William', 'Anderson', 'william@email.com', '1234567800'),
    (12, 'Barbara', 'Thomas', 'barbara@email.com', '1234567801'),
    (13, 'Richard', 'Jackson', 'richard@email.com', '1234567802'),
    (14, 'Susan', 'White', 'susan@email.com', '1234567803'),
    (15, 'Joseph', 'Harris', 'joseph@email.com', '1234567804'),
    (16, 'Jessica', 'Martin', 'jessica@email.com', '1234567805'),
    (17, 'Thomas', 'Thompson', 'thomas@email.com', '1234567806'),
    (18, 'Sarah', 'Garcia', 'sarah.g@email.com', '1234567807'),
    (19, 'Charles', 'Martinez', 'charles@email.com', '1234567808'),
    (20, 'Karen', 'Robinson', 'karen@email.com', '1234567809'),
    (21, 'Christopher', 'Clark', 'chris@email.com', '1234567810'),
    (22, 'Nancy', 'Rodriguez', 'nancy@email.com', '1234567811'),
    (23, 'Daniel', 'Lewis', 'daniel@email.com', '1234567812'),
    (24, 'Lisa', 'Lee', 'lisa@email.com', '1234567813'),
    (25, 'Matthew', 'Walker', 'matthew@email.com', '1234567814'),
    (26, 'Betty', 'Hall', 'betty@email.com', '1234567815'),
    (27, 'Anthony', 'Allen', 'anthony@email.com', '1234567816'),
    (28, 'Sandra', 'Young', 'sandra@email.com', '1234567817'),
    (29, 'Mark', 'Hernandez', 'mark@email.com', '1234567818'),
    (30, 'Ashley', 'King', 'ashley@email.com', '1234567819'),
    (31, 'Donald', 'Wright', 'donald@email.com', '1234567820'),
    (32, 'Kimberly', 'Lopez', 'kim@email.com', '1234567821');

INSERT INTO Employee (employee_id, first_name, last_name, email, role_id) VALUES
    (1, 'Jake', 'Willson', 'jake@email.com', 1),
    (2, 'Ned', 'Willson', 'ned@email.com', 1),
    (3, 'Phoenix', 'TwoStar', 'phoenix@email.com', 3),
    (4, 'June', 'Santos', 'june@email.com', 4),
    (5, 'Mads', 'Mackenzie', 'mads@email.com', 2),
    (6, 'Juan', 'Snow', 'juan@email.com', 5),
    (7, 'Alice', 'Green', 'alice@email.com', 1),
    (8, 'Charlie', 'Baker', 'charlie@email.com', 2),
    (9, 'Diana', 'Prince', 'diana@email.com', 3),
    (10, 'Evan', 'Wright', 'evan@email.com', 4),
    (11, 'Fiona', 'Gallagher', 'fiona@email.com', 5),
    (12, 'George', 'Costanza', 'george@email.com', 1),
    (13, 'Hannah', 'Abbott', 'hannah@email.com', 3),
    (14, 'Ian', 'Malcolm', 'ian@email.com', 4),
    (15, 'Julia', 'Roberts', 'julia@email.com', 5),
    (16, 'Kevin', 'Bacon', 'kevin@email.com', 1),
    (17, 'Laura', 'Croft', 'laura@email.com', 2),
    (18, 'Mike', 'Wazowski', 'mike@email.com', 1),
    (19, 'Nina', 'Simone', 'nina@email.com', 3),
    (20, 'Oscar', 'Martinez', 'oscar@email.com', 1),
    (21, 'Pam', 'Beesly', 'pam@email.com', 4),
    (22, 'Quinn', 'Fabray', 'quinn@email.com', 5),
    (23, 'Ray', 'Stantz', 'ray@email.com', 1),
    (24, 'Stanley', 'Hudson', 'stanley@email.com', 5),
    (25, 'Toby', 'Flenderson', 'toby@email.com', 3),
    (26, 'Ursula', 'Buffay', 'ursula@email.com', 3),
    (27, 'Victor', 'Frankenstein', 'victor@email.com', 1),
    (28, 'Wendy', 'Darling', 'wendy@email.com', 2),
    (29, 'Xavier', 'Charles', 'xavier@email.com', 1),
    (30, 'Yolanda', 'Saldivar', 'yolanda@email.com', 4),
    (31, 'Zack', 'Morris', 'zack@email.com', 1),
    (32, 'Arthur', 'Pendragon', 'arthur@email.com', 2);

INSERT INTO Trip (trip_id, trip_name, trip_date, location, region, guide_id) VALUES
    (1, 'Safari Adventure', '2026-06-01', 'Africa', 'Africa', 1),
    (2, 'Mountain Trek', '2026-07-10', 'Asia', 'Asia', 2),
    (3, 'Beach Escape', '2026-08-15', 'Southern Europe', 'Southern Europe', 1),
    (4, 'Desert Tour', '2026-09-01', 'Africa', 'Africa', 2),
    (5, 'Forest Hike', '2026-10-05', 'Asia', 'Asia', 1),
    (6, 'Island Trip', '2026-11-20', 'Southern Europe', 'Southern Europe', 2),
    (7, 'Alps Skiing', '2026-12-15', 'Western Europe', 'Western Europe', 1),
    (8, 'Amazon Expedition', '2027-01-10', 'South America', 'South America', 2),
    (9, 'Outback Journey', '2027-02-18', 'Australia', 'Australia', 1),
    (10, 'Canyon Rafting', '2027-03-22', 'North America', 'North America', 2),
    (11, 'Nordic Lights', '2027-04-05', 'Northern Europe', 'Northern Europe', 1),
    (12, 'Tokyo Urban Tour', '2027-05-12', 'Asia', 'Asia', 2),
    (13, 'Egyptian Pyramids', '2027-06-18', 'Africa', 'Africa', 1),
    (14, 'Andes Mountaineering', '2027-07-24', 'South America', 'South America', 2),
    (15, 'Patagonia Hiking', '2027-08-30', 'South America', 'South America', 18),
    (16, 'Grand Canyon Walk', '2027-09-14', 'North America', 'North America', 18),
    (17, 'Icelandic Volcanoes', '2027-10-22', 'Northern Europe', 'Northern Europe', 1),
    (18, 'Fuji Summit Climb', '2027-11-05', 'Asia', 'Asia', 2),
    (19, 'Great Wall Trek', '2027-12-01', 'Asia', 'Asia', 1),
    (20, 'Galapagos Cruise', '2028-01-15', 'South America', 'South America', 2),
    (21, 'Serengeti Migration', '2028-02-20', 'Africa', 'Africa', 1),
    (22, 'Kiwi Explorer', '2028-03-11', 'Oceania', 'New Zealand', 2),
    (23, 'Costa Rica Zipline', '2028-04-19', 'Central America', 'Central America', 1),
    (24, 'Alaska Ice Climb', '2028-05-25', 'North America', 'North America', 18),
    (25, 'Mediterranean Sail', '2028-06-12', 'Southern Europe', 'Southern Europe', 2),
    (26, 'Machu Picchu Trail', '2028-07-08', 'South America', 'South America', 1),
    (27, 'Sahara Caravan', '2028-08-22', 'Africa', 'Africa', 2),
    (28, 'Scottish Highlands', '2028-09-17', 'Northern Europe', 'Northern Europe', 1),
    (29, 'Canadian Rockies', '2028-10-30', 'North America', 'North America', 18),
    (30, 'Tasmanian Wilderness', '2028-11-14', 'Oceania', 'Australia', 2),
    (31, 'Himalayan Foothills', '2028-12-20', 'Asia', 'Asia', 1),
    (32, 'Antarctic Voyage', '2029-01-10', 'Polar', 'Antarctica', 2);

INSERT INTO Booking (booking_id, customer_id, trip_id, booking_date, status) VALUES
    (1, 1, 1, '2026-05-01', 'Confirmed'),
    (2, 2, 2, '2026-05-02', 'Confirmed'),
    (3, 3, 3, '2026-05-03', 'Pending'),
    (4, 4, 4, '2026-05-04', 'Confirmed'),
    (5, 5, 5, '2026-05-05', 'Cancelled'),
    (6, 6, 6, '2026-05-06', 'Confirmed'),
    (7, 7, 7, '2026-05-07', 'Confirmed'),
    (8, 8, 8, '2026-05-08', 'Pending'),
    (9, 9, 9, '2026-05-09', 'Confirmed'),
    (10, 10, 10, '2026-05-10', 'Confirmed'),
    (11, 11, 11, '2026-05-11', 'Cancelled'),
    (12, 12, 12, '2026-05-12', 'Confirmed'),
    (13, 13, 13, '2026-05-13', 'Confirmed'),
    (14, 14, 14, '2026-05-14', 'Pending'),
    (15, 15, 15, '2026-05-15', 'Confirmed'),
    (16, 16, 16, '2026-05-16', 'Confirmed'),
    (17, 17, 17, '2026-05-17', 'Confirmed'),
    (18, 18, 18, '2026-05-18', 'Cancelled'),
    (19, 19, 19, '2026-05-19', 'Confirmed'),
    (20, 20, 20, '2026-05-20', 'Confirmed'),
    (21, 21, 21, '2026-05-21', 'Pending'),
    (22, 22, 22, '2026-05-22', 'Confirmed'),
    (23, 23, 23, '2026-05-23', 'Confirmed'),
    (24, 24, 24, '2026-05-24', 'Confirmed'),
    (25, 25, 25, '2026-05-25', 'Cancelled'),
    (26, 26, 26, '2026-05-26', 'Confirmed'),
    (27, 27, 27, '2026-05-27', 'Confirmed'),
    (28, 28, 28, '2026-05-28', 'Pending'),
    (29, 29, 29, '2026-05-29', 'Confirmed'),
    (30, 30, 30, '2026-05-30', 'Confirmed'),
    (31, 31, 31, '2026-05-31', 'Confirmed'),
    (32, 32, 32, '2026-06-01', 'Confirmed');

INSERT INTO Equipment
    (equipment_id, equipment_name, purchase_date, quantity, condition_status, status, needs_inspection, equipment_age, manufacture_date)
VALUES
    (1, 'Tent', '2020-01-01', 1, 'Good', 'Available', TRUE, 6, '2020-01-01'),
    (2, 'Backpack', '2021-03-15', 1, 'Good', 'Available', FALSE, 5, '2021-03-15'),
    (3, 'Sleeping Bag', '2019-07-10', 1, 'Fair', 'In Use', TRUE, 7, '2019-07-10'),
    (4, 'Boots', '2022-05-20', 1, 'Excellent', 'Available', FALSE, 4, '2022-05-20'),
    (5, 'Jacket', '2018-11-30', 1, 'Poor', 'Repair', TRUE, 8, '2018-11-30'),
    (6, 'Helmet', '2023-02-10', 1, 'Excellent', 'Available', FALSE, 3, '2023-02-10'),
    (7, 'Climbing Rope', '2024-04-12', 5, 'Excellent', 'Available', FALSE, 2, '2024-04-12'),
    (8, 'Carabiner', '2025-01-15', 20, 'Excellent', 'Available', FALSE, 1, '2025-01-15'),
    (9, 'Portable Stove', '2017-06-20', 2, 'Poor', 'Repair', TRUE, 9, '2017-06-20'),
    (10, 'First Aid Kit', '2026-01-05', 10, 'Good', 'Available', FALSE, 0, '2026-01-05'),
    (11, 'GPS Navigator', '2021-09-18', 4, 'Fair', 'In Use', FALSE, 5, '2021-09-18'),
    (12, 'Trekking Poles', '2020-11-05', 8, 'Poor', 'Available', TRUE, 6, '2020-11-05'),
    (13, 'Headlamp', '2023-08-14', 15, 'Excellent', 'Available', FALSE, 3, '2023-08-14'),
    (14, 'Pocket Knife', '2022-02-11', 6, 'Good', 'Available', FALSE, 4, '2022-02-11'),
    (15, 'Water Flask', '2025-05-20', 25, 'Excellent', 'Available', FALSE, 1, '2025-05-20'),
    (16, 'Compass', '2016-04-12', 5, 'Poor', 'Repair', TRUE, 10, '2016-04-12'),
    (17, 'Camping Chair', '2020-03-01', 12, 'Poor', 'Available', TRUE, 6, '2020-03-01'),
    (18, 'Foldable Table', '2021-07-19', 4, 'Good', 'Available', FALSE, 5, '2021-07-19'),
    (19, 'Cooler Box', '2019-06-11', 3, 'Fair', 'In Use', FALSE, 7, '2019-06-11'),
    (20, 'Hammock', '2024-05-01', 10, 'Excellent', 'Available', FALSE, 2, '2024-05-01'),
    (21, 'Mess Kit', '2020-10-15', 14, 'Poor', 'Available', TRUE, 6, '2020-10-15'),
    (22, 'Matches Case', '2025-11-12', 50, 'Excellent', 'Available', FALSE, 1, '2025-11-12'),
    (23, 'Dry Bag', '2022-08-24', 9, 'Good', 'Available', FALSE, 4, '2022-08-24'),
    (24, 'Binoculars', '2018-02-14', 4, 'Poor', 'Repair', TRUE, 8, '2018-02-14'),
    (25, 'Solar Charger', '2023-03-29', 7, 'Good', 'Available', FALSE, 3, '2023-03-29'),
    (26, 'Mosquito Net', '2020-05-14', 20, 'Poor', 'Available', TRUE, 6, '2020-05-14'),
    (27, 'Axe Hatchet', '2017-09-01', 2, 'Poor', 'Repair', TRUE, 9, '2017-09-01'),
    (28, 'Sleeping Pad', '2021-12-05', 15, 'Fair', 'In Use', FALSE, 5, '2021-12-05'),
    (29, 'Tarp Cover', '2022-06-18', 11, 'Good', 'Available', FALSE, 4, '2022-06-18'),
    (30, 'Rain Poncho', '2024-10-01', 30, 'Excellent', 'Available', FALSE, 2, '2024-10-01'),
    (31, 'Multi-tool', '2023-01-15', 13, 'Excellent', 'Available', FALSE, 3, '2023-01-15'),
    (32, 'Snowshoes', '2020-12-25', 6, 'Poor', 'Available', TRUE, 6, '2020-12-25');

-- Updated Business Rules:
-- Rule 1: equipment older than 6 years should be marked for repair and inspection.
UPDATE Equipment
SET
    status = 'Repair',
    needs_inspection = TRUE
WHERE equipment_id > 0
  AND equipment_age > 6;

-- Rule 2: equipment older than 5 years should have poor condition status.
UPDATE Equipment
SET condition_status = 'Poor'
WHERE equipment_id > 0
  AND equipment_age > 5;

-- continues inserting sample data into the tables
INSERT INTO Equipment_Purchase
    (purchase_id, customer_id, equipment_id, transaction_type, transaction_date)
VALUES
    (1, 1, 1, 'Buy', '2026-04-01'),
    (2, 2, 2, 'Rent', '2026-04-02'),
    (3, 3, 3, 'Buy', '2026-04-03'),
    (4, 4, 4, 'Rent', '2026-04-04'),
    (5, 5, 5, 'Buy', '2026-04-05'),
    (6, 6, 6, 'Rent', '2026-04-06'),
    (7, 7, 7, 'Buy', '2026-04-07'),
    (8, 8, 8, 'Rent', '2026-04-08'),
    (9, 9, 9, 'Buy', '2026-04-09'),
    (10, 10, 10, 'Buy', '2026-04-10'),
    (11, 11, 11, 'Rent', '2026-04-11'),
    (12, 12, 12, 'Rent', '2026-04-12'),
    (13, 13, 13, 'Buy', '2026-04-13'),
    (14, 14, 14, 'Rent', '2026-04-14'),
    (15, 15, 15, 'Buy', '2026-04-15'),
    (16, 16, 16, 'Buy', '2026-04-16'),
    (17, 17, 17, 'Rent', '2026-04-17'),
    (18, 18, 18, 'Rent', '2026-04-18'),
    (19, 19, 19, 'Buy', '2026-04-19'),
    (20, 20, 20, 'Rent', '2026-04-20'),
    (21, 21, 21, 'Buy', '2026-04-21'),
    (22, 22, 22, 'Buy', '2026-04-22'),
    (23, 23, 23, 'Rent', '2026-04-23'),
    (24, 24, 24, 'Rent', '2026-04-24'),
    (25, 25, 25, 'Buy', '2026-04-25'),
    (26, 26, 26, 'Rent', '2026-04-26'),
    (27, 27, 27, 'Buy', '2026-04-27'),
    (28, 28, 28, 'Buy', '2026-04-28'),
    (29, 29, 29, 'Rent', '2026-04-29'),
    (30, 30, 30, 'Rent', '2026-04-30'),
    (31, 31, 31, 'Buy', '2026-05-01'),
    (32, 32, 32, 'Rent', '2026-05-02');