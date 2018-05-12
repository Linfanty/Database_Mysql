CREATE TABLE student(
sno char(6) PRIMARY KEY, # lie
sname char(9) NOT NULL, 
sex char(3), 
sage int, 
dno char(4), 
dormno char(5));


CREATE TABLE grade(
sno char(6), 
cno char(2), 
score decimal(4, 1),
PRIMARY KEY(cno, sno)); # biao


CREATE TABLE student(
sno char(6) NOT NULL UNIQUE, 
sname char(9) NOT NULL, 
sex char(3) CHECK (sex IN ('男', '女')),
sage int, 
dno char(4), 
dormno char(5)
);
