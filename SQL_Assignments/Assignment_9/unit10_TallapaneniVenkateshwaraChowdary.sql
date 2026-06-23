-- select host,user from mysql.user; -- checking the users and hosts available on our server
-- show grants for dummy_user;
-- drop user dummy_user;
-- CREATE USER dummy_user identified by 'password'; -- creating the dummy_user user.
/*
	Exercise 1:
	Grant the required privileges to user dummy_user
    so that the user can run procedures on the
    database business.
*/

GRANT EXECUTE ON business.* TO dummy_user;

/*
	Exercise 2:
    User dummy_user can run all procederues on the
    database business. Make the user unable to
    run procedure new_training.
*/

-- GRANT EXECUTE ON business.* TO dummy_user; -- granting dummy_user privilege to run all the procedures in business

-- I couldnt revoke because of error code 1144 so i granted user the privilege explicitly before revoking it.
-- GRANT EXECUTE ON PROCEDURE business.new_training TO dummy_user;
REVOKE EXECUTE ON PROCEDURE business.new_training FROM dummy_user;

/*
	Exercise 3:
    User dummy_user can retrieve data from all tables
    in database business. Make the user unable to
    get data from table trainer.
*/

-- GRANT SELECT ON business.* TO dummy_user; -- Granting all tables privilege to retrieve the data

-- Same here for this revoke statment running into Error Code 1147. So I granted it select privilege explicitly before revoking
-- GRANT SELECT ON business.trainer TO dummy_user;
REVOKE SELECT ON business.trainer FROM dummy_user;

/*
	Exercise 4:
    Give user dummy_user give user all privileges 
    required to manage the data on table equipment.
*/

GRANT SELECT, INSERT, UPDATE, DELETE ON business.equipment TO 'dummy_user'@'%';

/*
	Exercise 5:
    Allow user dummy_user to create new tables
    on database business.
*/

GRANT CREATE ON business.* TO dummy_user;

/*
	Exercise 6:
    User dummy_user has privielges to create 
    any object on database business. Make the
    user unable to create views.
*/

-- GRANT CREATE ON business.* TO dummy_user; -- granting dummy_user any object on database business

-- Similar Error for this revoke statement (Error code 1141). So I explicitly granted it the privilege before revoking it
-- GRANT CREATE VIEW ON business.* TO dummy_user;
REVOKE CREATE VIEW ON business.* FROM dummy_user;

/*
	Exercise 7:
    Allow user dummy_user to use triggers on
    table employee.
*/

GRANT TRIGGER ON business.employee TO dummy_user;

/*
	Exercise 8:
	User dummy_user has all privielges to manage
    the data on table training. Make the user only
    able to insert new rows.
*/

-- GRANT ALTER,CREATE,DELETE,DROP,INDEX,INSERT,SELECT,TRIGGER ON business.training TO dummy_user; -- granting all the privileges needed for managing the training table
-- GRANT ALL ON business.training TO dummy_user; 
REVOKE ALL ON business.training FROM dummy_user; -- surprisingly this command of revoking all the privileges ran without any error
GRANT INSERT ON business.training TO dummy_user;

/*
	Exercise 9:
	Allow user dummy_user to create or drop indexes
    on table training.
*/

GRANT ALTER ON business.training TO dummy_user;

/*
	Exercise 10:
	Give all privileges to user dummy_user to manage
    routines on database business when the user
    logins from host 121.111.456.987
*/

-- CREATE USER 'dummy_user'@'121.111.456.987' IDENTIFIED BY '1234';
GRANT ALTER ROUTINE, CREATE ROUTINE ON business.* TO 'dummy_user'@'121.111.456.987';