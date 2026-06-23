/*
	Exercise 1:
    Write a query to list all the first name
    and last name of all employees and trainers.
*/

SELECT first_name, last_name FROM employee
UNION
SELECT first_name, last_name FROM trainer;

/*
	Exercise 2:
	Write a query to list all the last names
    of employess not belonging to any department
    that are not last names of trainers.
*/

SELECT last_name
FROM employee e
WHERE department_code IS NULL
AND NOT EXISTS (SELECT last_name FROM trainer t WHERE t.last_name = e.last_name);

/*
	Exercise 3:
	Write a query to list all the last names
    of employess from the 'Customer Service'
    department that are also last names of trainers.
*/

SELECT last_name FROM employee
WHERE department_code = (
    SELECT department_code 
    FROM department 
    WHERE name = 'Customer Service'
)
AND last_name IN (
    SELECT last_name 
    FROM trainer
);

/*
	Exercise 4:
	Using subqueires, get the employee code, first name
    and last name of those employees whose last name
    matches the last name of a trainer.
*/

SELECT employee_code, first_name, last_name FROM employee
WHERE last_name IN (
    SELECT last_name
    FROM trainer
);

/*
	Exercise 5:
	Using subqueires, get the employee code, first name
    and last name of those employees whose last name
    does not match the last name of any other employee.
*/

SELECT employee_code, first_name, last_name FROM employee
WHERE last_name NOT IN (
    SELECT last_name
    FROM employee
    GROUP BY last_name
    HAVING COUNT(*) > 1
);

/*
	Exercise 6:
	Using subqueires, get the employee code, first name
    and last name of those employees that participate in 
    a training with a least another employee.
*/

SELECT e.employee_code, e.first_name, e.last_name FROM employee e
WHERE e.employee_code IN (
    SELECT et.employee_code FROM employee_training et
    WHERE et.training_id IN (
        SELECT training_id FROM employee_training
        GROUP BY training_id
        HAVING COUNT(employee_code) > 1
    )
);

/*
	Exercise 7:
	Using subqueires, get the employee code, first name
    and last name of those employees that where hired at least
    365 days after any other employee.
*/

SELECT employee_code, first_name, last_name FROM employee e1
WHERE NOT EXISTS (
    SELECT * FROM employee e2
    WHERE e2.hire_date < e1.hire_date
    AND DATEDIFF(e1.hire_date, e2.hire_date) < 365
);

/*
	Exercise 8:
    Write a query to display the first name,
    last name and phone number of all the employees.
    If the employee does not have a phone number
    print 'Unknown Number' instead.
*/

SELECT first_name, last_name, COALESCE(phone_number, 'Unknown Number') AS phone_number FROM employee;

/*
	Exercise 9:
    Write a query to display the first name,
    last name and column named 'category' that will
    contain the value "Senior" if the employee was hired
    before 2010 and "Junior" otherwise.
*/

SELECT first_name, last_name,
    CASE 
        WHEN hire_date < '2010-01-01' THEN 'Senior' 
        ELSE 'Junior' 
    END AS category
FROM employee;

/*
	Exercise 10:
	Get how many equipment items belong to 
    'Tier 1', 'Tier 2', and 'Tier 3' where
    'Tier 1' corresponds to equipment with cost >= 1000,
    'Tier 2' corresponds to equipment with 1000 > cost >= 100
    and 'Tier 3' corresponds to equipment with cost < 100.
*/

SELECT 
    CASE 
        WHEN cost >= 1000 THEN 'Tier 1' 
        WHEN cost >= 100 THEN 'Tier 2' 
        ELSE 'Tier 3' 
    END AS tier,
    COUNT(*) AS equipment_count
FROM equipment
GROUP BY tier;
