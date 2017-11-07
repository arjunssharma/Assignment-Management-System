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
    USER_ID 
  
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
, RETRIES NUMBER 
, START_DATE DATE 
, END_DATE DATE 
, POINTS NUMBER 
, PENALTY NUMBER 
, SCORING_POLICY VARCHAR(20) 
, SC_MODE VARCHAR(20)
, DIFFICULTY_LEVEL NUMBER
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
, QUESTION_TEXT VARCHAR(200) NOT NULL 
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
, SUBMISSION_TIME TIMESTAMP NOT NULL 
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
ALTER TRIGGER check_is_grad ENABLE;

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
AFTER DELETE OR INSERT ON EXERCISE_QUESTION 
FOR EACH ROW
DECLARE
Average number;
BEGIN
  Select AVG(DIFFICULTY_LEVEL) into Average from QUESTION where QUESTION_ID in(Select QUESTION_ID from EXERCISE_QUESTION where EXERCISE_ID = :NEW.EXERCISE_ID);
  If(Average>0) then
  UPDATE EXERCISE SET DIFFICULTY_LEVEL = Average  WHERE EXERCISE_ID =:NEW.EXERCISE_ID;
  end if; 
END;
/

ALTER TRIGGER Average_Difficulty_Level DISABLE;



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
