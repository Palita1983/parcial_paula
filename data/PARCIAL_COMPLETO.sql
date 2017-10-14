CREATE TABLESPACE COURSES datafile
'courses1.dbf' size 50M,
'courses2.dbf' size 50M;

CREATE PROFILE admin 
LIMIT SESSIONS_PER_USER 2
IDLE_TIME 15 
FAILED_LOGIN_ATTEMPTS 3;

CREATE USER palita1983 identified by usuario1
DEFAULT TABLESPACE COURSES
profile admin;

GRANT DBA TO palita1983;
GRANT CONNECT, RESOURCE TO DBA;

CREATE TABLE courses
    (id int PRIMARY KEY not null,   
    code varchar2(255),
    name varchar2(255),
    date_start date,
    date_end date)
    tablespace COURSES;
    
CREATE TABLE students 
	(id int PRIMARY KEY not null,
    first_name varchar2(255),
    last_name varchar2(255),
    date_of_birth date,
    city varchar2(255),    
    adress varchar2(255))
   tablespace COURSES;

CREATE TABLE attendance 
	(id int PRIMARY KEY not null,
    student_id int,
    course_id int,
    attendance date,
    CONSTRAINT FK_student_id FOREIGN KEY (student_id) REFERENCES students(id),
    CONSTRAINT FK_course_id FOREIGN KEY(course_id) REFERENCES courses(id))
    tablespace COURSES;
   
CREATE TABLE answers 
	(id int PRIMARY KEY not null,
    number_of_question varchar2(255),
    answer varchar2(255))
    tablespace COURSES;
    
CREATE SEQUENCE answer_sequence 
START WITH 100
INCREMENT BY 2;

ALTER TABLE courses
add CONSTRAINT CK_name
CHECK (name IN ('Business and Computing', 'Computer Science', 'Chemistry', 'History','Zoology'));

ALTER TABLE answers
add CONSTRAINT CK_number_of_question
CHECK (number_of_question IN ('QUESTION 1', 'QUESTION 2', 'QUESTION 3', 'QUESTION 4', 'QUESTION 5'));

SELECT * FROM courses;
SELECT * FROM students;
SELECT * FROM attendance;
SELECT * FROM answers;

--Questions:

--Question1 - How many students have attendance to courses?
SELECT COUNT (DISTINCT ID) FROM STUDENTS;
-- Rpta = 51

--Question2 - In which course (name) the student Acton Fitzpatrick is enrolled?
SELECT NAME FROM attendance
INNER JOIN COURSES ON attendance.course_id = courses.id
INNER JOIN STUDENTS ON attendance.student_id = students.id
WHERE first_name = 'Acton' AND last_name = 'Fitzpatrick'; 
-- Rpta = Computer Sciencie

--Question3 - What is the date of the last attendence registered for the course with the 
--            code '4D6F5821-764E-86F1-FD03-08234DC5B54F' ? --(Format DD/MM/YY)
SELECT MAX(attendance) FROM attendance
INNER JOIN COURSES ON attendance.course_id = courses.id
WHERE code = '4D6F5821-764E-86F1-FD03-08234DC5B54F';
-- Rpta = 05/10/17


--Question4 - What is the name of the course which ends last?
SELECT name FROM attendance
INNER JOIN COURSES ON attendance.course_id = courses.id
WHERE ROWNUM = 1;
-- Rpta = Business and Computing

--Question5 - What is the city of the student with attendance's id = 7005
SELECT CITY FROM attendance 
INNER JOIN STUDENTS ON attendance.student_id = students.id
WHERE attendance.ID = '7005'; 
-- Rpta = 465-1758 Pellentesque Road


INSERT INTO answers VALUES(answer_sequence.nextval,'QUESTION 1','51');
INSERT INTO answers VALUES(answer_sequence.nextval,'QUESTION 2','Computer Sciencie');
INSERT INTO answers VALUES(answer_sequence.nextval,'QUESTION 3','05/10/17');
INSERT INTO answers VALUES(answer_sequence.nextval,'QUESTION 4','Business and Computing');
INSERT INTO answers VALUES(answer_sequence.nextval,'QUESTION 5','465-1758 Pellentesque Road');




    

