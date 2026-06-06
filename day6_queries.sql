
1)--to create procedure
CREATE OR REPLACE FUNCTION getempbylocation(
    p_location VARCHAR(100)
)
RETURNS TABLE (
    emp_id INT,
    name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.emp_id, e.name
    FROM emp e
    WHERE e.location = p_location;
END;
$$;

select* from getempbylocation('Chennai');

2)create or replace function getemployeebylocation(
p_location varchar(100)
)
returns table(
emp_id int,
name varchar(100)
)
language plpgsql
as $$
begin
return query
select e.emp_id,e.name from emp e
where e.loction=p_location;
end;
$$;

select * from getempbylocation('Erode');

3)--Functions in postgresql
--String functions

select concat(name,'-',location)
from emp;

--substring
select substring(name from 1 for 3)
from emp;

--replace
select replace(name,'a','@') from emp;

--ceil round up
select ceil(avg(salary)) from emp; ---41,334

--avg
select avg(salary)from emp; ---41,333,33333

--round
select round(avg(salary))from emp; ---41,333

--floor round down
select location,floor(avg(salary)) as avg_salary from emp
group by location;  --41,333 

select now();

select name,salary, location,avg(salary) over(partition by location) as avg_salary from emp;

4)--employee by location
create or replace function employeebylocation(
p_location varchar(100))
returns table(
emp_id int,name varchar(100))
language plpgsql
as $$
begin
return query
select e.emp_id,e.name from emp e
where e.location=p_location;
end;
$$;
select * from employeebylocation('Chennai');

5)create or replace function employeebysalary(
p_salary int)
returns table(
emp_id int,name varchar(100),salary int)
language plpgsql
as $$
begin
return query
	select e.emp_id,e.name,e.salary from emp e
	where e.salary>p_salary;
end;
$$;
select * from employeebysalary(30000);

6)create function employeecount()
returns int
language plpgsql
as $$
declare total_employees int;
begin
	select count(*) into total_employees from emp;
return total_employees;
end;
$$;
select employeecount();

7)create function averagesalary()
returns int
language plpgsql
as $$
declare avg_salary int;
begin 

	select avg(salary) into avg_salary from emp;
return avg_salary;
end;
$$;
select averagesalary();

	
8)create or replace function  highestsalaryemp()
returns table(
emp_id int,name varchar(100),salary int)
language plpgsql
as $$
begin
	return query
	select e.emp_id,e.name,e.salary from emp e
where e.salary=(
select max(e.salary) from emp e);
end;
$$;
select * from highestsalaryemp();  -- shows all column returned by the function 

9)create function locationwisesalary()
returns table(
location varchar(100),salary numeric)
language plpgsql
as $$
begin
	return query
	select e.location,avg(e.salary)as avarage_salary from emp e
	group by e.location;
end;
$$;
select * from locationwisesalary();

10)create function updatesalary(
p_emp_id int,p_salary int)
returns table(
emp_id int, name varchar(100),salary int)
language plpgsql
as $$
begin
	update emp
	set salary=p_salary
	where emp.emp_id=p_emp_id;
return query
	select e.emp_id,e.name,e.salary from emp e
where e.emp_id=p_emp_id;

end;
$$;
select * from updatesalary(1,40000);

11)--create procedure
create procedure updatedsalary(
p_emp_id int,p_salary int)
language plpgsql
as $$
begin
	update emp
	set salary=p_salary
	where emp_id=p_emp_id;
end ;
$$;
call updatedsalary(1,50000);


select * from emp;

12)create procedure insertvalue(
p_emp_id int,p_name varchar(100),p_age int,p_location varchar(100),p_salary int)
language plpgsql
as $$
begin
	insert into emp(
	emp_id,name,age,location,salary)values(
	p_emp_id,p_name,p_age,p_location,p_salary);
end;
$$;

call insertvalue(16,'vishnu',25,'Erode',50000);

13)create procedure deletevalue(
p_emp_id int)
language plpgsql
as $$
begin
	delete from emp
	where emp_id=p_emp_id;
end;
$$;
call deletevalue(16);

--trigger

create table emp_deleted(
    emp_id INT,
    name VARCHAR(100),
    deleted_at TIMESTAMP
);

create or replace function log_deleted_employee()
returns trigger
language plpgsql
as $$
begin
	insert into emp_deleted(emp_id,name,deleted_at)values(old.emp_id,old.name,now());
return old;
end;
$$;
select * from emp_deleted;

create trigger trg_deleted_employee
before delete
on emp
for each row
execute function log_deleted_employee();

DELETE FROM emp
WHERE emp_id = 2;





