create database homework3;
use homework3;

create table EmployeeInfo(
	EmpID int auto_increment primary key,
    EmpFName varchar(20) not null,
    EmpLName varchar(20) not null,
	Department varchar(20) not null,
    Project varchar(2) not null,
    Address varchar(20) not null,
    DOB date not null,
    Gender varchar(1) not null check(Gender in ('M', 'F'))
);

insert into EmployeeInfo(EmpFName, EmpLName, Department, Project, Address, DOB, Gender)
values ('Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad(HYD)', '1976-01-12', 'M'),
('Ananya', 'Mishra', 'Admin', 'P2', 'Delhi(DEL)', '1968-02-05', 'F'),
('Rohan', 'Diwan', 'Account', 'P3', 'Mumbai(BOM)', '1980-01-01', 'M'),
('Sonia', 'Kulkarni', 'HR', 'P1', 'Hyderabad(HYD)', '1992-02-05', 'F'),
('Ankit', 'kapoor', 'Admin', 'P2', 'Delhi(DEL)', '1994-04-07', 'M');

create table EmployeePosition(
	EmpID int,
    EmpPosition varchar(20),
    DateOfJoining date not null,
    Salary int not null,
    primary key (EmpID, EmpPosition),
    foreign key (EmpID) references EmployeeInfo(EmpID)
);


insert into EmployeePosition(EmpID, EmpPosition, DateOfJoining, Salary)
values(1, 'Manager', '2019-01-05', 500000),
(2, 'Excutive', '2019-02-05', 75000),
(3, 'Manager', '2019-01-05', 90000),
(2, 'Lead', '2019-02-05', 85000),
(1, 'Excutive', '2019-01-05', 300000);

-- 1. Write a query to fetch the number of employees working in the department ‘HR’.
select count(EmpID) from EmployeeInfo where Department = 'HR';

/* 2. Write a query to retrieve the first four characters of EmpLname from the
EmployeeInfo table. */
select substring(EmpLName, 1, 4) from EmployeeInfo;

-- 3. Write a query to find all the employees whose salary is between 50000 to 100000.
select EmployeeInfo.*, EmployeePosition.Salary 
from EmployeeInfo inner join EmployeePosition
on EmployeeInfo.EmpID = EmployeePosition.EmpID
where EmployeePosition.Salary between 50000 and 100000;

/* 4. Write a query find number of employees whose DOB is between
02/05/1970 to 31/12/1975 and are grouped according to gender. */
select count(EmpID), Gender
from EmployeeInfo
where DOB between '1970-05-02' and '1975-12-31'
group by Gender;
-- select count(dob), gender
-- from EmployeeInfo
-- where dob between '1970-05-02' and '1975-12-31'
-- -- where (dob >'1970-05-02' and dob < '1975-12-31')
-- group by gender;

/*5. Write a query to fetch all the records from the EmployeeInfo table
ordered by EmpLname in descending order and Department in the ascending order. */
select * from EmployeeInfo
order by EmpLName desc, Department asc;

/*6. Write a query to fetch details of employees whose EmpLname ends with
an alphabet ‘A’ and contains five alphabets. */
select * from EmployeeInfo
where EmpLName like '%a' and length(EmpLName) = 5;

/*7. Write a query to fetch details of all employees excluding the employees
with first names, “Sanjay” and “Sonia” from the EmployeeInfo table. */
select * from EmployeeInfo
where EmpFName not in ('Sanjay', 'Sonia');

/* 8. Write a query to fetch details of employees with the address as
“DELHI(DEL)”. */
select * from EmployeeInfo
where Address = 'Delhi(DEL)';

-- 9. Write a query to fetch all employees who also hold the managerial position.
select * from EmployeePosition where EmpPosition = 'Manager';

select empID, empFname, empLname, department, address, dob, gender
from EmployeeInfo
where empID in ( select empID from EmployeePosition where empPosition = 'manager');

/* 10.Write a query to fetch the department-wise count of employees sorted by
department’s count in ascending order. */
-- select Employeeinfo.Department, count(Employeeposition.EmpID)
-- from Employeeinfo
-- inner join Employeeposition
-- on Employeeinfo.EmpID = Employeeposition.EmpID
-- group by Employeeinfo.Department
-- order by count(Employeeposition.EmpID) asc;
select Department, count(EmpID) from Employeeinfo group by Department order by count(EmpID) asc;


/* 11.Write a query to retrieve two minimum and maximum salaries from the
EmployeePosition table. */
Select max(Salary), min(Salary) from EmployeePosition;

-- 12.Write a query to retrieve duplicate records from ‘EmployeeInfo’ table.
select * from Employeeinfo group by EmpFName, EmpLName, Department, Project, Address, DOB, Gender having count(*) > 1;

-- 13.Write a query to retrieve the list of employees working in the same department.
select * from EmployeeInfo where Department in
(select Department from EmployeeInfo group by Department having count(Department) >=2);

-- 14.Write a query to retrieve Departments who have less than 2 employees working in it.
select Department from EmployeeInfo group by Department having count(Department) < 2;

-- 15.Write a query to retrieve EmpPostion along with total salaries paid for each of them.
select EmpPosition, sum(Salary)
from EmployeePosition
group by EmpPosition;