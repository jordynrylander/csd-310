/*
    Title: create_outland_adventures_db.sql
    Date: 16 May 2026
    Description: outland adventures database initialization script.
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

-- create the Equipment table
CREATE TABLE Equipment (
    equipment_id INT NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    condition_status VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL,
    needs_inspection BOOLEAN NOT NULL DEFAULT FALSE,
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
    (6, 'Linda', 'Davis', 'linda@email.com', '1234567895');

INSERT INTO Employee (employee_id, first_name, last_name, email, role_id) VALUES
    (1, 'Jake', 'Willson', 'jake@email.com', 1),
    (2, 'Ned', 'Willson', 'ned@email.com', 1),
    (3, 'Phoenix', 'TwoStar', 'phoenix@email.com', 3),
    (4, 'June', 'Santos', 'june@email.com', 4),
    (5, 'Mads', 'Mackenzie', 'mads@email.com', 2),
    (6, 'Juan', 'Snow', 'juan@email.com', 5);

INSERT INTO Trip (trip_id, trip_name, trip_date, location, region, guide_id) VALUES
    (1, 'Safari Adventure', '2026-06-01', 'Africa', 'Africa', 1),
    (2, 'Mountain Trek', '2026-07-10', 'Asia', 'Asia', 2),
    (3, 'Beach Escape', '2026-08-15', 'Southern Europe', 'Southern Europe', 1),
    (4, 'Desert Tour', '2026-09-01', 'Africa', 'Africa', 2),
    (5, 'Forest Hike', '2026-10-05', 'Asia', 'Asia', 1),
    (6, 'Island Trip', '2026-11-20', 'Southern Europe', 'Southern Europe', 2);

INSERT INTO Booking (booking_id, customer_id, trip_id, booking_date, status) VALUES
    (1, 1, 1, '2026-05-01', 'Confirmed'),
    (2, 2, 2, '2026-05-02', 'Confirmed'),
    (3, 3, 3, '2026-05-03', 'Pending'),
    (4, 4, 4, '2026-05-04', 'Confirmed'),
    (5, 5, 5, '2026-05-05', 'Cancelled'),
    (6, 6, 6, '2026-05-06', 'Confirmed');

INSERT INTO Equipment
    (equipment_id, equipment_name, purchase_date, quantity, condition_status, status, needs_inspection)
VALUES
    (1, 'Tent', '2020-01-01', 1, 'Good', 'Available', TRUE),
    (2, 'Backpack', '2021-03-15', 1, 'Good', 'Available', FALSE),
    (3, 'Sleeping Bag', '2019-07-10', 1, 'Fair', 'In Use', TRUE),
    (4, 'Boots', '2022-05-20', 1, 'Excellent', 'Available', FALSE),
    (5, 'Jacket', '2018-11-30', 1, 'Poor', 'Repair', TRUE),
    (6, 'Helmet', '2023-02-10', 1, 'Excellent', 'Available', FALSE);

INSERT INTO Equipment_Purchase
    (purchase_id, customer_id, equipment_id, transaction_type, transaction_date)
VALUES
    (1, 1, 1, 'Buy', '2026-04-01'),
    (2, 2, 2, 'Rent', '2026-04-02'),
    (3, 3, 3, 'Buy', '2026-04-03'),
    (4, 4, 4, 'Rent', '2026-04-04'),
    (5, 5, 5, 'Buy', '2026-04-05'),
    (6, 6, 6, 'Rent', '2026-04-06');