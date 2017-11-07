Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('tregan','Tom Regan',0);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('??jmick','Jenelle Mick',1);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('mfisher','Michal Fisher',0);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('jander','Joseph Anderson',0);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('?jharla','Jitendra Harlalka',1);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('?aneela','Aishwarya Neelakantan',1);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('mjones','Mary Jones',1);
Insert into STUDENT (STUDENT_ID,NAME,IS_GRAD) values ('jmoyer','James Moyer',1);



Insert into PROFESSOR (PROFESSOR_ID,NAME) values ('kogan','Kemafor Ogan');
Insert into PROFESSOR (PROFESSOR_ID,NAME) values ('rchirkova','Rada Chirkova');
Insert into PROFESSOR (PROFESSOR_ID,NAME) values ('chealey','Christopher Healey');

Insert into COURSE (COURSE_ID,COURSE_NAME,START_DATE,END_DATE,PROFESSOR_ID) values ('CSC440','Database Systems',to_date('27-AUG-17','DD-MON-RR'),to_date('12-DEC-17','DD-MON-RR'),'rchirkova');
Insert into COURSE (COURSE_ID,COURSE_NAME,START_DATE,END_DATE,PROFESSOR_ID) values ('CSC540','Database Systems',to_date('27-SEP-17','DD-MON-RR'),to_date('10-DEC-17','DD-MON-RR'),'kogan');
Insert into COURSE (COURSE_ID,COURSE_NAME,START_DATE,END_DATE,PROFESSOR_ID) values ('CSC541','Advanced Data Structures',to_date('25-SEP-17','DD-MON-RR'),to_date('06-DEC-17','DD-MON-RR'),'chealey');


insert into TA values ('CSC440','?aneela');
insert into TA values ('CSC440','??jmick');
insert into TA values ('CSC540','?jharla');
insert into TA values ('CSC541','jmoyer');


Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('tregan','s','tregan');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('jmick','s','jmick');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('mfisher','s','mfisher');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('?jander','s','jander');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('jharla','s','jharla');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('aneela','s','aneela');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('mjones','s','mjones');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('jmoyer','s','jmoye');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('kogan','p','kogan');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('rchirkova','p','rchirkova');
Insert into ROLE (USER_ID,ROLE,PASSWORD) values ('chealey','p','chealey');


Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Home','View Profile',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Home','View/Add Courses',2,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Home','Enroll/Drop A Student',3,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Home','Search/Add questions to Question Bank',4,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Home','Logout',5,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('T','Home','View Profile',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('T','Home','View/Add Courses',2,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('T','Home','Enroll/Drop A Student',3,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('T','Home','Logout',4,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('S','Home','View/Edit Profile',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('S','Home','View Courses',2,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('S','Home','Logout',3,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('S','Profile','Student ID',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('T','Profile','Employee ID',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','Profile','Employee ID',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','Course Name',1,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','Start Date',2,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','End Date',3,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','View Exercise',4,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','ADD Exercise',5,0);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','View TA',6,1);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','Add TA',7,0);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','Enroll/Drop Student',8,0);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','View Course','View Report',9,0);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','viewSpecificExercise','DELETE QUESTION',2,0);
Insert into MENU_OPTIONS (ROLE,MENU_NAME,COL_NAME,DISPLAY_ORDER,SHOWN_ALWAYS) values ('P','viewSpecificExercise','ADD QUESTION',1,0);


Insert into TOPIC (TOPIC_ID,NAME) values ('01','ER Model');
Insert into TOPIC (TOPIC_ID,NAME) values ('02','SQL');
Insert into TOPIC (TOPIC_ID,NAME) values ('03','Storing Data:Disks and Files');
Insert into TOPIC (TOPIC_ID,NAME) values ('04','Primary File Organization');
Insert into TOPIC (TOPIC_ID,NAME) values ('05','Hashing Techniques');
Insert into TOPIC (TOPIC_ID,NAME) values ('06','Binary Tree Structures');
Insert into TOPIC (TOPIC_ID,NAME) values ('07','AVL Trees');
Insert into TOPIC (TOPIC_ID,NAME) values ('08','Sequential File Organization');
Insert into TOPIC (TOPIC_ID,NAME) values ('09','BinarySearch');
Insert into TOPIC (TOPIC_ID,NAME) values ('10','Interpolation Search');


Insert into QUESTION (QUESTION_ID,QUESTION_TEXT,DIFFICULTY_LEVEL,HINT,EXPLANATION,QUESTION_TYPE,TOPIC_ID) values (1,'Question 1?',2,'Hint text Q1','Detailed Explanation Q1','f','01');
Insert into QUESTION (QUESTION_ID,QUESTION_TEXT,DIFFICULTY_LEVEL,HINT,EXPLANATION,QUESTION_TYPE,TOPIC_ID) values (2,'Question 2?',3,'Hint text Q2','Detailed Explanation Q2','f','01');
Insert into QUESTION (QUESTION_ID,QUESTION_TEXT,DIFFICULTY_LEVEL,HINT,EXPLANATION,QUESTION_TYPE,TOPIC_ID) values (3,'Question 3?',2,'Hint text Q3','Detailed Explanation Q3','p','01');


