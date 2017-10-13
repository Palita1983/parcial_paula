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
    name varchar2(255),
    code varchar2(255),
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

    

