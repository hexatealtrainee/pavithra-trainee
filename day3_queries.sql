1.Select female patients order by youngest 

select * from patient_registration 
where gender='Female'
order by age asc;

2. Count the number of patients age>35 by gender and display the highest patient count first.

select gender,count(*) as total_patients
from patient_registration
where age>35
group by gender
order by total_patients desc;

3.Count the number of patients in each city from Tamil Nadu and display cities in alphabetical order
select city, count(*) as patient_count
from patient_registration
where state='Tamil Nadu'
group by city 
order by city asc;

4.Show the latest registration date for each department ordered by latest registration first.

select department ,max(registration_date) as latest_registration
from patient_registration
where registration_date is not null
group by department
order by latest_registration desc;

5.Count the number of patients with blood groups O+ and A+ and display the result in ascending order of total patients.
select blood_group,count(*) as total
from patient_registration
where blood_group='O+'or blood_group='A+'
group by blood_group
order by total asc;

6.Show average age by department for patients from Chennai or Madurai.
select department,avg(age) as average_age
from patient_registration
where city = 'Chennai'or city = 'Madurai'
group  by department
order by average_age desc;

