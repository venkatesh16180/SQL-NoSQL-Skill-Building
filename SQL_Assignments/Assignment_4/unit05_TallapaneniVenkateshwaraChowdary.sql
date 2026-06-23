/* 
	Exercise 1: 
    Create a database called `business` if it does not exist.
*/

CREATE DATABASE IF NOT EXISTS business;
use business;

/*
	Exercise 2: 
    Create the `department` table in the `business` database
	based on the Physical Data Model provided in business_pdm.png.
*/

CREATE TABLE IF NOT EXISTS department (
	department_code CHAR(5),
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (department_code)
 );

/*
	Exercise 3:
    Create the `employee` table in the `business` database 
    based on the Physical Data Model provided in business_pdm.png. 
*/

CREATE TABLE IF NOT EXISTS employee (
	employee_code CHAR(5),
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(50),
    phone_number VARCHAR(15),
    hire_date DATE,
    department_code CHAR(5) NULL,
    PRIMARY KEY (employee_code),
    FOREIGN KEY (department_code) REFERENCES department (department_code),
    INDEX fk_employee_department_idx (department_code)
 );

/*
	Exercise 4:
    Create the `training` table in the `business` database 
	based on the Physical Data Model provided in business_pdm.png.
*/

CREATE TABLE IF NOT EXISTS training (
	training_id INT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (training_id)
 );

/*
	Exercise 5:
    Create the `employee_training` table in the `business` database
	based on the Physical Data Model provided in business_pdm.png.
    If a row of a parent table is deleted, the corresponding records
    in the `employee_training` table should be automatically deleted.
*/

CREATE TABLE IF NOT EXISTS employee_training (
	employee_code CHAR(5),
    training_id INT,
    PRIMARY KEY (employee_code,training_id),
    FOREIGN KEY (employee_code) REFERENCES employee (employee_code),
    FOREIGN KEY (training_id) REFERENCES  training (training_id),
    INDEX fk_employee_training_training_idx (training_id)
);

/*
	Exercise 6:
    Write a single query to insert into the `department` table the complete set of data 
    provided in business_data.xlsx for that table.
*/

INSERT INTO department VALUES 
	("d001", "Research & Development"),
    ("d002", "Production"),
    ("d003", "IT Support"),
    ("d004", "Operations"),
    ("d005", "Customer Service"),
    ("d006", "Purchasing"),
    ("d007", "Sales and Marketing"),
    ("d008", "Human Resource Management"),
    ("d009", "Accounting and Finance"),
    ("d010", "Legal Department");

/*
	Exercise 7:
    Write a single query to insert into the `employee` table the complete set of data 
    provided in business_data.xlsx for that table.
*/

INSERT INTO employee VALUES
	("e001", "Andy", "Wong", "345 South Street", "(603) 555-6880", '2001-01-15', "d002"),
    ("e002", "John", "Wilson", "560 Broadway", "(518) 555-6690", '2017-03-19', "d001"),
    ("e003", "Mike", "Taylor", "5212 Saint Croix Ct", "(480) 532-6567", '2003-11-14', NULL),
    ("e004", "Vivek", "Pandey", "15 Mineral Drive", "(603) 555-4420", '2003-11-15', "d003"),
    ("e005", "Nola", "Davis", "15 Long Ave", "(478) 555-8822", '2016-03-23', "d007"),
    ("e006", "Kathy", "Cooper", "15 Hatter Drive", "(212) 555-9630", '2011-03-18', "d008"),
    ("e007", "Tom", "Harper", "64 Highland Street", "(212) 555-7755", '2010-03-11', "d009");

/*
	Exercise 8:
    Write a query to make NULL the address for all the employees.
*/

UPDATE employee SET address=NULL;

/*
	Exercise 9:
    Write a query to modify the phone number to '(XXX) XXX-XXXX' 
    for all the employees hired in 2003-11-15.
*/

UPDATE employee SET phone_number='(XXX) XXX-XXXX' WHERE hire_date = '2003-11-15';

/*
	Exercise 10:
    Write a query to delete the employees with that do not belong
    to any department.
*/

DELETE FROM employee WHERE department_code IS NULL;