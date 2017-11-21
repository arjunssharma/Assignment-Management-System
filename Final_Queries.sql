drop PROCEDURE SELECT_PROFESSOR_OPTIONS;
drop PROCEDURE INSERT_QUESTION_AND_RETURN_ID;
drop PROCEDURE INSERT_EXERCISE_AND_RETURN_ID;
drop PROCEDURE INSERT_AS_AND_RETURN_ID;
drop sequence ATTEMPT_SUBMISSION_SEQ;
drop sequence Question_SEQ;
drop sequence EXERCISE_SEQ;
drop trigger enterTARole;
drop trigger delenterTARole;
 drop trigger ATTEMPT_SUBMISSION_PK_Trigger;
 drop trigger EXERCISE_PK_Trigger;
 drop trigger Question_PK_Trigger;
drop trigger check_is_grad;
drop trigger check_not_TA;
drop trigger Points_Scoring_Policy;
drop trigger Average_Difficulty_Level;
drop trigger check_TA_is_enrolled;
 
drop table adaptive_exercise_topic;
drop table TA;
drop table COURSE_STUDENT;
drop table SUBMISSION_RESULT;---
drop table ATTEMPT_SUBMISSION;
drop table QUESTION_PARAM_ANSWERS;--
drop table ANSWER;
drop table PARAMETER;
drop table QUESTION_BANK;
drop table EXERCISE_QUESTION;
drop table QUESTION;
drop table exercise;
Drop table COURSE_topic;
Drop table topic;
Drop table COURSE;
Drop table student;
Drop table professor;
drop table ROLE;
drop table MENU_OPTIONS;



CREATE TABLE MENU_OPTIONS 
(
  ROLE VARCHAR(1) NOT NULL 
  , MENU_NAME VARCHAR(100) NOT NULL
, COL_NAME VARCHAR(100) NOT NULL 
 , DISPLAY_ORDER NUMBER NOT NULL 
 , SHOWN_ALWAYS NUMBER NOT NULL
, CONSTRAINT MENU_OPTIONS_PK PRIMARY KEY 
  (
    ROLE 
  , COL_NAME 
  , MENU_NAME 
  )
);



-----------------------------------------------------------------------------
CREATE TABLE ROLE 
(
  USER_ID VARCHAR(20) NOT NULL 
, ROLE VARCHAR(5) NOT NULL 
, PASSWORD VARCHAR(20) NOT NULL 
, CONSTRAINT ROLE_PK PRIMARY KEY 
  (
    USER_ID ,
    ROLE
  
  )
   
);



-----------------------------------------------------------------------------
CREATE TABLE STUDENT 
(
  STUDENT_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) NOT NULL 
, IS_GRAD NUMBER NOT NULL 
, CONSTRAINT STUDENT_PK PRIMARY KEY 
  (
    STUDENT_ID 
  )
  
);



-----------------------------------------------------------------------------
CREATE TABLE PROFESSOR 
(
  PROFESSOR_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) NOT NULL 
, CONSTRAINT PROFESSOR_PK PRIMARY KEY 
  (
    PROFESSOR_ID 
  )   
);



-----------------------------------------------------------------------------
CREATE TABLE COURSE 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, COURSE_NAME VARCHAR(100) NOT NULL 
, START_DATE DATE NOT NULL 
, END_DATE DATE NOT NULL 
, PROFESSOR_ID VARCHAR(20) 
, CONSTRAINT COURSE_PK PRIMARY KEY 
  (
    COURSE_ID 
  )
,CONSTRAINT COURSE_FK1 FOREIGN KEY
(
  PROFESSOR_ID 
)
REFERENCES PROFESSOR
(
  PROFESSOR_ID 
)
ON DELETE SET NULL
   
);



-----------------------------------------------------------------------------
CREATE TABLE TOPIC 
(
  TOPIC_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(200) NOT NULL 
, CONSTRAINT TOPIC_PK PRIMARY KEY 
  (
    TOPIC_ID 
  )
   
);



-----------------------------------------------------------------------------
CREATE TABLE COURSE_TOPIC 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, TOPIC_ID VARCHAR(20) NOT NULL 
, CONSTRAINT COURSE_TOPIC_PK PRIMARY KEY 
  (
    COURSE_ID 
  , TOPIC_ID 
  )
