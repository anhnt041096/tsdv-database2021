-- EXERCISE 1:
create database exercise1;
use exercise1;
create table Student (
	StudentID int,
    StudentName varchar(20),
    primary key (StudentID)
);
create table Faculty (
	FacultyID int,
    FacultyName varchar(20) unique,
    primary key (FacultyID)
);
create table Course (
	CourseID varchar(10),
    CourseName varchar(30) unique,
    PRIMARY KEY (CourseID)
);
create table Qualified (
	FacultyID int,
    CourseID varchar(10),
    DateQualified date not null,
    primary key (FacultyID, CourseID),
    foreign key (FacultyID) references Faculty (FacultyID),
    foreign key (CourseID) references Course (CourseID)
);
create table Section (
	SectionNo int,
    Semester varchar(10),
    CourseID varchar(10),
    primary key (SectionNo, Semester, CourseID),
    foreign key (CourseID) references Course (CourseID)
);
create table Registration (
	StudentID int,
    SectionNo int,
    Semester varchar(10),
    primary key (StudentID, SectionNo, Semester),
    foreign key (StudentID) references Student (StudentID),
    foreign key (SectionNo) references Section (SectionNo)
);

insert into Student(StudentID, StudentName)
values(38214, 'Letersky'),
(54907, 'Altvater'),
(66324, 'Aiken'),
(70542, 'Marra');

insert into Faculty(FacultyID, FacultyName)
values(2143, 'Birkin'),
(3467, 'Berndt'),
(4756, 'Collins');

insert into Course(CourseID, CourseName)
values('ISM 3113', 'Syst Analysis'),
('ISM 3112', 'Syst Design'),
('ISM 4212', 'Database'),
('ISM 4930', 'Networking');

insert into Qualified(FacultyID, CourseID, DateQualified)
values (2143, 'ISM 3112', '1988-9-9'),
(2143, 'ISM 3113', '1988-9-9'),
(3467, 'ISM 4212', '1995-9-9'),
(3467, 'ISM 4930', '1996-9-9'),
(4756, 'ISM 3113', '1991-9-9'),
(4756, 'ISM 3112', '1991-9-9');

insert into Section(SectionNo, Semester, CourseID)
values(2712, 'I-2008', 'ISM 3113'),
(2713, 'I-2008', 'ISM 3113'),
(2714, 'I-2008', 'ISM 4212'),
(2715, 'I-2008', 'ISM 4930');

insert into Registration(StudentID, SectionNo, Semester)
values(38214, 2714, 'I-2008'),
(54907, 2714, 'I-2008'),
(54907, 2715, 'I-2008'),
(66324, 2713, 'I-2008');

-- A. Display the course ID and course name for all courses with an ISM prefix.
select * from Course
where CourseID like'ISM%';

-- B. Display courses information for which Professor Berndt has been qualified.
select Course.CourseID, Course.CourseName
from ((Qualified
inner join Faculty on Qualified.FacultyID = Faculty.FacultyID)
inner join Course on Qualified.CourseID = Course.CourseID)
where Faculty.FacultyID = 'Berndt';

/*C.Which faculty are qualified to teach
ISM 3113? */
select Qualified.FacultyID ,Faculty.FacultyName, Qualified.CourseID
from Qualified
inner join Faculty 
on Faculty.FacultyID = Qualified.FacultyID
where Qualified.CourseID = 'ISM 3113';

/*D. Is any faculty qualified to teach ISM
3113 and not qualified to teach ISM 4930? */

select Faculty.FacultyName
from Qualified
inner join Faculty
on Faculty.FacultyID = Qualified.FacultyID
where Qualified.CourseID = 'ISM 3113'and Qualified.CourseID != 'ISM 4930';

/*
E1. How many students were enrolled in section 2714 during semester I-2008?
*/
select count(StudentID) from Registration
where SectionNo = 2714 and Semester = 'I-2008'; 

/* E2. How many students were enrolled in ISM 3113 during semester I-2008?
*/
select count(StudentID) from Registration
where SectionNo in
(select SectionNo from Section 
where CourseID = 'ISM 3113' and Semester = 'I-2008');

/*F.Which students were not enrolled
in any courses during semester I-2008? */
select StudentID, StudentName from Student
where StudentID not in (select StudentID from Registration where Semester = 'I-2008'); 


-- EXERCISE 2:
create database exercise2;
use exercise2;

create table Student(
	StudentID int auto_increment primary key,
    Read1 decimal(2,1) check(Read1 between 0 and 10)
);

create table Tutor(
	TutorID int primary key,
    CertDate date,
    Statuss varchar(20)
);

create table match_history(
	MatchID int auto_increment primary key,
    TutorID int,
    StudentID int,
    StartDate date not null,
    EndDate date,
    constraint match_history_check check(StartDate < EndDate),
    foreign key (TutorID) references Tutor(TutorID),
    foreign key (StudentID) references Student(StudentID)
);

create table tutor_report (
	MatchID int,
    Months date,
    Hours int not null,
    lessons int not null,
    primary key (MatchID, Months),
    foreign key (MatchID) references match_history(MatchID)
);

insert into Student(StudentID, Read1)
values(3000, 2.3),
(3001, 5.6),
(3002, 1.3),
(3003, 3.3),
(3004, 2.7),
(3005, 4.8),
(3006, 7.8),
(3007, 1.5);

insert into Tutor(TutorID, CertDate, Statuss)
values(100, '2008-1-05', 'Active'),
(101, '2008-1-05', 'Temp Stop'),
(102, '2008-1-05', 'Dropped'),
(103, '2008-5-22', 'Active'),
(104, '2008-5-22', 'Active'),
(105, '2008-5-22', 'Temp Stop'),
(106, '2008-5-22', 'Active');


insert into match_history(TutorID, StudentID, StartDate)
values (100, 3000, '2008-1-10');
insert into match_history(TutorID, StudentID, StartDate, EndDate)
values(101, 3001, '2008-1-15', '2008-5-15'),
(102, 3002, '2008-2-10', '2008-3-1');
insert into match_history(TutorID, StudentID, StartDate)
values(106, 3003, '2008-5-28');
insert into match_history(TutorID, StudentID, StartDate, EndDate)
values(103, 3004, '2008-6-01', '2008-6-15'),
(104, 3005, '2008-6-01', '2008-6-28');
insert into match_history(TutorID, StudentID, StartDate)
values(104, 3006, '2008-6-01');

-- SET FOREIGN_KEY_CHECKS=1;

insert into tutor_report (MatchID, Months, Hours, Lessons)
values(1, '2021-6-08', 8, 4),
(4, '2021-6-08', 8, 6),
(5, '2021-6-08', 8, 4),
(4, '2021-7-08', 10, 5),
(1, '2021-7-08', 4, 2);

-- A. Write the SQL command to add ‘MATH SCORE’ to the STUDENT table.
alter table Student
add Math decimal(2,1) check (Math between 0 and 10);

-- B. How many tutors have a status of Temp Stop?
select count(TutorID) from Tutor where Statuss = 'Temp Stop'; 

-- Which tutors are active?
select TutorID from Tutor where Statuss = 'Active'; 

-- List the tutor information who took the certification class in January.
select TutorID, Statuss from Tutor where CertDate like '%-01-%';

-- C. How many students were begin matched with someone in the first 5 months of the year?
-- (StartDate in the first 5 months of the year)
select StudentID from match_history where (month(StartDate) between 1 and 5);

-- D1. List students ranking from max Read Score to min Read Score? 
select StudentID, Read1 from Student order by Read1;

-- D2. Which student has highest read score?
select max(read1) from Student; 


