create database STUDENT_DATA; 
use STUDENT_DATA;  

create table DEPARTMENT (
Dno char(4) primary key, # Dno为主码。
Dname char(20) unique, # Dname不能重复。
Head char(20)
);

insert into DEPARTMENT values('1', '计算机系', '王凯峰');
insert into DEPARTMENT values('2', '数学系', '李永军');
insert into DEPARTMENT values('3', '物理系', '唐键');
insert into DEPARTMENT values('4', '中文系', '秦峰');
# 为DEPARTMENT表的各项赋值。

select * from DEPARTMENT; #读取DEPARTMENT表。

create table DORM (
Dormno char(5) primary key check(Dormno like '[0-9][0-9][0-9][0-9]'), #--Dormno为主码，且必须为四位数字。
Tele char (7) check(Tele like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]') # --Tele必须为七位数字且不可重复。
);

insert into DORM values('2101', '8302101');
insert into DORM values('2202', '8302202');
insert into DORM values('2303', '8302303');
insert into DORM values('2404', '8302404');
insert into DORM values('2505', '8302505');
# --为DORM表的各项赋值。

select * from DORM; # --读取DORM表。

create table COURSE (
Cno char(2) primary key check(Cno like '[0-9][0-9]'), # --Cno为主码，且必须为两位数字。
Cname char(20) unique, # --Cname不可重复。
Cpno char(2) null, # --Cpno可为空（即不存在先行课）。
Credit int check(Credit > 0), # --学分大于零。
Teacher char(8),
constraint FK_COURSE_Cpno foreign key(Cpno) references COURSE(Cno) # --Cpno引用了Cno，Cpno为Cno的外码。
);

insert into COURSE(Cno, Cname, Credit, Teacher) values('01', '数据库原理', '4', '王凯'); 
insert into COURSE(Cno, Cname, Credit, Teacher) values('02', '高等数学', '6', '张风');
insert into COURSE(Cno, Cname, Credit, Teacher) values('03', '信息系统', '2', '李明');
insert into COURSE(Cno, Cname, Credit, Teacher) values('04', '操作系统', '4', '许强');
insert into COURSE(Cno, Cname, Credit, Teacher) values('05', '数据结构', '4', '路飞');
insert into COURSE(Cno, Cname, Credit, Teacher) values('06', '算法设计', '2', '黄海');
insert into COURSE(Cno, Cname, Credit, Teacher) values('07', 'C语言', '3', '高达');
/*
因为在先前语句中定义了Cpno为Cno的外码，所以应当先为Cno赋值，否则会发生错误。
如果使用insert into XXX values(YYY,ZZZ)的方式必须为所有项同时赋值，而insert into XXX(AAA) values(YYY)的方式就可以先只为某一项或几项先行赋值。
*/

update COURSE set Cpno = '05' where Cno = '01'; 
update COURSE set Cpno = NULL where Cno = '02';
update COURSE set Cpno = '01' where Cno = '03';
update COURSE set Cpno = '06' where Cno = '04';
update COURSE set Cpno = '07' where Cno = '05';
update COURSE set Cpno = NULL where Cno = '06';
update COURSE set Cpno = '06' where Cno = '07';
# --用update语句为Cpno赋值。where是限定条件，在本段中，它的含义是在Cno为某个值时为对应行的Cpno赋特定值。

select * from COURSE;
# --读取COURSE表。

create table STUDENT (

Sno char(6) primary key check(Sno like '[0-9][0-9][0-9][0-9][0-9][0-9]'), # --Sno为主码，且必须为六位数字。
Sname char(8),
Sex char(2) check(Sex = '男' or Sex = '女'), # --Sex必须为"男"或"女"。
Sage int check(Sage >= 10 and Sage <= 100), # --Sage必须介于10和100之间。
Dno char(4),
Dormno char(5) null check(Dormno like '[0-9][0-9][0-9][0-9]'), # --Dormno必须为四位数字，可以为空（即没有寝室）。

constraint FK_STUDENT_Dno foreign key(Dno) references DEPARTMENT(Dno), # --STUDENT表的Dno引用了DEPARTMENT表的Dno。
constraint FK_STUDENT_Dormno foreign key(Dormno) references DORM(Dormno) # --STUDENT表的Dormno引用了DORM表的Dormno。
);

insert into STUDENT values('990101', '原野', '男', '21', '1', '2101');
insert into STUDENT values('990102', '张原', '男', '21', '1', '2101');
insert into STUDENT values('990103', '李军', '男', '20', '1', '2101');
insert into STUDENT values('990104', '汪远', '男', '20', '1', '2101');
insert into STUDENT values('990105', '齐欣', '男', '20', '1', '2101');
insert into STUDENT values('990201', '王大鸣', '男', '19', '2', '2202');
insert into STUDENT values('990202', '徐东', '男', '19', '2', '2202');
insert into STUDENT values('990301', '张扬', '女', '21', '1', '2303');
insert into STUDENT values('990302', '于洋', '女', '20', '3', '2303');
insert into STUDENT values('990303', '姚志旬', '男', '19', '4', '2404');
insert into STUDENT values('990401', '高明镜', '男', '19', '4', NULL);
insert into STUDENT values('990402', '明天', '男', '21', '4', '2404');
# --为STUDENT表的各项赋值。

select * from STUDENT;
# --读取STUDENT表。

create table GRADE (
Sno char(6) check(Sno like '[0-9][0-9][0-9][0-9][0-9][0-9]'), # --Sno必须为六位数字。
Cno char(2) check(Cno like '[0-9][0-9]'), # --Cno必须为两位数字。
Score decimal(4,1) null check(Score >= 0 and Score <= 100), # --Score小数点左边有四位有效数字，小数点右边有一位有效数字。Score可以为空，如不为空，必须在0到100之间。

constraint PK_GRADE primary key(Sno,Cno), # --Sno与Cno共同作为主码。
# --因为二者共同作为主码，因此它们每一个本身都不是主码，因此可以为外码。
constraint FK_GRADE_Sno foreign key(Sno) references STUDENT(Sno), # --GRADE表的Sno引用了STUDENT表的Sno
constraint FK_GRADE_Cno foreign key(Cno) references COURSE(Cno) # --GRADE表的Cno引用了COURSE表的Cno
);

insert into GRADE values('990101', '01', '85');
insert into GRADE values('990101', '03', '65');
insert into GRADE values('990101', '04', '83');
insert into GRADE values('990101', '07', '72');
insert into GRADE values('990102', '01', NULL);
insert into GRADE values('990102', '02', '80');
insert into GRADE values('990102', '04', '81');
insert into GRADE values('990103', '01', '74');
insert into GRADE values('990103', '02', '70');
insert into GRADE values('990103', '04', '70');
insert into GRADE values('990103', '06', '74');
insert into GRADE values('990103', '07', '74');
insert into GRADE values('990104', '01', '55');
insert into GRADE values('990104', '02', '42');
insert into GRADE values('990104', '06', '0');
insert into GRADE values('990105', '03', '85');
insert into GRADE values('990105', '06', NULL);
insert into GRADE values('990301', '01', '46');
insert into GRADE values('990301', '02', '70');
insert into GRADE values('990302', '01', '85');
insert into GRADE values('990401', '01', '0');
# --为GRADE表的各项赋值。

select * from GRADE;
# --读取GRADE表。