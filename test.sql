use myfirst;

# 查询每个学生的学号、姓名、选修的课程名及成绩
# select student.sno, sname, cname, grade
# from student, sc, course
# where student.sno = sc.sno and sc.cno = course.cno;


# select student.sno, sname
# from student, sc
# where student.sno = sc.sno and sc.grade > 60;

# select sname Name, 'Years' Birth, 200215130 - sno, lower(sdept)
# from student;

# select sno, grade
# from sc
# where cno = '3'
# order by grade desc;

# select student.sno, sname, ssex, sage, sdept, cno, grade
# from student left join sc on( student.sno = sc.sno);

# 查找与“刘晨”在同一个系学习的学生
# select sno, sname, sdept 
# from student 
# where sdept in (
#	select sdept
#    from student
#    where sname = '刘晨'
# );

# 解法2: 自身连接
# select s1.sno, s1.sname, s1.sdept
# from student s1, student s2 # 取一个元祖
# where s1.sdept = s2.sdept and s2.sname = '刘晨';

select sno, cno
from sc x
where grade >= # 超过他选修课程平均成绩的课程号 
( select avg(grade) 
  from sc y
  where y.sno = x.sno);