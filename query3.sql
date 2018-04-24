use STUDENT_DATA; 
 
#3.1 
insert into STUDENT values('980101', '陈红', '女', '21', '4', '2303');
#3.2 
insert into DEPARTMENT values('5', '历史系',NULL);

truncate table gradel;

# 3.3
create table Gradel (
Sno char(6),
Cno char(2),
Score decimal(4,1) null check(Score >= 0 and Score <= 100)
);

insert into Gradel
select sno, cno, score
from Grade
where Sno LIKE '99%' and Cno = '01' and score IS NULL;

select * from Gradel;

#3.4
update student
set  sname = '陈弘', sage = '20'
where sno = '990101';

#3.5
update grade S
set score = '0'
where sno = (  
	select d1.sno
    from student d1, department d2
    where d1.dno = d2.dno and d1.dno = '3');

#3.6
delete 
from student
where sno LIKE '98%';
