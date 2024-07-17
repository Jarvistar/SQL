--Deleting the student table from amdor analytics database if it already exists*/
DROP TABLE IF EXISTS public.student;

CREATE TABLE STUDENT(
	ID VARCHAR(5),
	FIRST_NAME VARCHAR(25),
	LAST_NAME VARCHAR(25),
	GENDER VARCHAR(7),
	LOCATION VARCHAR(15));

SELECT * FROM STUDENT;

SELECT FIRST_NAME FROM STUDENT;

SELECT FIRST_NAME,GENDER,LOCATION FROM STUDENT;

SELECT FIRST_NAME AS NAME FROM STUDENT;

--ADDING PHONE NUMBER COLUMN TO THE STUDENT TABLE
ALTER TABLE STUDENT ADD COLUMN PHONE_NUMBER VARCHAR(14);

--changing the data type of the id column from varchar to integer

ALTER TABLE Student Alter Column id set data type INT using id::INT;

ALTER TABLE Student Alter Column id set data type VARCHAR(5);

--deleting the phone number column 
ALTER TABLE STUDENT DROP COLUMN PHONE_NUMBER;


---RENAMING THE ID COLUMN TO STUDENT ID

ALTER TABLE STUDENT RENAME COLUMN ID TO STUDENT_ID;

--making the student_id column the primary key of the student table
ALTER TABLE Student ADD CONSTRAINT Student_pkey PRIMARY KEY (STUDENT_ID);


1, EXCEL, 37, A 
2, POWERBI

CREATE TABLE grade(
	
grade_id INT PRIMARY KEY,
COURSE_NAME VARCHAR(10),
Student_id VARCHAR(5),
Grade VARCHAR(1));

SELECT * FROM GRADE;


--making student_id in the grade table a foreign key

ALTER TABLE grade ADD CONSTRAINT grade_student_id_fkey FOREIGN KEY(student_id) REFERENCES student (student_id);


-- INSERTING VALUE INTO STUDENT TABLE

INSERT INTO STUDENT
VALUES('SA001','Sandra','Asagade','Female', 'Nigeria');

SELECT * FROM STUDENT;

SELECT  "first_name" from Student;


-- iserting multiple rows into the student table
BEGIN
INSERT INTO STUDENT (student_id,first_name,last_name,gender,location)
VALUES('BA002','Bolaji', 'Abdulsalaam', 'Male', 'United Kingdom'),
		('VD003', 'Valerie','Dogun','Female','United Kingdom'),
		('BA004', 'Bassey','Kalu','Male','Nigeria'),
		('FY005','Femi','Yusuff','Male','Nigeria' ),
		('PE006','Peter','Akpamuose','Male','Nigria');

ROLLBACK;

-- Increasing the Character limit of Location
ALTER TABLE Student Alter Column location set data type VARCHAR(20);

--Replacing Peters Location (Nigeria with Ghana)
UPDATE Student
SET LOCATION = 'Ghana'
WHERE first_name = 'Peter'




