/*
  Exercise 1:
  Create an index that supports an application that frequently
  searches for employees by the name of the equipment they use
  but only for employees that belong to the "IT Support" department.
*/

db.employee.createIndex(
  { "equipment.equipment_name": 1 },
  { partialFilterExpression: { department: "IT Support" } }
);

/*
  Exercise 2:
  Create an index that supports an application that frequently
  sorts employees by hired date in descending order but only
  for employees hired after "2010-01-01".
*/

db.employee.createIndex(
  { hire_date: -1 },
  { partialFilterExpression: { hire_date: { $gt: new Date("2010-01-01") } } }
);

/*
  Exercise 3:
  Create an index that supports an application that frequently
  searches for employees by their first and last names.
*/

db.employee.createIndex(
  { first_name: 1, last_name: 1 }
);

/*
  Exercise 4:
  Create an index that supports an application that frequently
  searches for employees who have equipment whose cost is in
  a range of values and sorts the results by the equipment name.
*/

db.employee.createIndex(
  { "equipment.cost": 1, "equipment.equipment_name": 1 }
);

/*
  Exercise 5:
  Create an index that supports an application that frequently
  searches for employees by their department name and sorts
  the results by their last name.
*/

db.employee.createIndex(
  { department: 1, last_name: 1 }
);

/*
  Exercise 6:
  Create an index that supports an application that frequently
  searches for employees that are hired within a given date range
  and by their department name.
*/

db.employee.createIndex(
  { hire_date: 1, department: 1 }
);

/*
  Exercise 7:
  Create an index that supports an application that frequently
  searches for employees by checking if their address contains
  keywords such as "Street" or "Road".
*/

db.employees.createIndex(
  { address: "text" }
);

/*
  Exercise 8:
  Create an index that supports an application that frequently
  searches for training by their trainer info.
  Take into account that each trainer can be included with
  different fields in different documents.
*/

db.training.createIndex(
  { trainer: 1 }
);

/*
  Exercise 9:
  Create an index that supports an application that frequently
  searches for employees by their phone number.
  Take into account that the phone number can be missing for many
  employees and we don't want to waste disk space.
*/

db.employee.createIndex(
  { phone_number: 1 },
  { sparse: true }
);

/*
  Exercise 10:
  Create an index prevent duplicates pairs of last name and address.
*/

db.employee.createIndex(
  { last_name: 1, address: 1 },
  { unique: true }
);