,CONSTRAINT COURSE_TOPIC_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE 
,CONSTRAINT COURSE_TOPIC_FK2 FOREIGN KEY
(
  TOPIC_ID 
)
REFERENCES TOPIC
(
  TOPIC_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------
CREATE SEQUENCE  EXERCISE_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;




-----------------------------------------------------------------------------
CREATE TABLE EXERCISE 
(
 EXERCISE_ID NUMBER NOT NULL 
, COURSE_ID VARCHAR(20) NOT NULL 
, NAME VARCHAR(100) 
, DEADLINE DATE 
, TOTAL_QUESTIONS NUMBER
, CURRENT_QUESTION_COUNT NUMBER DEFAULT 0
, RETRIES NUMBER 
, START_DATE DATE 
, END_DATE DATE 
, POINTS NUMBER 
, PENALTY NUMBER 
, SCORING_POLICY VARCHAR(20) 
, SC_MODE VARCHAR(20)
, DIFFICULTY_LEVEL NUMBER DEFAULT 0
, CONSTRAINT EXERCISE_PK PRIMARY KEY 
  (
    EXERCISE_ID 
  )
  ,CONSTRAINT EXERCISE_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE SET NULL
   
);



-----------------------------------------------------------------------------
CREATE SEQUENCE  QUESTION_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;

-----------------------------------------------------------------------------
CREATE TABLE QUESTION 
(
  QUESTION_ID NUMBER NOT NULL 
, QUESTION_TEXT VARCHAR(500) NOT NULL 
, DIFFICULTY_LEVEL NUMBER NOT NULL 
, HINT VARCHAR(200) 
, EXPLANATION VARCHAR(200) 
, QUESTION_TYPE VARCHAR(20) 
, TOPIC_ID VARCHAR(20) 
, CONSTRAINT QUESTION_PK PRIMARY KEY 
  (
    QUESTION_ID 
  )
  ,CONSTRAINT QUESTION_FK1 FOREIGN KEY
(
  TOPIC_ID 
)
REFERENCES TOPIC
(
  TOPIC_ID 
)
ON DELETE SET NULL
,CONSTRAINT QUESTION_CHK1 CHECK 
(difficulty_level >=1 and difficulty_level <=6 )
);



-----------------------------------------------------------------------------
CREATE TABLE EXERCISE_QUESTION 
(
  EXERCISE_ID NUMBER NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, CONSTRAINT EXERCISE_QUESTION_PK PRIMARY KEY 
  (
    EXERCISE_ID 
  , QUESTION_ID 
  )
  ,CONSTRAINT EXERCISE_QUESTION_FK1 FOREIGN KEY
(
  EXERCISE_ID 
)
REFERENCES EXERCISE
(
  EXERCISE_ID 
),CONSTRAINT EXERCISE_QUESTION_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE 
   );



-----------------------------------------------------------------------------
CREATE TABLE QUESTION_BANK 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, CONSTRAINT QUESTION_BANK_PK PRIMARY KEY 
  (
    COURSE_ID 
  , QUESTION_ID 
  )
  ,CONSTRAINT QUESTION_BANK_FK1 FOREIGN KEY
(
COURSE_ID
  )
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE 
,CONSTRAINT QUESTION_BANK_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
   
);



-----------------------------------------------------------------------------
CREATE TABLE PARAMETER 
(
  PARAM_ID VARCHAR(20) NOT NULL 
, VALUE VARCHAR(100) 
, CONSTRAINT PARAMETER_PK PRIMARY KEY 
  (
    PARAM_ID 
  )
   
);



-----------------------------------------------------------------------------
CREATE TABLE ANSWER 
(
  ANSWER_ID VARCHAR(20) NOT NULL 
, VALUE VARCHAR(100) 
, CONSTRAINT ANSWER_PK PRIMARY KEY 
  (
    ANSWER_ID 
  )
   
);



-----------------------------------------------------------------------------
CREATE TABLE QUESTION_PARAM_ANSWERS 
(
  QUESTION_ID NUMBER NOT NULL 
, QUESTION VARCHAR(200) NOT NULL 
, ANSWER VARCHAR(200) NOT NULL 
, CORRECT NUMBER
,EXPLANATION VARCHAR(200)
, CONSTRAINT QUESTION_PARAM_ANSWERS_PK PRIMARY KEY 
  (
    QUESTION_ID 
  , QUESTION 
  , ANSWER 
  )
  , CONSTRAINT QUESTION_PARAM_ANSWERS_FK1 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------
CREATE SEQUENCE  ATTEMPT_SUBMISSION_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 ;


-----------------------------------------------------------------------------
CREATE TABLE ATTEMPT_SUBMISSION 
(
  ATTEMPT_ID NUMBER NOT NULL  
, EXERCISE_ID NUMBER NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, SUBMISSION_TIME TIMESTAMP 
, POINTS NUMBER 
, NUMBER_OF_ATTEMPTS NUMBER
, SCORE NUMBER
, CONSTRAINT ATTEMPT_SUBMISSION_PK PRIMARY KEY 
  (
  ATTEMPT_ID
  )
  ,CONSTRAINT ATTEMPT_SUBMISSION_FK1 FOREIGN KEY
(
  EXERCISE_ID 
)
REFERENCES EXERCISE
(
  EXERCISE_ID 
)

,CONSTRAINT ATTEMPT_SUBMISSION_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)
);



-----------------------------------------------------------------------------
CREATE TABLE SUBMISSION_RESULT 
(
  ATTEMPT_ID NUMBER NOT NULL 
, QUESTION_ID NUMBER NOT NULL 
, QUESTION VARCHAR(200) NOT NULL 
, ANSWER VARCHAR(200) 
, CORRECT NUMBER 
, CONSTRAINT SUBMISSION_RESULT_PK PRIMARY KEY 
  (
    ATTEMPT_ID 
  , QUESTION_ID 
  , QUESTION
  )
  ,CONSTRAINT SUBMISSION_RESULT_FK1 FOREIGN KEY
(
  ATTEMPT_ID 
)
REFERENCES ATTEMPT_SUBMISSION
(
  ATTEMPT_ID 
)
ON DELETE CASCADE
, CONSTRAINT SUBMISSION_RESULT_FK2 FOREIGN KEY
(
  QUESTION_ID 
)
REFERENCES QUESTION
(
  QUESTION_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------
CREATE TABLE COURSE_STUDENT 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, CONSTRAINT COURSE_STUDENT_PK PRIMARY KEY 
  (
    COURSE_ID 
  , STUDENT_ID 
  )
  ,CONSTRAINT COURSE_STUDENT_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE
, CONSTRAINT COURSE_STUDENT_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------
CREATE TABLE TA 
(
  COURSE_ID VARCHAR(20) NOT NULL 
, STUDENT_ID VARCHAR(20) NOT NULL 
, CONSTRAINT TA_PK PRIMARY KEY 
  (
    COURSE_ID 
  , STUDENT_ID 
  )
  , CONSTRAINT TA_FK1 FOREIGN KEY
(
  COURSE_ID 
)
REFERENCES COURSE
(
  COURSE_ID 
)
ON DELETE CASCADE

,CONSTRAINT TA_FK2 FOREIGN KEY
(
  STUDENT_ID 
)
REFERENCES STUDENT
(
  STUDENT_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------
CREATE TABLE ADAPTIVE_EXERCISE_TOPIC 
(
  EXERCISE_ID NUMBER NOT NULL 
, TOPIC_ID VARCHAR(20) NOT NULL 
, CONSTRAINT ADAPTIVE_EXERCISE_TOPIC_PK PRIMARY KEY 
  (
    EXERCISE_ID 
  , TOPIC_ID 
  )
  , CONSTRAINT ADAPTIVE_EXERCISE_TOPIC_FK1 FOREIGN KEY
(
  EXERCISE_ID 
)
REFERENCES EXERCISE
(
  EXERCISE_ID 
)
ON DELETE CASCADE
,CONSTRAINT ADAPTIVE_EXERCISE_TOPIC_FK2 FOREIGN KEY
(
  TOPIC_ID 
)
REFERENCES TOPIC
(
  TOPIC_ID 
)
ON DELETE CASCADE
);



-----------------------------------------------------------------------------




CREATE OR REPLACE TRIGGER EXERCISE_PK_Trigger 
   before insert on  EXERCISE
   for each row 
begin  
   if inserting then 
      if :NEW.EXERCISE_ID is null then 
         select EXERCISE_SEQ.nextval into :NEW.EXERCISE_ID from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER EXERCISE_PK_Trigger ENABLE;






----------------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER Question_PK_Trigger 
   before insert on  Question
   for each row 
begin  
   if inserting then 
      if :NEW.QUESTION_ID is null then 
         select QUESTION_SEQ.nextval into :NEW.QUESTION_ID from dual; 
      end if; 
   end if; 
end;
/ 
ALTER TRIGGER Question_PK_Trigger ENABLE;








----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER ATTEMPT_SUBMISSION_PK_Trigger 
   before insert on  ATTEMPT_SUBMISSION
   for each row 
begin  
   if inserting then 
      if :NEW.ATTEMPT_ID is null then 
         select ATTEMPT_SUBMISSION_SEQ.nextval into :NEW.ATTEMPT_ID from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER ATTEMPT_SUBMISSION_PK_Trigger ENABLE;




---------------------------------------------------------------------
CREATE OR REPLACE TRIGGER check_is_grad
  BEFORE INSERT OR UPDATE ON TA
  FOR EACH ROW
DECLARE
  isGrad number;
BEGIN
select is_grad into isGrad from student s where s.STUDENT_ID = :NEW.STUDENT_ID and rownum = 1;
if ( isGrad <> 1)
--if ( :NEW.STUDENT_ID >= 1)
then 
Raise_Application_Error(-20000, 'Undergrads cannot be TA');
--insert into tp values(1);
END IF;
END;
/ 
ALTER TRIGGER check_is_grad Enable;
-------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER enterTARole
  AFTER INSERT ON TA
  FOR EACH ROW
DECLARE
  pwd VARCHAR(50);
BEGIN
select password into pwd from role where user_id = :NEW.STUDENT_ID and role = 's';
insert into role values (:NEW.STUDENT_ID,'t',pwd);
END;
/ 
ALTER TRIGGER enterTARole Enable;

-----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER delenterTARole
  AFTER DELETE ON TA
  FOR EACH ROW
DECLARE
  pwd VARCHAR(50);
BEGIN
delete from role where user_id = :OLD.STUDENT_ID and role = 't' and rownum = 1;
END;
/ 
ALTER TRIGGER delenterTARole Enable;



----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER check_TA_is_enrolled
  BEFORE INSERT OR UPDATE ON TA
  FOR EACH ROW
DECLARE
  isGrad number;
BEGIN
select count(*) into isGrad from COURSE_STUDENT cs where cs.STUDENT_ID = :NEW.STUDENT_ID and cs.COURSE_ID = :NEW.COURSE_ID and rownum = 1;
if ( isGrad <> 0)
--if ( :NEW.STUDENT_ID >= 1)
then 
Raise_Application_Error(-20000, 'TA cannot be enrolled as a Student');
--insert into tp values(1);
END IF;
END;
/
ALTER TRIGGER check_TA_is_enrolled ENABLE;



----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER check_not_TA
  BEFORE INSERT OR UPDATE ON course_student
  FOR EACH ROW
DECLARE
  isGrad number;
BEGIN
select count(*) into isGrad from TA cs where cs.STUDENT_ID = :NEW.STUDENT_ID and cs.COURSE_ID = :NEW.COURSE_ID and rownum = 1;
if ( isGrad <> 0)
--if ( :NEW.STUDENT_ID >= 1)
then 
Raise_Application_Error(-20000, 'TA cannot be enrolled as a Student');
--insert into tp values(1);
END IF;
END;
/
ALTER TRIGGER check_not_TA ENABLE;



----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Average_Difficulty_Level 
AFTER  INSERT ON EXERCISE_QUESTION 
FOR EACH ROW
DECLARE
init_average number;
init_count number;
new_difficulty number;
BEGIN
  Select CURRENT_QUESTION_COUNT into init_count from EXERCISE where EXERCISE_ID = :NEW.EXERCISE_ID;
  Select  DIFFICULTY_LEVEL into init_average from EXERCISE where EXERCISE_ID = :NEW.EXERCISE_ID;
  Select DIFFICULTY_LEVEL into new_difficulty from QUESTION where QUESTION_ID = :NEW.QUESTION_ID;
  UPDATE EXERCISE SET DIFFICULTY_LEVEL = (((init_average * init_count) + new_difficulty)/(init_count + 1))  WHERE EXERCISE_ID =:NEW.EXERCISE_ID;
  UPDATE EXERCISE SET CURRENT_QUESTION_COUNT = (CURRENT_QUESTION_COUNT + 1) where  EXERCISE_ID =:NEW.EXERCISE_ID;
END;
/

ALTER TRIGGER Average_Difficulty_Level enable;

CREATE OR REPLACE TRIGGER Average_Difficulty_Level_Del 
AFTER  DELETE ON EXERCISE_QUESTION 
FOR EACH ROW
DECLARE
init_average number;
init_count number;
new_difficulty number;
BEGIN
  Select CURRENT_QUESTION_COUNT into init_count from EXERCISE where EXERCISE_ID = :OLD.EXERCISE_ID;
  Select  DIFFICULTY_LEVEL into init_average from EXERCISE where EXERCISE_ID = :OLD.EXERCISE_ID;
  Select DIFFICULTY_LEVEL into new_difficulty from QUESTION where QUESTION_ID = :OLD.QUESTION_ID;
  UPDATE EXERCISE SET DIFFICULTY_LEVEL = (((init_average * init_count) - new_difficulty)/(init_count - 1))  WHERE EXERCISE_ID =:OLD.EXERCISE_ID;
  UPDATE EXERCISE SET CURRENT_QUESTION_COUNT = (CURRENT_QUESTION_COUNT - 1) where  EXERCISE_ID =:OLD.EXERCISE_ID;
END;
/

ALTER TRIGGER Average_Difficulty_Level_Del enable;


--------------------------------------------------------------------------

create or replace TRIGGER Points_Scoring_Policy
BEFORE INSERT ON ATTEMPT_SUBMISSION 
--AFTER INSERT ON ATTEMPT_SUBMISSION
FOR EACH ROW
DECLARE
does_exist varchar(3);
points number;
policy VARCHAR(20);
no_of_attempts number;
BEGIN
  --SELECT count(*)  into countcheck from  ATTEMPT_SUBMISSION where EXERCISE_ID = :NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID;
  select 
  case when exists(select 1 from ATTEMPT_SUBMISSION where EXERCISE_ID =:NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID)
  then 'y'
  else
  'n'
  end
  into does_exist from COURSE where ROWNUM=1;
  if does_exist = 'n'
  then :NEW.SCORE := :NEW.POINTS;
  else
  Select SCORING_POLICY into policy from EXERCISE where EXERCISE_ID = :NEW.EXERCISE_ID;
  If(policy = 'MAX') then
  SELECT 
   max(POINTS)
    into points FROM ATTEMPT_SUBMISSION where EXERCISE_ID = :NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID GROUP BY EXERCISE_ID,STUDENT_ID;
  if points < :NEW.points
  then :NEW.score := :NEW.points;
  end if;
  end if;
  If(policy = 'AverageScore') then
  SELECT 
   avg(POINTS)
    into points FROM ATTEMPT_SUBMISSION where EXERCISE_ID = :NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID GROUP BY EXERCISE_ID,STUDENT_ID;
  select 
  MAX(NUMBER_OF_ATTEMPTS)
  into no_of_attempts from ATTEMPT_SUBMISSION where EXERCISE_ID = :NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID;
  :NEW.score := ((points * no_of_attempts) + :NEW.POINTS)/(no_of_attempts + 1);
  end if;
  If(policy = 'LatestAttempt') then
  --SELECT POINTS into points FROM ATTEMPT_SUBMISSION where EXERCISE_ID = :NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID ORDER BY ATTEMPT_ID DESC;
  :NEW.score := :NEW.POINTS;
  end if;
  end if;
  --UPDATE ATTEMPT_SUBMISSION SET SCORE = points  WHERE EXERCISE_ID =:NEW.EXERCISE_ID AND STUDENT_ID= :NEW.STUDENT_ID;
END;
 /

ALTER TRIGGER Points_Scoring_Policy enable;



----------------------------------------------------------------------------------------
CREATE or REPLACE PROCEDURE SELECT_PROFESSOR_OPTIONS(c_id IN VARCHAR, p_id IN VARCHAR, menuname IN VARCHAR ,prc OUT sys_refcursor) 
As
prof_id VARCHAR(20);
begin
   select PROFESSOR_ID into prof_id from course  where course_id = c_id and rownum = 1;
   if (prof_id  <> p_id)
   then
  open prc for select col_name from MENU_OPTIONS where role = 'P' and menu_name = menuname and shown_always = 1 order by DISPLAY_ORDER;
  else
  open prc for select col_name from MENU_OPTIONS where role = 'P' and menu_name = menuname order by DISPLAY_ORDER;
  end if;
end ;
/



-----Insert question and return ID-------------------------------------------------------
CREATE OR REPLACE PROCEDURE INSERT_QUESTION_AND_RETURN_ID(q_type IN VARCHAR, q_text IN VARCHAR, topic_id IN VARCHAR, dl IN NUMBER, hint IN VARCHAR, exp IN VARCHAR, prc OUT sys_refcursor)
AS
ret_id number;
begin
insert into QUESTION (QUESTION_TEXT,QUESTION_TYPE, TOPIC_ID, DIFFICULTY_LEVEL, HINT, EXPLANATION) values (q_text,q_type,topic_id,dl,hint,exp) returning QUESTION_ID into ret_id;
open prc for select ret_id as ret_id from QUESTION where rownum = 1;
end;
/


----------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE INSERT_EXERCISE_AND_RETURN_ID(COURSE_ID IN VARCHAR, NAME IN VARCHAR, DEADLINE IN VARCHAR ,TOTAL_QUESTIONS IN NUMBER,RETRIES IN NUMBER,START_DATE IN VARCHAR,END_DATE IN VARCHAR,POINTS IN NUMBER,PENALTY IN NUMBER,SCORING_POLICY IN VARCHAR,SC_MODE IN VARCHAR,prc OUT sys_refcursor)
AS
ret_id number;
begin
insert into EXERCISE (COURSE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES, START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE ) values (COURSE_ID, NAME,TO_DATE(DEADLINE, 'MM/DD/YYYY'), TOTAL_QUESTIONS,RETRIES,TO_DATE(START_DATE, 'MM/DD/YYYY'), TO_DATE(END_DATE, 'MM/DD/YYYY'), POINTS, PENALTY, SCORING_POLICY, SC_MODE ) returning EXERCISE_ID into ret_id;
open prc for select ret_id as ret_id from EXERCISE where rownum = 1;
end;
/
----------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE INSERT_AS_AND_RETURN_ID(exid IN NUMBER, username IN VARCHAR, dt IN VARCHAR ,totalpoints IN NUMBER,attemptno IN NUMBER,prc OUT sys_refcursor)
AS
ret_id number;
begin
insert into ATTEMPT_SUBMISSION (EXERCISE_ID, STUDENT_ID, SUBMISSION_TIME, POINTS, NUMBER_OF_ATTEMPTS ) values (exid, username,TO_DATE(dt, 'MM/DD/YYYY'), totalpoints,attemptno ) returning ATTEMPT_ID into ret_id;
open prc for select ret_id as ret_id from ATTEMPT_SUBMISSION where rownum = 1;
end;
/
----------------------------------------

CREATE OR REPLACE PROCEDURE RETURN_REPORT(COURSEID IN VARCHAR,prc OUT sys_refcursor)
AS
begin
open prc for 
select es.e_id as Ex, es.s_id as St, es.sname as Nm, es.ename as eNm,
case when asu.score is null then 0 else asu.score end as score from
(select e.EXERCISE_ID as e_id,e.NAME as ename ,cs.STUDENT_ID as s_id, s.name as sname
from 
EXERCISE e, COURSE_STUDENT cs, STUDENT s
where e.COURSE_ID = cs.COURSE_ID
and cs.STUDENT_ID = s.STUDENT_ID
and e.COURSE_ID = COURSEID
) es
left join ATTEMPT_SUBMISSION asu on (asu.EXERCISE_ID = es.e_id and asu.STUDENT_ID = es.s_id)
where asu.NUMBER_OF_ATTEMPTS is null or asu.NUMBER_OF_ATTEMPTS = (select max(asu2.NUMBER_OF_ATTEMPTS) from ATTEMPT_SUBMISSION asu2 where asu2.EXERCISE_ID =es.e_id and asu2.STUDENT_ID = es.s_id )
order by Ex, St;
end;
/

-------------------------------
insert into MENU_OPTIONS values ('P','Home','View Profile',1,1);
insert into MENU_OPTIONS values ('P','Home','View/Add Courses',2,1);
insert into MENU_OPTIONS values ('P','Home','Enroll/Drop A Student',3,1);
insert into MENU_OPTIONS values ('P','Home','Search/Add questions to Question Bank',4,1);
insert into MENU_OPTIONS values ('P','Home','Logout',5,1);
insert into MENU_OPTIONS values ('T','Home','View Profile',1,1);
insert into MENU_OPTIONS values ('T','Home','View/Add Courses',2,1);
insert into MENU_OPTIONS values ('T','Home','Enroll/Drop A Student',3,1);
insert into MENU_OPTIONS values ('T','Home','Logout',4,1);
insert into MENU_OPTIONS values ('S','Home','View/Edit Profile',1,1);
insert into MENU_OPTIONS values ('S','Home','View Courses',2,1);
insert into MENU_OPTIONS values ('S','Home','Logout',3,1);
insert into MENU_OPTIONS values ('S','Profile','Student ID',1,1);
insert into MENU_OPTIONS values ('T','Profile','Employee ID',1,1);
insert into MENU_OPTIONS values ('P','Profile','Employee ID',1,1);
insert into MENU_OPTIONS values ('P','View Course','Course Name',1,1);
insert into MENU_OPTIONS values ('P','View Course','Start Date',2,1);
insert into MENU_OPTIONS values ('P','View Course','End Date',3,1);
insert into MENU_OPTIONS values ('P','View Course','View Exercise',4,1);
insert into MENU_OPTIONS values ('P','View Course','ADD Exercise',5,0);
insert into MENU_OPTIONS values ('P','View Course','View TA',6,1);
insert into MENU_OPTIONS values ('P','View Course','Add TA',7,0);
insert into MENU_OPTIONS values ('P','View Course','Enroll/Drop Student',8,0);
insert into MENU_OPTIONS values ('P','View Course','View Report',9,0);
--viewSpecificExercise
insert into MENU_OPTIONS values ('P','viewSpecificExercise','DELETE QUESTION',2,0);
insert into MENU_OPTIONS values ('P','viewSpecificExercise','ADD QUESTION',1,0);



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into ROLE values ('tregan','s','tregan');
insert into ROLE values ('jmick','s','jmick');
insert into ROLE values ('mfisher','s','mfisher');
insert into ROLE values ('jander','s','jander');
insert into ROLE values ('jharla','s','jharla');
insert into ROLE values ('aneela','s','aneela');
insert into ROLE values ('mjones','s','mjones');
insert into ROLE values ('jmoyer','s','jmoye');
insert into ROLE values ('kogan','p','kogan');
insert into ROLE values ('rchirkova','p','rchirkova');
insert into ROLE values ('chealey','p','chealey');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into STUDENT values ('tregan','Tom Regan',0);
insert into STUDENT values ('jmick','Jenelle Mick',1);
insert into STUDENT values ('mfisher','Michal Fisher',0);
insert into STUDENT values ('jander','Joseph Anderson',0);
insert into STUDENT values ('jharla','Jitendra Harlalka',1);
insert into STUDENT values ('aneela','Aishwarya Neelakantan',1);
insert into STUDENT values ('mjones','Mary Jones',1);
insert into STUDENT values ('jmoyer','James Moyer',1);



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into PROFESSOR values ('kogan','Kemafor Ogan');
insert into PROFESSOR values ('rchirkova','Rada Chirkova');
insert into PROFESSOR values ('chealey','Christipher Healey');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into COURSE values ('CSC440','Database Systems',TO_DATE('08/27/2017', 'MM/DD/YYYY'),TO_DATE('12/12/2017', 'MM/DD/YYYY'), 'rchirkova');
insert into COURSE values ('CSC540','Database Systems',TO_DATE('09/27/2017', 'MM/DD/YYYY'),TO_DATE('12/10/2017', 'MM/DD/YYYY'), 'kogan');
insert into COURSE values ('CSC541','Advanced Data Structures',TO_DATE('09/25/2017', 'MM/DD/YYYY'),TO_DATE('12/06/2017', 'MM/DD/YYYY'), 'chealey');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into COURSE_STUDENT values ('CSC440','tregan');
insert into COURSE_STUDENT values ('CSC440','mfisher');
insert into COURSE_STUDENT values ('CSC440','jander');
insert into COURSE_STUDENT values ('CSC540','aneela');
insert into COURSE_STUDENT values ('CSC540','mjones');
insert into COURSE_STUDENT values ('CSC540','jmick');
insert into COURSE_STUDENT values ('CSC541','aneela');
insert into COURSE_STUDENT values ('CSC541','mjones');
insert into COURSE_STUDENT values ('CSC541','jmick');

---------------------------------------------------------------------------------------
insert into TOPIC values ('01','ER Model');
insert into TOPIC values ('02','SQL');
insert into TOPIC values ('03','Storing Data:Disks and Files');
insert into TOPIC values ('04','Primary File Organization');
insert into TOPIC values ('05','Hashing Techniques');
insert into TOPIC values ('06','Binary Tree Structures');
insert into TOPIC values ('07','AVL Trees');
insert into TOPIC values ('08','Sequential File Organization');
insert into TOPIC values ('09','BinarySearch');
insert into TOPIC values ('10','Interpolation Search');

----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into COURSE_TOPIC values ('CSC440','04');
insert into COURSE_TOPIC values ('CSC440','06');
insert into COURSE_TOPIC values ('CSC540','01');
insert into COURSE_TOPIC values ('CSC540','03');
insert into COURSE_TOPIC values ('CSC540','04');
insert into COURSE_TOPIC values ('CSC540','06');
insert into COURSE_TOPIC values ('CSC541','04');
insert into COURSE_TOPIC values ('CSC541','06');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into TA values ('CSC440','aneela');
insert into TA values ('CSC440','jmick');
insert into TA values ('CSC540','jharla');
insert into TA values ('CSC541','jmoyer');



----------------------------------------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into QUESTION values (1,'Question 1',2,'Hint text Q1','detailed Explanation Q1','f','01');
insert into QUESTION values (2,'Question 2',3,'Hint text Q2','detailed Explanation Q2','f','01');
insert into QUESTION values (3,'Consider a disk with a sector size: <sector size>,tracks per surface: <tracks per surface>, sectors per track: <sectors per track>,double sided platters: <double sided platters>, average seek time: <average seek time>. What is the capacity of a track in bytes?',2,'Hint text Q3','detailed Explanation Q3','p','01');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into QUESTION_BANK values ('CSC540',1);
insert into QUESTION_BANK values ('CSC540',2);
insert into QUESTION_BANK values ('CSC540',3);



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Correct Ans 1',1, '');
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Correct Ans 2',1, '');
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Incorrect Ans 3',0, 'short explanation 3');
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Incorrect Ans 4',0, 'short explanation 4');
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Incorrect Ans 5',0, 'short explanation 5');
insert into QUESTION_PARAM_ANSWERS values ('1','Question 1', 'Incorrect Ans 6',0, 'short explanation 6');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Correct Ans 1',1, '');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Correct Ans 2',1, '');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Correct Ans 3',1, '');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Incorrect Ans 4',0, 'short explanation 4');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Incorrect Ans 5',0, 'short explanation 5');
insert into QUESTION_PARAM_ANSWERS values ('2','Question 2', 'Incorrect Ans 6',0, 'short explanation 6');

insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Correct Ans 1v1',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Correct Ans 2v1',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Correct Ans 3v1',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Incorrect Ans 4v1',0, 'short explanation 4');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Incorrect Ans 5v1',0, 'short explanation 5');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Incorrect Ans 6v1',0, 'short explanation 6');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Incorrect Ans 7v1',0, 'short explanation 7');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 512 bytes,tracks per surface: 2000, sectors per track: 50,double sided platters: 5, average seek time: 10msec. What is the capacity of a track in bytes?', 'Incorrect Ans 8v1',0, 'short explanation 8');

insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Correct Ans 1v2',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Correct Ans 2v2',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Correct Ans 3v2',1, '');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Incorrect Ans 4v1',0, 'short explanation 4');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Incorrect Ans 5v1',0, 'short explanation 5');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Incorrect Ans 6v1',0, 'short explanation 6');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Incorrect Ans 7v1',0, 'short explanation 7');
insert into QUESTION_PARAM_ANSWERS values ('3','Consider a disk with a sector size: 256 bytes,tracks per surface: 1000, sectors per track: 100,double sided platters: 10, average seek time: 20msec. What is the capacity of a track in bytes?', 'Incorrect Ans 8v1',0, 'short explanation 8');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into EXERCISE (exercise_id,course_id,name,deadline,total_questions,retries,start_date,end_date,points,penalty,scoring_policy,sc_mode) values (1,'CSC540','homework 1',TO_DATE('09/19/2017', 'MM/DD/YYYY'),3,2,TO_DATE('08/12/2017', 'MM/DD/YYYY'),TO_DATE('09/07/2017', 'MM/DD/YYYY'),3,1,'LatestAttempt','STANDARD');
insert into EXERCISE (exercise_id,course_id,name,deadline,total_questions,retries,start_date,end_date,points,penalty,scoring_policy,sc_mode) values (2,'CSC540','homework 2',TO_DATE('10/10/2017', 'MM/DD/YYYY'),3,1,TO_DATE('09/21/2017', 'MM/DD/YYYY'),TO_DATE('10/10/2017', 'MM/DD/YYYY'),4,1,'AverageScore','ADAPTIVE');
insert into EXERCISE (exercise_id,course_id,name,deadline,total_questions,retries,start_date,end_date,points,penalty,scoring_policy,sc_mode) values (3,'CSC540','homework 3',TO_DATE('10/30/2017', 'MM/DD/YYYY'),3,-1,TO_DATE('10/12/2017', 'MM/DD/YYYY'),TO_DATE('10/30/2017', 'MM/DD/YYYY'),4,0,'AverageScore','STANDARD');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into EXERCISE_QUESTION values (1,1);
insert into EXERCISE_QUESTION values (1,2);
insert into EXERCISE_QUESTION values (1,3);
insert into EXERCISE_QUESTION values (3,1);
insert into EXERCISE_QUESTION values (3,2);
insert into EXERCISE_QUESTION values (3,3);



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into ADAPTIVE_EXERCISE_TOPIC values (2,'01');



