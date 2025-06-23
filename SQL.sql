-- Step 1: Create Database
CREATE DATABASE db;
-- Use the new database
USE db;

-- Step 2: Create Employee Table (first to handle self-referencing supervisor)
CREATE TABLE Employee (
    SSN int primary key identity(1,1),
    FirstName nvarchar(30),
    LastName nvarchar(30),
    BirthDate date,
    Gender char(1) check (Gender in ('M','F')),
    Supervise int, -- SSN
	FOREIGN KEY (Supervise) REFERENCES Employee(SSN),
    DepNumber int -- FK added later after Department table is created
	
);

-- Step 3: Create Department Table
CREATE TABLE Department (
    DepNumber int primary key identity(1,1),
    DepName nvarchar(30),
    SSN int, -- Manager SSN (FK to Employee)
    HireDate date,
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
);
-- Now add FK in Employee for DepNumber
ALTER TABLE Employee
ADD FOREIGN KEY (DepNumber) REFERENCES Department(DepNumber);

-- Step 4: Create Location Table
CREATE TABLE Location (
    DepNumber int,
    Location nvarchar(100),
    PRIMARY KEY (DepNumber, Location),
    FOREIGN KEY (DepNumber) REFERENCES Department(DepNumber)
);
-- Step 5: Create Project Table
CREATE TABLE Project (
    ProjectNumber int primary key identity(1,1),
    ProjectName nvarchar(30),
    City nvarchar(100),
    Location nvarchar(100),
    DepNumber int,
    FOREIGN KEY (DepNumber) REFERENCES Department(DepNumber)
);
-- Step 6: Create Work Table (Employee :left_right_arrow: Project)
CREATE TABLE Work (
    SSN int,
    ProjectNumber int,
    Hours int,
    PRIMARY KEY (SSN, ProjectNumber),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN),
    FOREIGN KEY (ProjectNumber) REFERENCES Project(ProjectNumber)
);
-- Step 7: Create Dependent Table
CREATE TABLE Dependent (
    DependentName nvarchar(30) PRIMARY KEY,
	SSN int,
	BD date,
    Gender char(1) check (Gender in ('M','F')),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
);


-- Department
select * from Department

INSERT INTO Department (DepName, SSN, HireDate) VALUES
('IT', NULL, '2020-01-10'),
('HR', NULL, '2021-05-01'),
('Finance', NULL, '2022-07-15'),
('Marketing', NULL, '2021-09-01'),
('Logistics', NULL, '2023-01-05');

-- Employee
select * from Employee

INSERT INTO Employee (FirstName, LastName, BirthDate, Gender, Supervise, DepNumber) VALUES
('Ali', 'Salim', '1988-05-12', 'M', NULL, 1),
('Mona', 'Saeed', '1990-11-25', 'F', 1, 2),
('Omar', 'Nasser', '1995-02-15', 'M', 1, 3),
('Sara', 'Yahya', '1992-08-10', 'F', 2, 4),
('Khalid', 'Fahad', '1985-04-20', 'M', 3, 5);

UPDATE Employee SET DepNumber = 2 WHERE SSN = 4;        ----------- UPDATE 


-- Location
select * from Location

INSERT INTO Location (DepNumber, Location) VALUES
(1, 'Muscat'),
(2, 'Salalah'),
(3, 'Nizwa'),
(4, 'Sohar'),
(5, 'Barka');


DELETE FROM Location WHERE DepNumber = 1;                   ------- DELETE ROW 

-- Project
select * from Project

INSERT INTO Project (ProjectName, City, Location, DepNumber) VALUES
('Website Revamp', 'Muscat', 'Muscat', 1),
('HR Portal', 'Salalah', 'Salalah', 2),
('Budget Tracker', 'Nizwa', 'Nizwa', 3),
('Marketing Campaign', 'Sohar', 'Sohar', 4),
('Fleet Optimization', 'Barka', 'Barka', 5);

-- ProjectNumber FK in work table, delete ProjectNumber from work table first 
DELETE FROM Work WHERE ProjectNumber = 4;

-- Then removed from the employee table:
DELETE FROM Project WHERE ProjectNumber = 4;

UPDATE Project SET ProjectName = 'HR System Upgrade' WHERE ProjectNumber = 2;   --------- UPDATE


-- Work
select * from Work

INSERT INTO Work (ProjectNumber, SSN, Hours) VALUES
(1, 1, 4.0),
(2, 2, 6.0),
(3, 3, 5.5),
(4, 4, 4.75),
(5, 5, 3.5);

UPDATE work SET Hours = 9.0 WHERE ProjectNumber = 2;

-- Dependent
select * from Dependent

INSERT INTO Dependent (DependentName,SSN, BD, Gender) VALUES
('Sara', 1, '2015-06-01', 'F'),
('Yousef', 2, '2010-09-20', 'M'),
('Rania', 3, '2017-03-12', 'F'),
('Omar Jr.', 4, '2016-08-08', 'M'),
('Lina', 5, '2014-11-03', 'F');

