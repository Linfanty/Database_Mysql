use STUDENT_DATA; 
 
#3.1 insert into STUDENT values('980101', '陈红', '女', '21', '4', '2303');
#3.2 insert into DEPARTMENT values('5', '历史系',NULL);

# truncate table gradel;

# 3.3
# create table Gradel (
# Sno char(6),
# Cno char(2),
# Score decimal(4,1) null check(Score >= 0 and Score <= 100)
# );

# insert into Gradel
# select sno, cno, score
# from Grade
# where Sno LIKE '99%' and Cno = '01' and score IS NULL;

# select * from Gradel;

#3.4
# update student
# set  sname = '陈弘', sage = '20'
# where sno = '990101';

#3.5
# update grade S
# set score = '0'
# where sno = (  
#	select d1.sno
#    from student d1, department d2
#    where d1.dno = d2.dno and d1.dno = '3');

#3.6
# delete 
# from student
# where sno LIKE '98%';

#4.1
select sno, sname, dormno
from student 
where dno = '1'
order by Dormno;

#4.2
select *
from student
order by sex, sage DESC;

#4.3
select sno, sname, sex, 2003 - sage 'BIRTHDAY', dno, dormno
from student

#4.4
select DISTINCT cno
from grade
where cno;

#4.5
select sname, dormno
from student
where Sage between 21 and 23;

#4.6
select sname
from student 
where dno != '1';

#4.7
select *
from student 
where sname LIKE '张%';

#4.8
select *
from student 
where sname LIKE '_明%';

#4.9
select *
from course
where cpno is NULL;

#4.10
select *
from student
where Sex = '男' and dno = '1';

#4.11
select count(sno)
from student 
where dno = '1';

#4.12
select max(score), min(score), avg(score)  
from student, grade
where dno = '1' and cno = '01';

#4.13 查询了选修4门以上课程的学生
select b.sno, b.sname
from grade a, student b
where a.sno = b.sno
group by b.sno # 按Sno分组
having count(*) > 4; # 聚集函数count对每一组计数

#4.14
select DISTINCT d.head, dm.dormno
from department d, student s1, dorm dm
where d.dno = s1.dno and s1.dormno = dm.dormno;

#4.15
select *
from student, dorm
where student.dormo = dorm.dormno;

#4.16
select a.cname, b.cname '间接先修课'
from course a, course b
where a.cpno = b.cpno;

#4.17
select sname, course.*
from student, grade, course
where student.sno = grade.sno and grade.cno = course.cno;

#4.18
select student.sno, sname, cname, teacher
from student, grade, course
where student.sno = grade.sno and 
	  grade.cno = course.cno
order by cname DESC;

#4.19
select sname, tele
from student, dorm
where student.dno = '4' and student.dormno = dorm.dormno;

#4.20
select sname, sage
from student
where dno != '1' and sage > ALL (
	select sage
    from student
    where dno = '1'
);

#4.21
select distinct grade.sno, sname
from grade, student
where score >= '60' and score not like 'NULL' and grade.sno = student.sno;

#4.22
select distinct grade.sno, sname
from grade, student
where cno = '01' and grade.sno in (
							select grade.sno
                            from grade
                            where cno = '02')
                            and grade.sno = student.sno;
						
#4.23
select distinct sno
from grade x
where not exists (select *
					from grade y
                    where y.sno = '990102' and
                    not exists (select *
                    from grade z
                    where z.sno = x.sno and z.cno = y.cno)
				  );
                    
#4.24
select distinct *
from student 
where dno = '1'
union all
select distinct *
from student
where sage > 20;

#4.25
select sno
from grade
where cno = '01' and sno in (
				 select sno 
                 from grade
                 where cno = '02');	
                 
#4.26
create view VIEW_1(sno, sname, sex, BIRTHDAY, sage, dno, dormno)
as
select sno, sname, sex, 2003 - sage, sage, dno, Dormno
from student
where sex = '男';

#4.27
select sno, sname, dormno
from VIEW_1
where sname like '%原%';
 
#4.28
# SET SQL_SAFT_UPDATES = 0;
update VIEW_1
set sage = '23', dormno = '2202'
where sname = '李军';

# http://www.docin.com/p-389119476.html