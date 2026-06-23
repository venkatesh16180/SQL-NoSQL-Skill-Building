/*
	Exercise 1:
    Write a query to display the complete list of trainings (name)
    and trainers (first and last name as separate columns)
    available for each training.
    Sort the output by training name and trainers' last name. 
*/

select t.name as training_name, tr.first_name as trainer_first_name, tr.last_name as trainer_last_name from training t left outer join trainer tr on t.training_id = tr.training_id order by t.name, tr.last_name;

/*
	Exercise 2:
    Write a query to display the concatenation of the 
    trainer first name and their training names separated
    by ': ' (e.g. 'John: Intro to Python') 
    for trainers that did not provide their last name.
*/

select concat(tr.first_name,': ', t.name) as trainer_training from trainer tr inner join training t on tr.training_id = t.training_id where tr.last_name is null;

/*
	Exercise 3:
    Write a query to display the employee code, first name, last name,
    equipment name, and equipment cost for all of the employees.
    Sort the results by employee code.
*/

select e.employee_code,e.first_name,e.last_name,eq.name as equipment_name, eq.cost as equipment_cost from employee e inner join employee_equipment ee on e.employee_code = ee.employee_code inner join equipment eq on ee.equipment_id = eq.equipment_id order by e.employee_code;

/* 
	Exercise 4:
    Write a query to display the first name, last name
    and training name for the employee 'Tom Harper'.
    Sort the results by training name in descending order.
*/

select e.first_name, e.last_name, t.name as training_name from employee e inner join employee_training et on e.employee_code = et.employee_code inner join training t on et.training_id = t.training_id where e.first_name = 'Tom' and e.last_name = 'Harper' order by t.name desc;

/*
	Exercise 5:
    Write a query to display the distinct list of equipment names 
    used by the current employees.
    Sort the output by equipment name.
*/

select distinct eq.name as equipment_name from employee e inner join employee_equipment ee on e.employee_code = ee.employee_code inner join equipment eq on ee.equipment_id = eq.equipment_id order by eq.name;

/*
	Exercise 6:
    Write a query to display the employee code, first name, last name,
    training id and training name for employees of the following departments:
    'Sales and Marketing', 'Accounting and Finance' and 'Production'.
*/

select e.employee_code, e.first_name, e.last_name,t.training_id, t.name as training_name from employee e inner join department d on e.department_code = d.department_code inner join employee_training et on e.employee_code = et.employee_code inner join training t on et.training_id = t.training_id where d.name in ('Sales and Marketing', 'Accounting and Finance', 'Production');

/*
	Exercise 7:
    Write a query to display the employee code, first name, last name,
    department code and department name for all employess using 'Headsets'
    including those with no assigned department.
*/

select e.employee_code,e.first_name, e.last_name,d.department_code, d.name as department_name from employee e inner join employee_equipment ee on e.employee_code = ee.employee_code inner join equipment eq on ee.equipment_id = eq.equipment_id left outer join department d on e.department_code = d.department_code where eq.name = 'Headsets';

/*
	Exercise 8:
    Write a query to display the employee first name, last name and the
    number and total cost of equipment items used by each employee,
    including those not using any equipment.
*/

select e.first_name, e.last_name, count(eq.equipment_id) as equipment_count, coalesce(sum(eq.cost),0) as total_cost from employee e left outer join employee_equipment ee on e.employee_code = ee.employee_code left outer join equipment eq on ee.equipment_id = eq.equipment_id group by e.employee_code, e.first_name, e.last_name order by e.first_name, e.last_name;

/*
	Exercise 9:
    Write a query to display the first name and last name of employees
    that do not use any equipment and do not belong to any department.
*/

select e.first_name, e.last_name from employee e left outer join employee_equipment ee on e.employee_code = ee.employee_code left outer join department d on e.department_code = d.department_code where ee.equipment_id is null and d.department_code is null;

/*
	Exercise 10:
    Get the cartesian product of employees and trainings
    showing the employee's first name and last name, and the
    training name.
    Sort the results by employee last name in ascending order
    and training name in descending order.
*/

select e.first_name, e.last_name, t.name as training_name from employee e cross join training t order by e.last_name asc, t.name desc;



