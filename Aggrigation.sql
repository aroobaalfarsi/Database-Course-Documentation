CREATE DATABASE aggregation;
use aggregation;

CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
);

CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
); 
CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 
CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 
CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
);


-- Instructors 
select * from Instructors             -- Select (display the data in table)

INSERT INTO Instructors (InstructorID, FullName, Email, JoinDate) VALUES        -- Insert data into Instructors
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 


-- Categories 
select * from Categories

INSERT INTO Categories (CategoryID, CategoryName) VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 

-- Courses 
select * from Courses

INSERT INTO Courses (CourseID, Title, InstructorID, CategoryID, Price, PublishDate) VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 


-- Students 
select * from Students

INSERT INTO Students (StudentID, FullName, Email, JoinDate) VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 


-- Enrollments 
select * from Enrollments

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollDate, CompletionPercent, Rating) VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3); 


                                 ----------- Beginner Level  ------------------
---1- Count total number of students. 
SELECT COUNT(*) AS TotalStudents FROM Students; 
---2- Count total number of enrollments. 
SELECT count (EnrollmentID) From Enrollments;  
---3- Find average rating of each course. 
SELECT CourseID, AVG(Rating) AS AverageRating FROM Enrollments GROUP BY CourseID;
---4- Total number of courses per instructor. 
SELECT InstructorID, COUNT(*) AS TotalCourses FROM Courses GROUP BY InstructorID;
---5. Number of courses in each category. 
SELECT CategoryID, COUNT(*) AS CoursesPerCategory FROM Courses GROUP BY CategoryID;
---6. Number of students enrolled in each course. 
SELECT CourseID, COUNT(*) AS EnrolledStudents FROM Enrollments GROUP BY CourseID;
---7. Average course price per category. 
SELECT CategoryID, AVG(Price) AS AvgPrice FROM Courses GROUP BY CategoryID;
---8. Maximum course price. 
SELECT MAX(Price)FROM Courses;
---9. Min, Max, and Avg rating per course. 
SELECT CourseID, MIN(Rating) AS MinRating, MAX(Rating) AS MaxRating, AVG(Rating) AS AvgRating FROM Enrollments GROUP BY CourseID;
---10. Count how many students gave rating = 5. 
SELECT COUNT(*) FROM Enrollments WHERE Rating = 5;


                      ---------ntermediate Level---------

--1. Average completion percent per course.
SELECT CourseID, AVG(CompletionPercent) FROM Enrollments GROUP BY CourseID;
--2. Find students enrolled in more than 1 course.
SELECT StudentID, COUNT(CourseID) FROM Enrollments GROUP BY StudentID HAVING COUNT(CourseID) > 1;
--3. Calculate revenue per course (price * enrollments).
SELECT CourseID, COUNT(*) FROM Enrollments GROUP BY CourseID;
--4. List instructor name + distinct student count.
SELECT CourseID, COUNT(DISTINCT StudentID)FROM Enrollments GROUP BY CourseID;
--5. Average enrollments per category.
SELECT CategoryID, COUNT(*) FROM Courses GROUP BY CategoryID;
--6. Average course rating by instructor.
SELECT CourseID, AVG(Rating)FROM Enrollments GROUP BY CourseID;
--7. Top 3 courses by enrollment count.
SELECT CourseID, COUNT(*)FROM Enrollments GROUP BY CourseID ORDER BY COUNT(*) DESC;
--8. Average days students take to complete 100% (use mock logic).
SELECT AVG(DATEDIFF(DAY, EnrollDate, GETDATE()))FROM Enrollments WHERE CompletionPercent = 100;
--9. Percentage of students who completed each course.
SELECT CourseID, COUNT(CASE WHEN CompletionPercent = 100 THEN 1 END), COUNT(*)FROM Enrollments GROUP BY CourseID;
--10. Count courses published each year.
SELECT YEAR(PublishDate), COUNT(*)FROM Courses GROUP BY YEAR(PublishDate);