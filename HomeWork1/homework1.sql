-- Exercise 2:
CREATE DATABASE sms;
USE sms;

-- Create table 
CREATE TABLE Batchs (
	BatchID CHAR(6),
    Years INT Not NULL,
    Times VARCHAR(20),
    PRIMARY KEY (BatchID)
);

CREATE TABLE Students (
	StdID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BatchID CHAR(6) NOT NULL,
    Birthday DATETIME,
    Addess VARCHAR(100) DEFAULT 'Ha Noi',
    Email VARCHAR(50) UNIQUE,
    PRIMARY KEY (StdID),
    FOREIGN KEY (BatchID) REFERENCES Batchs(BatchID) 
);

CREATE TABLE Marks (
	StdID INT NOT NULL,
    Subjects VARCHAR(10) NOT NULL,
    MarkType CHAR(1),
    Mark DECIMAL(4,2),
    CONSTRAINT mark_condition CHECK (Mark >= 0 AND Mark <= 25),
    PRIMARY KEY (StdID, Subjects, MarkType),
    FOREIGN KEY (StdID) REFERENCES Students(StdID)
);

-- Delete the Primary Key and Foreign Key from tables (Only delete the content, not the columns)
ALTER TABLE Marks
DROP FOREIGN KEY Marks_ibfk_1,
DROP PRIMARY KEY;

ALTER TABLE Students
DROP FOREIGN KEY Students_ibfk_1,
MODIFY COLUMN StdID INT NOT NULL,
DROP PRIMARY KEY;

ALTER TABLE Batchs
DROP PRIMARY KEY;

-- Create a new Primary Key and Foreign Key for those tables with initial request.
ALTER TABLE Batchs
ADD PRIMARY KEY(BatchID);

ALTER TABLE Students
ADD PRIMARY KEY(StdID),
MODIFY COLUMN StdID INT NOT NULL AUTO_INCREMENT,
ADD FOREIGN KEY (BatchID) REFERENCES Batchs(BatchID);

ALTER TABLE Marks
ADD PRIMARY KEY(StdID, Subjects, MarkType),
ADD FOREIGN KEY (StdID) REFERENCES Students(StdID);

-- ADD 2 columns for table “Batchs”: ClassRoom:TINYINT and LabRoom:TINYINT
ALTER TABLE Batchs
ADD ClassRoom TINYINT,
ADD LabRoom TINYINT;

-- Add information in those columns:
-- Batchs table
INSERT INTO Batchs (BatchID, Years, Times, ClassRoom, LabRoom)
VALUES ('C0809I', 2008, '13h30-17h30', 1, 1),
('C0812I', 2008, '13h30-17h30', 2, 2),
('C0909L', 2009, '17h30-19h30', 2, 2),
('T0906G', 2009, '7h30-11h30', 1, 1),
('T0908I', 2009, '13h30-17h30', 3, 3),
('T0909G', 2009, '7h30-11h30', 2, 2);


-- Students table
INSERT INTO Students (FirstName, LastName, BatchID, Birthday, Addess, Email)
VALUES ('Nguyen Van', 'A', 'C0909L', '1987-12-3 12:00:00', 'Ha Noi', 'anv@yahoo.com'),
('Tran Thi', 'B', 'T0909G', '1988-8-13 12:00:00', 'Hai Phong', 'btt@yahoo.com'),
('Nguyen Van', 'C', 'T0909G', '1984-11-25 12:00:00', 'Nam Dinh', 'cnv@yahoo.com'),
('Le Thi', 'D', 'T0908I', '1987-6-27 12:00:00', 'Hoa Binh', 'dlt@yahoo.com'),
('Tran Van', 'E', 'T0906G', '1987-11-21 12:00:00', 'Ha Noi', 'etv@yahoo.com');

SELECT DATE_FORMAT(Birthday, "%c/%e/%Y %I:%i:%s AM") FROM Students;

-- Marks table 
INSERT INTO Marks
VALUES (1, 'CF', 'W', 12.50),
(1, 'C', 'W', 15.25),
(1, 'C', 'P', 14.00),
(2, 'CF', 'W', 14.50),
(2, 'C', 'P', 16.50),
(3, 'C', 'W', 18.00),
(3, 'C', 'P', 17.00),
(4, 'CF', 'W', 13.50),
(4, 'C', 'P', 15.50),
(5, 'C', 'W', 12.50),
(5, 'C', 'P', 17.50);
-- DELETE FROM Marks WHERE (Mark <0 OR Mark > 25);