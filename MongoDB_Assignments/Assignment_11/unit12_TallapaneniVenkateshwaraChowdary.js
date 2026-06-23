/*
  Exercise 1:
  Insert into the employee collection the
  documents in employee.json.
*/

db.employee.insertMany([
    {
        "_id": "e001",
        "first_name": "Andy",
        "last_name": "Wong",
        "phone_number": "(603) 555-6880",
        "address": "345 South Street",
        "hire_date": "2001-01-15",
        "department": {
            "department_code": "d002",
            "name": "Production"
        },
        "equipment": [
            {
                "equipment_id": 1,
                "equipment": "Notebook Computer",
                "cost": 1299.75
            }
        ]
    },
    {
        "_id": "e002",
        "first_name": "John",
        "last_name": "Wilson",
        "phone_number": "(518) 555-6690",
        "address": "560 Broadway",
        "hire_date": "2017-03-19",
        "department": {
            "department_code": "d001",
            "name": "Research & Development"
        },
        "equipment": [
            {
                "equipment_id": 1,
                "equipment": "Notebook Computer",
                "cost": 1299.75
            },
            {
                "equipment_id": 2,
                "equipment": "Computer Monitor",
                "cost": 248.39
            }
        ]
    },
    {
        "_id": "e003",
        "first_name": "Mike",
        "last_name": "Taylor",
        "phone_number": "(480) 532-6567",
        "address": "5212 Saint Croix Ct",
        "hire_date": "2003-11-14",
        "equipment": [
            {
                "equipment_id": 1,
                "equipment": "Notebook Computer",
                "cost": 1299.75
            }
        ]
    }
])

/*
  Exercise 2:
  Add to all the employee documents a training
  field with an array containing the trainings
  "Code of Conduct Training" and "Safety Training".
*/

db.employee.updateMany({}, { $set: { training: ["Code of Conduct Training", "Safety Training"] } })

/*
  Exercise 3:
  Change the second training in the training array
  to "COVID-19 Awareness Training" for employee "e002".
*/

db.employee.updateOne({ _id: "e002" }, { $set: { "training.1": "COVID-19 Awareness Training" } })

/*
  Exercise 4:
  Add to the training array of all employees the trainings
  "Sale Skills" and "COVID-19 Awareness Training".
  Each training must be added only if it is not already
  included in the array.
*/

db.employee.updateMany({}, { $addToSet: { training: { $each: ["Sale Skills", "COVID-19 Awareness Training"] } } })

/*
  Exercise 5:
  Add the training "Product Knowledge" to the training array
  of employee "e002". The resulting array must include
  only the 2 trainings most recently added.
*/

db.employee.updateOne({ "_id": "e002" }, { $push: { "training": {$each: ["Product Knowledge"], $slice: -2 }}})

/*
  Exercise 6:
  Add to the equipment array of employee "e003" the following
  embedded documents:
  [{"equipment_name": "Notebook Computer", "cost": 1299.75},
  {"equipment_name": "Computer Monitor", "cost": 248.39}]
  The documents must be sorted by cost in ascending order.
  Do not hard-code the sorting.
*/

db.employee.updateOne({ _id: "e003" }, { $push: { equipment: { $each: [{ equipment_name: "Notebook Computer", cost: 1299.75 }, { equipment_name: "Computer Monitor", cost: 248.39 }], $sort: { cost: 1 } } } })

/*
  Exercise 7:
  Change the equipment_name of the second element in the 
  equipment array of employee "e003" to "Personal Computer".
*/

db.employee.updateOne({ _id: "e003" }, { $set: { "equipment.1.equipment_name": "Personal Computer" } })

/*
  Exercise 8:
  Increase the cost of all "Notebook Computer" by 200.
*/

db.employee.updateMany({ "equipment.equipment_name": "Notebook Computer" }, { $inc: { "equipment.$[x].cost": 200 } }, { arrayFilters: [{ "x.equipment_name": "Notebook Computer" }] })


/*
  Exercise 9:
  Increase the cost of the "Notebook Computer" of employee
  "e001" by 500.
*/

db.employee.updateOne({ _id: "e001", "equipment.equipment_name": "Notebook Computer" }, { $inc: { "equipment.$.cost": 500 } })

/*
  Exercise 10:
  Update the "hire_date" to "2015-11-30" for employee
  "e004", "Rafael Gonzalez". If the employee does not exist
  insert a new document with the fields "_id", "first_name",
  "last_name" and "hire_date".
  Write only one single command.
*/

db.employee.updateOne({ _id: "e004" },{ $set: { hire_date: "2015-11-30" } },{ upsert: true, $setOnInsert: { first_name: "Rafael", last_name: "Gonzalez" } })