----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(1,1,'mjones',5,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(2,1,'mjones',9,2);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(3,1,'jmick',9,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(4,2,'aneela',7,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(5,2,'aneela',12,2);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(6,2,'mjones',3,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(7,2,'mjones',7,2);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(8,3,'aneela',8,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(9,3,'aneela',4,2);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(10,3,'aneela',12,3);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(11,3,'mjones',8,1);
insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,points,number_of_attempts) values(12,3,'mjones',12,2);
----------------------------------------------------------

drop sequence ATTEMPT_SUBMISSION_SEQ;
drop sequence Question_SEQ;
drop sequence EXERCISE_SEQ;

declare
    las_new_seq INTEGER;
begin
   select max(attempt_id) + 1
   into   las_new_seq
   from   attempt_submission;

    execute immediate 'Create sequence attempt_submission_seq
                       start with ' || las_new_seq ||
                       ' increment by 1';
end;
/

declare
    lq_new_seq INTEGER;
begin
   select max(question_id) + 1
   into   lq_new_seq
   from   question;

    execute immediate 'Create sequence question_seq
                       start with ' || lq_new_seq ||
                       ' increment by 1';
end;

/

declare
    l_new_seq INTEGER;
begin
   select max(exercise_id) + 1
   into   l_new_seq
   from   exercise;

    execute immediate 'Create sequence exercise_seq
                       start with ' || l_new_seq ||
                       ' increment by 1';
end;

/