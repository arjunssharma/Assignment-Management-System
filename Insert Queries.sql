select * from student
select * from topic
select * from question

delete from exercise_question


SELECT topic_id FROM adaptive_exercise_topic WHERE exercise_id = ?

select * from course
delete from attempt_submission where attempt_id in (1,2,3,4,5,6,7,8)
ALTER TABLE QUESTION 
ADD (QUESTION_TYPE VARCHAR(20) DEFAULT Fixed );

insert into topic values ('T1','Topic Number one')

insert into question (question_text, difficulty_level,hint,explanation,topic_id) values ('Q1',5,'h','e','T1')

insert into question (question_text, difficulty_level,hint,explanation,topic_id) values ('Q2',8,'h','e','T1')


insert into student values ('amedhek','Abhinav',0)

insert into course (course_id, course_name)values('CSC540','DBMS',)


create or replace FUNCTION checkGrad(student_id IN VARCHAR)
   RETURN Number
   IS is_grad Number;

   BEGIN

	  SELECT IS_GRAD
      INTO is_grad
      FROM student s where s.STUDENT_ID = student_id and rownum = 1;

      RETURN(is_grad);

    END checkGrad;

drop function checkIsGrad
drop function myFunction
drop trigger check_is_grad

if ((select is_grad from student s where s.STUDENT_ID = NEW.student_id and rownum = 1) >= 1)
then 
insert into tp values(1);
END if;


create table tp
(id number
);

-----Dummy Data---------------------------

insert into ROLE values ('sjha4','S','sjha');
insert into ROLE values ('sjha5','P','sjha');
insert into ROLE values ('sjha6','T','sjha');
insert into ROLE values ('P1','P','sjha');
insert into ROLE values ('P2','P','sjha');

---------select * from MENU_OPTIONS-----Menu options -----------------------------------------
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

insert into student values ('sjha4','SameerStud Jha',1);

insert into professor values ('sjha5', 'SameerProf Jha');
insert into professor values ('P1', 'Prof1');
insert into professor values ('P2', 'Prof2');

