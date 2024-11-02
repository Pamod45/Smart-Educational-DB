--1.	Create tables with primary key and foreign key constraints having auto-increment sequences for one of the tables.
----------------------------------Q1--------------------------------------------
CREATE TABLE GRADE(
    gradeid NUMBER primary key,
    name VARCHAR2(50),
    description VARCHAR2(200)
);


CREATE TABLE Batch (
    batchid NUMBER PRIMARY KEY,
    gradeid NUMBER,
    startdate DATE,
    enddate DATE,
    CONSTRAINT fk_grade FOREIGN KEY (gradeid) REFERENCES Grade(gradeid)
);

CREATE TABLE Subject (
    subjectid NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    description VARCHAR2(200)
);

CREATE TABLE Teacher (
    teacherid NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    contactno VARCHAR2(20),
    address VARCHAR2(200)
);

CREATE TABLE TeachingSubjects (
    teacherid NUMBER,
    subjectid NUMBER,
    CONSTRAINT fk_teacher FOREIGN KEY (teacherid) REFERENCES Teacher(teacherid),
    CONSTRAINT fk_subject FOREIGN KEY (subjectid) REFERENCES Subject(subjectid),
    CONSTRAINT pk_teachingsubjects PRIMARY KEY (teacherid, subjectid)
);

CREATE TABLE BatchSubjects (
    batchsubjectid NUMBER PRIMARY KEY,
    batchid NUMBER,
    subjectid NUMBER,
    teacherid NUMBER,
    CONSTRAINT fk_batch FOREIGN KEY (batchid) REFERENCES Batch(batchid),
    CONSTRAINT fk_subject_batch FOREIGN KEY (subjectid) REFERENCES Subject(subjectid),
    CONSTRAINT fk_teacher_batch FOREIGN KEY (teacherid) REFERENCES Teacher(teacherid)
);

CREATE TABLE Schedule (
    schid NUMBER PRIMARY KEY,
    batchsubjectid NUMBER,
    day VARCHAR2(20),
    time TIMESTAMP,
    CONSTRAINT fk_schedule_batch_subject FOREIGN KEY (batchsubjectid) REFERENCES BatchSubjects(batchsubjectid)
);

CREATE TABLE Student (
    sid NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    contactno VARCHAR2(20),
    dob DATE,
    address VARCHAR2(200),
    batchid NUMBER,
    CONSTRAINT fk_student_batch FOREIGN KEY (batchid) REFERENCES Batch(batchid)
);

CREATE TABLE Payment (
    paymentid NUMBER PRIMARY KEY,
    sid NUMBER,
    payment_date DATE,
    amount NUMBER,
    paymentmethod VARCHAR2(50),
    CONSTRAINT fk_payment_student FOREIGN KEY (sid) REFERENCES Student(sid)
);

CREATE SEQUENCE grade_seq
    START WITH 10
    INCREMENT BY 1;

CREATE SEQUENCE batch_seq
    START WITH 100
    INCREMENT BY 1;

CREATE SEQUENCE subject_seq
    START WITH 10
    INCREMENT BY 10;
    
CREATE SEQUENCE teacher_seq
    START WITH 5
    INCREMENT BY 5;
    
CREATE SEQUENCE batch_subjects_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE schedule_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE student_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE payment_seq
    START WITH 1000
    INCREMENT BY 1;
--2.	Insert a set of matching records for the above tables.
----------------------------------Q2--------------------------------------------
--Grade table
INSERT INTO Grade (gradeid,name, description)
VALUES (grade_seq.nextval,'Grade 10','10th Grade');
INSERT INTO Grade (gradeid,name, description)
VALUES (grade_seq.nextval,'Grade 11','11th Grade');

select * from grade;

--batch table
INSERT INTO Batch (batchid,gradeid, startdate, enddate)
VALUES (batch_seq.nextval,10, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));
INSERT INTO Batch (batchid,gradeid, startdate, enddate)
VALUES (batch_seq.nextval,11, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));

select * from batch;

--Subject Table
INSERT INTO Subject (subjectid,name, description)
VALUES (subject_seq.nextval,'Mathematics', 'Mathematics');
INSERT INTO Subject (subjectid,name, description)
VALUES (subject_seq.nextval,'Science', 'Science');
INSERT INTO Subject (subjectid,name, description)
VALUES (subject_seq.nextval,'English', 'English Language');

select * from subject;

--Teacher Table
INSERT INTO Teacher (teacherid,name, contactno, address)
VALUES (teacher_seq.nextval,'Sunil Shantha', '1234567890', 'Malabe');
INSERT INTO Teacher (teacherid,name, contactno, address)
VALUES (teacher_seq.nextval,'Niaml Peiris', '564895689', 'Nugegoda');
INSERT INTO Teacher (teacherid,name, contactno, address)
VALUES (teacher_seq.nextval,'Kamal Perera', '52365895656', 'Battaramulla');

select * from teacher;

--Teaching subjects
INSERT INTO TeachingSubjects (teacherid, subjectid)
VALUES (5,20);
INSERT INTO TeachingSubjects (teacherid, subjectid)
VALUES (10,30);
INSERT INTO TeachingSubjects (teacherid, subjectid)
VALUES (15,10);

select * from teachingsubjects;

--Batch Subjects Table
INSERT INTO BatchSubjects (batchsubjectid,batchid, subjectid, teacherid)
VALUES (batch_subjects_seq.nextval,100,20,5);
INSERT INTO BatchSubjects (batchsubjectid,batchid, subjectid, teacherid)
VALUES (batch_subjects_seq.nextval,100,30,10);
INSERT INTO BatchSubjects (batchsubjectid,batchid, subjectid, teacherid)
VALUES (batch_subjects_seq.nextval,101,10,15);
INSERT INTO BatchSubjects (batchsubjectid,batchid, subjectid, teacherid)
VALUES (batch_subjects_seq.nextval,101,30,10);

select * from batchsubjects;

--Schedule Table
--Batch 100 English
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,1, 'Monday', TO_TIMESTAMP('2024-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,1, 'Monday', TO_TIMESTAMP('2024-01-08 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,1, 'Monday', TO_TIMESTAMP('2024-01-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,1, 'Monday', TO_TIMESTAMP('2024-01-22 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,1, 'Monday', TO_TIMESTAMP('2024-01-29 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from schedule where batchsubjectid=1;
--batch 100 mathematics
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,2, 'Thursday', TO_TIMESTAMP('2024-01-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,2, 'Thursday', TO_TIMESTAMP('2024-01-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,2, 'Thursday', TO_TIMESTAMP('2024-01-18 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,2, 'Thursday', TO_TIMESTAMP('2024-01-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from schedule where batchsubjectid=2;
--batch 101 science
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,3, 'Tuesday', TO_TIMESTAMP('2024-01-02 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,3, 'Tuesday', TO_TIMESTAMP('2024-01-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,3, 'Tuesday', TO_TIMESTAMP('2024-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,3, 'Tuesday', TO_TIMESTAMP('2024-01-23 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from schedule where batchsubjectid=3;
--batch101 Mathematics
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,4, 'Friday', TO_TIMESTAMP('2024-01-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,4, 'Friday', TO_TIMESTAMP('2024-01-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,4, 'Friday', TO_TIMESTAMP('2024-01-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Schedule ( schid,batchsubjectid, day, time)
VALUES (schedule_seq.nextval,4, 'Friday', TO_TIMESTAMP('2024-01-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from schedule where batchsubjectid=4;

--Student Table
INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Pamod','123456789',TO_DATE('2006-08-20', 'YYYY-MM-DD'),'Malabe',100);
INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Pubudu','526356895',TO_DATE('2006-09-21', 'YYYY-MM-DD'),'Rajagiriya',100);
INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Nuwan','256235698',TO_DATE('2006-07-12', 'YYYY-MM-DD'),'Kelaniya',100);

INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Minuwan','451234568',TO_DATE('2005-05-14', 'YYYY-MM-DD'),'Nugegoda',101);
INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Pasindu','123546758',TO_DATE('2005-11-02', 'YYYY-MM-DD'),'JaEla',101);
INSERT INTO Student (sid,name, contactno, dob, address, batchid)
VALUES (student_seq.nextval,'Ramesh','412347578',TO_DATE('2005-02-26', 'YYYY-MM-DD'),'Kiribathgoda',101);

select * from student;

--Payment Table
INSERT INTO Payment (paymentid,sid, payment_date, amount, paymentmethod)
VALUES (payment_seq.nextval,1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 6000.00, 'Cash');
INSERT INTO Payment (paymentid,sid, payment_date, amount, paymentmethod)
VALUES (payment_seq.nextval,3, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 6000.00, 'Cash');
INSERT INTO Payment (paymentid,sid, payment_date, amount, paymentmethod)
VALUES (payment_seq.nextval,6, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 8500.00, 'Cash');
--dummy insertion for the join
INSERT INTO Payment (paymentid,payment_date, amount, paymentmethod)
VALUES (payment_seq.nextval,TO_DATE('2024-01-07', 'YYYY-MM-DD'), 8500.00, 'Cash');
INSERT INTO Payment (paymentid,payment_date, amount, paymentmethod)
VALUES (payment_seq.nextval,TO_DATE('2024-01-09', 'YYYY-MM-DD'), 6000.00, 'Cash');

select * from payment;

--3.	Write any select queries each using where, group by, having, and order by.
---------------------------------Q3---------------------------------------------
--where
SELECT * from STUDENT where NAME='Pubudu';
--group by
SELECT batchid,count(*) as subject_count from BATCHSUBJECTS
GROUP BY batchid;
--having
SELECT batchid,count(*) as subject_count from BATCHSUBJECTS
GROUP BY batchid 
having COUNT(*) > 1 ;
--orderby
SELECT * from STUDENT order by name asc;

--4.	Write a single-row and multiple-row subquery using the above tables.
---------------------------------Q4---------------------------------------------

--single row sub query
SELECT NAME from teacher 
where TEACHERID=(select TEACHERID from BATCHSUBJECTS where batchid=101 and 
subjectid=(select SUBJECTID from SUBJECT where name='Mathematics') ) ;

--multi row subquery
SELECT NAME FROM STUDENT 
WHERE SID IN (SELECT SID FROM PAYMENT WHERE AMOUNT=6000.00);

--5.	Write queries using left, right, and full outer joins. 
---------------------------------Q5---------------------------------------------
--leftJoin
SELECT s.sid,s.name,p.paymentid,p.payment_date, p.amount, p.paymentmethod
from STUDENT s 
LEFT JOIN PAYMENT p
on s.sid = p.sid ;

--rightjoin
SELECT s.sid,s.name, p.paymentid, p.payment_date, p.amount, p.paymentmethod
FROM student s
RIGHT JOIN payment p ON s.sid = p.sid;

--full outer join
SELECT s.sid,s.name, p.paymentid, p.payment_date, p.amount, p.paymentmethod
FROM student s
FULL OUTER JOIN payment p ON s.sid = p.sid;

--6.	Create a view using one of the tables created.
---------------------------------Q6---------------------------------------------

CREATE VIEW Grade10StudentDetails AS
SELECT name,contactno FROM Student 
where BATCHID in (select batchid from batch where gradeid=10 );

SELECT * FROM GRADE10STUDENTDETAILS;

--7.	Write a PL/ SQL block to retrieve a record for specific input.
---------------------------------Q7---------------------------------------------
SET SERVEROUTPUT ON;
SET VERIFY OFF;
DEFINE enter_name = Ramesh;
DECLARE
    v_student_name Student.name%TYPE := '&enter_name'; 
    v_student_id Student.sid%TYPE;
    v_student_contactno Student.contactno%TYPE;
BEGIN    
    SELECT sid, contactno INTO v_student_id, v_student_contactno
    FROM Student
    WHERE name = v_student_name;

    DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id);
    DBMS_OUTPUT.PUT_LINE('Student Name: ' || v_student_name);
    DBMS_OUTPUT.PUT_LINE('Student Contact Number: ' || v_student_contactno);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found for the input student name: ' || v_student_name);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE enter_name;

--8.	Write a PL/ SQL block to update a record for specific input.
---------------------------------Q8---------------------------------------------
DEFINE enter_name2=Pamod;
DEFINE  enter_new_contact=0714565852;
DECLARE
    v_student_name Student.name%TYPE := '&enter_name2'; 
    v_new_contactno Student.contactno%TYPE := '&enter_new_contact'; 
BEGIN
    IF LENGTH(v_new_contactno) <> 10 OR NOT REGEXP_LIKE(v_new_contactno, '^\d{10}$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid contact number. Contact number must be a 10-digit number.');
    END IF;
    
    UPDATE Student
    SET contactno = v_new_contactno
    WHERE name = v_student_name;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Contact number updated successfully for student: ' || v_student_name);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found for the input student name: ' || v_student_name);
    WHEN OTHERS THEN
        IF SQLCODE = -20001 THEN
            DBMS_OUTPUT.PUT_LINE('Pleae enter 10 digit number for contact number');
        ELSE
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        END IF;
END;
/
UNDEFINE enter_name2;
UNDEFINE enter_new_contact;

select * from student;

--9.	Write a PL/ SQL block to delete a record for specific input.
---------------------------------Q9---------------------------------------------
--inserting dummy data to delete 
INSERT INTO Student (sid,name, contactno, dob, address)
VALUES (student_seq.nextval,'Saman','123456789',TO_DATE('1999-08-20', 'YYYY-MM-DD'),'Kandy');

DEFINE enter_name3=Saman;
DECLARE
    v_student_name Student.name%TYPE := '&enter_name3'; 
BEGIN
    DELETE FROM Student
    WHERE name = v_student_name;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Record deleted successfully for student: ' || v_student_name);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found for the input student name: ' || v_student_name);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE enter_name3;

select * from student;

--10.	Modify the above query to display the number of rows deleted.
---------------------------------Q10--------------------------------------------

--inserting 2times dummy data to delete 
INSERT INTO Student (sid,name, contactno, dob, address)
VALUES (student_seq.nextval,'Saman','123456789',TO_DATE('1999-08-20', 'YYYY-MM-DD'),'Kandy');
INSERT INTO Student (sid,name, contactno, dob, address)
VALUES (student_seq.nextval,'Saman','123456789',TO_DATE('1999-08-20', 'YYYY-MM-DD'),'Kandy');

DECLARE
    v_student_name Student.name%TYPE := '&enter_name3'; 
    v_rows_deleted NUMBER:=0; 
BEGIN
    
    DELETE FROM Student
    WHERE name = v_student_name
    RETURNING COUNT(*) INTO v_rows_deleted;

    
    IF v_rows_deleted > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Record(s) deleted successfully for student: ' || v_student_name);
        DBMS_OUTPUT.PUT_LINE('Number of rows deleted for student ' || v_student_name || ': ' || v_rows_deleted);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No record found for the input student name: ' || v_student_name);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE enter_name3;

select * from student;