Insert into EXERCISE (EXERCISE_ID,COURSE_ID,NAME,DEADLINE,TOTAL_QUESTIONS,RETRIES,START_DATE,END_DATE,POINTS,PENALTY,SCORING_POLICY,SC_MODE,DIFFICULTY_LEVEL) values (1,'CSC540','homework 1',to_date('19-SEP-17','DD-MON-RR'),3,2,to_date('12-AUG-17','DD-MON-RR'),to_date('07-SEP-17','DD-MON-RR'),3,1,'LatestAttempt','STANDARD',null);
Insert into EXERCISE (EXERCISE_ID,COURSE_ID,NAME,DEADLINE,TOTAL_QUESTIONS,RETRIES,START_DATE,END_DATE,POINTS,PENALTY,SCORING_POLICY,SC_MODE,DIFFICULTY_LEVEL) values (2,'CSC540','homework 2',to_date('10-OCT-17','DD-MON-RR'),3,1,to_date('21-SEP-17','DD-MON-RR'),to_date('10-OCT-17','DD-MON-RR'),4,1,'AverageScore','ADAPTIVE',null);
Insert into EXERCISE (EXERCISE_ID,COURSE_ID,NAME,DEADLINE,TOTAL_QUESTIONS,RETRIES,START_DATE,END_DATE,POINTS,PENALTY,SCORING_POLICY,SC_MODE,DIFFICULTY_LEVEL) values (3,'CSC540','homework 3',to_date('30-OCT-17','DD-MON-RR'),3,-1,to_date('12-OCT-17','DD-MON-RR'),to_date('30-OCT-17','DD-MON-RR'),4,0,'AverageScore','STANDARD',null);


Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC440','mfisher');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC440','jander');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC440','tregan');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC540','aneela');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC540','mjones');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC541','aneela');
Insert into COURSE_STUDENT (COURSE_ID,STUDENT_ID) values ('CSC541','mjones');


Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC440','04');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC440','06');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC540','01');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC540','03');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC540','04');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC540','06');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC541','04');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC541','05');
Insert into COURSE_TOPIC (COURSE_ID,TOPIC_ID) values ('CSC541','06');


Insert into QUESTION_BANK (COURSE_ID,QUESTION_ID) values ('CSC540',1);
Insert into QUESTION_BANK (COURSE_ID,QUESTION_ID) values ('CSC540',2);
Insert into QUESTION_BANK (COURSE_ID,QUESTION_ID) values ('CSC540',3);


Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Correct Ans 1',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Correct Ans 2',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Incorrect Ans 3',0,'short explanation 3');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Incorrect Ans 4',0,'short explanation 4');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Incorrect Ans 5',0,'short explanation 5');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (1,'Question 1?','Incorrect Ans 6',0,'short explanation 6');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Correct Ans 1',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Correct Ans 2',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Correct Ans 3',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Incorrect Ans 4',0,'short explanation 4');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Incorrect Ans 5',0,'short explanation 5');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (2,'Question 2?','Incorrect Ans 6',0,'short explanation 6');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes? ','Correct Ans 1v1',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Correct Ans 2v1',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Correct Ans 3v1',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Incorrect Ans 4v1',0,'short explanation 4');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Incorrect Ans 5v1',0,'short explanation 5');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Incorrect Ans 6v1',0,'short explanation 6');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Incorrect Ans 7v1',0,'short explanation 7');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes?','Incorrect Ans 8v1',0,'short explanation 8');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes? ','Correct Ans 1v2',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Correct Ans 2v2',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Correct Ans 3v2',1,null);
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Incorrect Ans 4v1',0,'short explanation 4');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Incorrect Ans 5v1',0,'short explanation 5');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Incorrect Ans 6v1',0,'short explanation 6');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Incorrect Ans 7v1',0,'short explanation 7');
Insert into QUESTION_PARAM_ANSWERS (QUESTION_ID,QUESTION,ANSWER,CORRECT,EXPLANATION) values (3,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes?','Incorrect Ans 8v1',0,'short explanation 8');


Insert into EXERCISE_QUESTION values (1,1);
Insert into EXERCISE_QUESTION values (1,2);
Insert into EXERCISE_QUESTION values (1,3);
Insert into EXERCISE_QUESTION values (3,1);
Insert into EXERCISE_QUESTION values (3,2);
Insert into EXERCISE_QUESTION values (3,3);


Insert into ADAPTIVE_EXERCISE_TOPIC values(2,'01');


Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(1,1,'mjones',TO_DATE(sysdate),5,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(2,1,'mjones',TO_DATE(sysdate),9,2);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(3,1,'jmick',TO_DATE(sysdate),9,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(4,2,'aneela',TO_DATE(sysdate),7,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(5,2,'aneela',TO_DATE(sysdate),12,2);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(6,2,'mjones',TO_DATE(sysdate),3,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(7,2,'mjones',TO_DATE(sysdate),7,2);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(8,3,'aneela',TO_DATE(sysdate),8,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(9,3,'aneela',TO_DATE(sysdate),4,2);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(10,3,'aneela',TO_DATE(sysdate),12,3);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(11,3,'mjones',TO_DATE(sysdate),8,1);
Insert into ATTEMPT_SUBMISSION(attempt_id,exercise_id,student_id,submission_time,points,number_of_attempts) values(12,3,'mjones',TO_DATE(sysdate),12,2);