insert into COURSE values ('CSC 540','DBMS',TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/08/2017', 'MM/DD/YYYY'),'P1');
insert into COURSE values ('CSC 541','ADS',TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/08/2017', 'MM/DD/YYYY'),'P1');
insert into COURSE values ('CSC 542','ALDA',TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/08/2017', 'MM/DD/YYYY'),'P2');


insert into EXERCISE (COURSE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES, START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE ) values ('CSC 540', 'E1',TO_DATE('09/07/2017', 'MM/DD/YYYY'), 5,5,TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/17/2017', 'MM/DD/YYYY'), 50, 5, 'MAX', 'STANDARD' );
insert into EXERCISE (COURSE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES, START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE ) values ('CSC 540', 'E2',TO_DATE('09/07/2017', 'MM/DD/YYYY'), 5,5,TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/17/2017', 'MM/DD/YYYY'), 50, 5, 'MAX', 'STANDARD' );
insert into EXERCISE (COURSE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES, START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE ) values ('CSC 541', 'E1',TO_DATE('09/07/2017', 'MM/DD/YYYY'), 5,5,TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('09/22/2017', 'MM/DD/YYYY'), 50, 5, 'AVERAGE', 'STANDARD' );
insert into EXERCISE (COURSE_ID, NAME, DEADLINE, TOTAL_QUESTIONS, RETRIES, START_DATE, END_DATE, POINTS, PENALTY, SCORING_POLICY, SC_MODE ) values ('CSC 542', 'E1',TO_DATE('09/07/2017', 'MM/DD/YYYY'), 5,5,TO_DATE('09/07/2017', 'MM/DD/YYYY'), TO_DATE('10/16/2017', 'MM/DD/YYYY'), 50, 5, 'AVERAGE', 'STANDARD' );

insert into topic values ('T1','Topic Number one');
insert into topic values ('T2','Topic Number two');

insert into QUESTION (QUESTION_TEXT,TOPIC_ID, DIFFICULTY_LEVEL, HINT, EXPLANATION, QUESTION_TYPE) values ('What is your name?','T1',5,'H1','EEE','F');
insert into QUESTION (QUESTION_TEXT,TOPIC_ID, DIFFICULTY_LEVEL, HINT, EXPLANATION, QUESTION_TYPE) values ('What is your surname?','T1',5,'H1','EEE','F');
insert into QUESTION (QUESTION_TEXT,TOPIC_ID, DIFFICULTY_LEVEL, HINT, EXPLANATION, QUESTION_TYPE) values ('What is your mane?','T1',5,'H1','EEE','F');


insert into QUESTION_BANK values ('CSC 540', 1);
insert into QUESTION_BANK values ('CSC 540', 2);
insert into QUESTION_BANK values ('CSC 541', 1);
insert into QUESTION_BANK values ('CSC 541', 3);


------------------------------------------------------------------------------------------
CREATE or REPLACE PROCEDURE SELECT_PROFESSOR_OPTIONS(c_id IN VARCHAR, p_id IN VARCHAR, prc OUT sys_refcursor) 
As
prof_id VARCHAR(20);
begin
   select PROFESSOR_ID into prof_id from course  where course_id = c_id and rownum = 1;
   if (prof_id  <> p_id)
   then
  open prc for select col_name from MENU_OPTIONS where role = 'P' and menu_name = 'View Course' and shown_always = 1 order by DISPLAY_ORDER;
  else
  open prc for select col_name from MENU_OPTIONS where role = 'P' and menu_name = 'View Course' order by DISPLAY_ORDER;
  end if;
end ;

-----------------------------
var rc refcursor

execute SELECT_PROFESSOR_OPTIONS('CSC 540','P1', :rc);
------------------------------------------------------------

SELECT EQ.QUESTION_ID, Q.QUESTION_TEXT, Q.DIFFICULTY_LEVEL, Q.HINT, Q.EXPLANATION, Q.TOPIC_ID FROM EXERCISE_QUESTION EQ inner join QUESTION Q on EQ.QUESTION_ID = Q.QUESTION_ID where EQ.EXERCISE_ID = 1 

select q.QUESTION_ID, q.QUESTION_TEXT, q.DIFFICULTY_LEVEL, q.TOPIC_ID from QUESTION_BANK qb inner join QUESTION q on qb.QUESTION_ID = q.QUESTION_ID where qb.COURSE_ID = ?;  




select * from question

select * from question_bank

select * from QUESTION_PARAM_ANSWERs
--and OBJECT_NAME='COURSE'

Consider a disk with a <?>, <?>, <?>, <?>, <?>. What is the capacity of a track in bytes?
SELECT q.QUESTION_ID, q.QUESTION_TEXT from QUESTION_BANK qb inner join QUESTION q on qb.QUESTION_ID = q.QUESTION_ID where qb.COURSE_ID = 'CSC 540';


select q.QUESTION_ID, q.QUESTION_TEXT from Question q where q.topic_id = 'T1'


SELECT q.QUESTION_ID, q.QUESTION_TEXT from QUESTION_BANK qb inner join QUESTION q on qb.QUESTION_ID = q.QUESTION_ID where qb.COURSE_ID = 'CSC 540';

SELECT q.QUESTION_ID, q.QUESTION_TEXT from EXERCISE_QUESTION eq inner join QUESTION q on eq.QUESTION_ID = q.QUESTION_ID where eq.EXERCISE_ID = ?;

select * from EXERCISE
select * from EXERCISE_QUESTION where EXERCISE_ID = 24

select * from topic

insert into topic values ('T3','Topic 3');
insert into topic values ('T4','Topic 4');
insert into topic values ('T5','Topic 5');

select * from COURSE_TOPIC

insert into course_topic values ('CSC 540','T1');
insert into course_topic values ('CSC 540','T2');
insert into course_topic values ('CSC 540','T4');
insert into course_topic values ('CSC 540','T5');
insert into course_topic values ('CSC 541','T1');
insert into course_topic values ('CSC 541','T3');
insert into course_topic values ('CSC 542','T4');
insert into course_topic values ('CSC 542','T2');

-----------------------
select SCORE from ATTEMPT_SUBMISSION where EXERCISE_ID = 1  and STUDENT_ID = 'sjha' and rownum =1 order by NUMBER_OF_ATTEMPTS


select * from exercise

select * from student

insert into ATTEMPT_SUBMISSION (EXERCISE_ID, STUDENT_ID, SUBMISSION_TIME,POINTS, NUMBER_OF_ATTEMPTS) values (1,'sjha4',TO_DATE('11/05/2017','MM/DD/YYYY'),34,1)

SELECT max(POINTS) into points FROM ATTEMPT_SUBMISSION where EXERCISE_ID = 1 AND STUDENT_ID= 'sjha4' GROUP BY EXERCISE_ID,STUDENT_ID;


 var points number

  SELECT 
  case when exists (select 1 from ATTEMPT_SUBMISSION where EXERCISE_ID = 1 AND STUDENT_ID= 'nd')
  then 1--avg(POINTS)
  else 0
  end
  --into points
 -- select count(POINTS)
  FROM ATTEMPT_SUBMISSION where rownum =1--where EXERCISE_ID = 1 AND STUDENT_ID= 'nd' GROUP BY EXERCISE_ID,STUDENT_ID;
  
  
  select exstsc.Ex,exstsc.St,exstsc.score, ovrall.avg_scr from
(select es.e_id as Ex ,es.s_id as St,
(case es.sp when  'LatestAttempt' 
--then (select  asui.points from ATTEMPT_SUBMISSION asui where asui.EXERCISE_ID = es.e_id and asui.STUDENT_ID =  es.s_id  and rownum = 1 order by asui.NUMBER_OF_ATTEMPTS desc )
then latest.pts
when  'AverageScore' 
then avg(asu.points)
else
max(asu.points)
end) as score
from 
(select e.EXERCISE_ID as e_id, cs.STUDENT_ID as s_id, e.SCORING_POLICY as sp
from 
EXERCISE e, COURSE_STUDENT cs 
where e.COURSE_ID = cs.COURSE_ID) es
left join ATTEMPT_SUBMISSION asu on (asu.EXERCISE_ID = es.e_id and asu.STUDENT_ID = es.s_id)
left join (select asu2.EXERCISE_ID as e_id, asu2.STUDENT_ID as s_id, asu2.points as pts from ATTEMPT_SUBMISSION asu2 where asu2.NUMBER_OF_ATTEMPTS = (select max(asu3.NUMBER_OF_ATTEMPTS) from ATTEMPT_SUBMISSION asu3 where asu3.EXERCISE_ID = asu2.EXERCISE_ID and asu3.STUDENT_ID = asu2.STUDENT_ID)) latest on latest.e_id = es.e_id and latest.s_id = es.s_id
group by es.e_id,es.sp,es.s_id,latest.pts
order by es.e_id) exstsc
inner join ( select avg(et.score) as avg_scr ,et.St as stu from
 (select es.e_id as Ex ,es.s_id as St,
(case es.sp when  'LatestAttempt' 
--then (select  asui.points from ATTEMPT_SUBMISSION asui where asui.EXERCISE_ID = es.e_id and asui.STUDENT_ID =  es.s_id  and rownum = 1 order by asui.NUMBER_OF_ATTEMPTS desc )
then latest.pts
when  'AverageScore' 
then avg(asu.points)
else
max(asu.points)
end) as score
from 
(select e.EXERCISE_ID as e_id, cs.STUDENT_ID as s_id, e.SCORING_POLICY as sp
from 
EXERCISE e, COURSE_STUDENT cs 
where e.COURSE_ID = cs.COURSE_ID) es
left join ATTEMPT_SUBMISSION asu on (asu.EXERCISE_ID = es.e_id and asu.STUDENT_ID = es.s_id)
left join (select asu2.EXERCISE_ID as e_id, asu2.STUDENT_ID as s_id, asu2.points as pts from ATTEMPT_SUBMISSION asu2 where asu2.NUMBER_OF_ATTEMPTS = (select max(asu3.NUMBER_OF_ATTEMPTS) from ATTEMPT_SUBMISSION asu3 where asu3.EXERCISE_ID = asu2.EXERCISE_ID and asu3.STUDENT_ID = asu2.STUDENT_ID)) latest on latest.e_id = es.e_id and latest.s_id = es.s_id
group by es.e_id,es.sp,es.s_id,latest.pts
order by es.e_id) et group by et.St) ovrall
on ovrall.stu = exstsc.St;

select score  from ATTEMPT_SUBMISSION where EXERCISE_ID = 2 and STUDENT_ID = 'aneela'
order by NUMBER_OF_ATTEMPTS desc
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

SELECT * FROM   MYTABLE
--ORDER BY COLUMNNAME -OPTIONAL          
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY