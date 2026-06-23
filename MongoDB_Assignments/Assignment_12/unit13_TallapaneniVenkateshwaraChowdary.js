/*
  Exercise 1:
  Count the number of employees assigned
  to some department.
*/

db.employee.countDocuments({ "department": { $exists: true } });

/*
  Exercise 2:
  Get the trainers of the training "Machine Learning".
*/

db.training.find({ "name": "Machine Learning" }, { "trainers": 1, "_id": 1 });

/*
  Exercise 3:
  Count the employees hired between the year 2010
  and the year 2016 both included.
*/

db.employee.countDocuments({ "hire_date": { $gte: ISODate("2010-01-01"), $lte: ISODate("2016-12-31") } });

/*
  Exercise 4:
  Get the employees' phone numbers that do not end in 0.
*/

db.employee.find({ "phone_number": { $not: /0$/ } }, { "phone_number": 1, "_id": 1 });

/*
  Exercise 5:
  Get the address of employees that live in a street with 
  a name that stars with "S".
*/

db.employee.find({ "address": { $regex: /^(?:\d+\s+)?S/ } }, { "address": 1, "_id": 1 });

/*
  Exercise 6: 
  Get the name of trainings that are taught by
  only 1 trainer.
*/

db.training.find({ "trainers": { $size: 1 } }, { "name": 1, "_id": 1 });

/*
  Exercise 7:
  Count the number of employees from the department
  "Research & Development" that have a "Computer Monitor".
*/

db.employee.countDocuments({ "department.department_name": "Research & Development", "equipment.equipment_name": "Computer Monitor" });

/*
  Exercise 8:
  Get the names of trainings taught by a trainer with 
  the last name "Garcia" or "Smith".
*/

db.training.find({ "trainers.last_name": { $in: ["Garcia", "Smith"] } }, { "name": 1, "_id": 1 });

/*
  Exercise 9:
  Get the first name and last name of employees that take the
  trainings with id 1 and 7.
*/

db.employee.find({ "trainings": { $in: [1, 7] } }, { "first_name": 1, "last_name": 1, "_id": 1 });

/*
  Exercise 10:
  Get the equipment of each employee that has a cost
  between 500 and 5000.
*/

db.employee.find({ "equipment.cost": { $gte: 500, $lte: 5000 } }, { "equipment": 1, "_id": 1 });
