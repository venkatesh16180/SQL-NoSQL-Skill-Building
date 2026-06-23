DELIMITER $$
/*
	Exercise 1:
    Create a trigger check_name on the table department
    that activates after updating a department.
    If the name of the department has changed,
    the trigger must unlink every employee that
    belonged to such department.
*/

CREATE TRIGGER check_name
AFTER UPDATE ON department
FOR EACH ROW
BEGIN
    IF OLD.name != NEW.name THEN
        DELETE FROM employee
        WHERE department_code = OLD.department_code;
    END IF;
END$$

/*
	Exercise 2:
	Create a trigger named check_quota on the table
    employee_equipment that activates when new
    employee-equipment pairs are inserted.
    The trigger must check if the total equipment cost
    for the employee plus the new equipment is higher
    than 7000. In that case, instead of inserting the 
    new pair, throw an exception with the message
    "Quota excededed by employee_code".
*/

CREATE TRIGGER check_quota
BEFORE INSERT ON employee_equipment
FOR EACH ROW
BEGIN
    DECLARE total_cost DECIMAL(13,2);
    
    SELECT SUM(e.cost) INTO total_cost FROM employee_equipment ee
    JOIN equipment e ON ee.equipment_id = e.equipment_id
    WHERE ee.employee_code = NEW.employee_code;

    SET total_cost = IFNULL(total_cost, 0) + (SELECT cost FROM equipment WHERE equipment_id = NEW.equipment_id);

    IF total_cost > 7000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 
			'Quota exceeded by employee_code';
    END IF;
END$$

/*
	Exercise 3:
    Create a procedure named new_training that
    takes a new training name and an existing
    trainer code as input.
    The procedure must insert the training into
    the training table and assign trainer to
    this new training.
*/

CREATE PROCEDURE new_training(IN training_name VARCHAR(50), IN existing_trainer_code INT)
BEGIN    
    DECLARE new_training_id INT;
    
    INSERT INTO training (name) VALUES (training_name);
    
    SET new_training_id = LAST_INSERT_ID();
	-- we are updating the table instead of inserting to assign because each trainer can only train one training. if that were not the case i would have inserted a new row in the trainer with the trainer training the new training.
	UPDATE trainer 
    SET training_id = new_training_id
    WHERE trainer_code = existing_trainer_code;
    
END$$

/*
	Exercise 4:
    Create a function named count_trainings that takes
    as input a department name and returns the total
    of trainings assigned to all its employees.
*/

CREATE FUNCTION count_trainings(department_name VARCHAR(30)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_trainings INT;

    SELECT COUNT(*) INTO total_trainings FROM employee_training et
    JOIN employee e ON et.employee_code = e.employee_code
    WHERE e.department_code = (SELECT department_code FROM department WHERE name = department_name);

    RETURN total_trainings;
END$$

/*
	Exercise 5:
    Create a function named closest_hire that takes
    a date as input and returns the employee code
    of the employee that was hired the closest to that date.
    If no employee was hired after the input date
    the function must return NULL.
*/

CREATE FUNCTION closest_hire(hire_date_input DATE) RETURNS CHAR(5)
READS SQL DATA
BEGIN
    DECLARE closest_employee_code CHAR(5);
    
    SELECT employee_code INTO closest_employee_code FROM employee
    WHERE hire_date > hire_date_input
    ORDER BY hire_date ASC
    LIMIT 1;

    RETURN closest_employee_code;
END$$