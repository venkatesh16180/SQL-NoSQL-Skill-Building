/* 
	Exercise 1:
    Write a query to display the unique first names of trainers.
    Sort the results.
*/

use business;
select distinct first_name from trainer order by first_name desc; -- sorted in descending order
select distinct first_name from trainer order by first_name asc; -- sorted in asending order

/*
	Exercise 2:
    Write a query to display the first name, last name and
    hire date of the employees that were hired after January 11, 2011. 
    Sort the results according to when they were hired.  
*/

select first_name,last_name,hire_date from employee where hire_date > '2011-01-11' order by hire_date;

/*
	Exercise 3:
    Write a query to display the first name, last name and
    hire date of employees  hired between January 11, 2005 
    and January 11, 2011. 
    Sort the results according to when they were hired. 
*/

select first_name,last_name,hire_date from employee where hire_date BETWEEN '2005-01-11' AND '2011-01-11' order by hire_date;

/*
	Exercise 4:
    Write a query to display the first name, last name 
    and department id for all employees whose phone begins
    with '(212)'.
    Sort the output by department id and last name.
*/

select first_name, last_name, department_code from employee where phone_number like '(212)%' order by department_code, last_name;

/*
	Exercise 5:
		Write a query to display the equipment id, equipment name, 
		and equipment cost increased by 15% expressed as a whole number
		for all items with a cost higher than 100 dollars.
		Sort the results by the equipment id.
*/

select equipment_id, name, round(cost * 1.15) as increased_cost from equipment where equipment_cost > 100 order by equipmetn_id; -- if the cost is pre-increasing and should be above 100 bucks

select equipment_id, name, round(cost * 1.15) as increased_cost from equipment where increased_cost > 100 order by equipmetn_id; -- if the cost is pro-increasing and should be above 100 bucks

/*
	Exercise 6:
    Write a query to display the first name, last name, hire date 
    and year on which the employee was hired.
    Sort the results by the year and last name.
*/

select first_name, last_name, hire_date, year(hire_date) as hire_year from employee order by hire_year, last_name;

/*
	Exercise 7:
    Write a query to display the first name, last name
    and hire date for all employees. 
    Sort the data by hire date in descending order and
    last name in ascending order.
*/

select first_name, last_name, hire_date from employee order by hire_date desc, last_name asc;

/*
	Exercise 8:
    Write a query to display all columns
    for the employee who joined the company first.
    Do not hard-code any filter. 
*/

select * from employee where hire_date = (select min(hire_date) from employee);

/*
	Exercise 9:
    Write a query to display the department code and
    the minimum and maximum hire dates for each department.
*/

select department_code, min(hire_date) as min_hire_date, max(hire_date) as max_hire_date from employee group by department_code;

/*
	Exercise 10:
    Write a query to display the training id
    and number of trainers for each training course
	with more than one trainer.
*/

select training_id, count(trainer_code) as no_of_trainers from trainer group by training_id having count(trainer_code) > 1;
