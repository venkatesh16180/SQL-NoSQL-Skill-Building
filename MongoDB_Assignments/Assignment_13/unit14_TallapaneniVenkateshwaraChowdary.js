/*
	Exercise 1:
	Write an aggregate pipeline that returns the department and equipment
	information of those employees that use "Headsets".
*/

db.employee.aggregate([
  {
    $match: {
      "equipment.equipment_name": "Headsets"
    }
  },
  {
    $project: {
      _id: 1,
      department: 1,
      equipment: 1
    }
  }
])


/*
	Exercise 2:
	Write an aggregate pipeline that returns the second training
	in the collection taught by a trainer named "Maria".
*/

db.training.aggregate([
  {
    $match: {
      "trainers.first_name": "Maria"
    }
  },
  {
    $sort: {
      _id: 1
    }
  },
  {
    $skip: 1
  },
  {
    $limit: 1
  }
])


/*
	Exercise 3:
	Write an aggregate pipeline that, for all the employees, returns
	the first name, last names and department name, sorted by
	the department name.
*/

db.employee.aggregate([
  {
    $project: {
      _id: 1,
      first_name: 1,
      last_name: 1,
      "department.department_name": 1
    }
  },
  {
    $sort: {
      "department.department_name": 1
    }
  }
])

/*
	Exercise 4:
	Write an aggregate pipeline that, for each employee belonging to
	the "Purchasing" or "Accounting and Finance" departments, returns
	the list of equipment names used by the employee.
	The returned documents must store the list of equipment names
	in the field "equipment_names" and must be sorted by the 
	employees' last names.

*/

db.employee.aggregate([
  {
    $match: {
      "department.department_name": {
        $in: ["Purchasing", "Accounting and Finance"]
      }
    }
  },
  {
    $project: {
      _id: 1,
      first_name: 1,
      last_name: 1,
      equipment_names: "$equipment.equipment_name"
    }
  },
  {
    $sort: {
      last_name: 1
    }
  }
])

/*
	Exercise 5:
	Write an aggregate pipeline that pairs every training name with
	the first name of each of its trainer, i.e., if a training is taught
	by two trainers, the pipeline should return two separate documents.

*/

db.training.aggregate([
  {
    $unwind: "$trainers"
  },
  {
    $project: {
      _id: 1,
      name: 1,
      trainer_first_name: "$trainers.first_name"
    }
  }
])

/*
	Exercise 6:
	Write an aggregate pipeline that returns every equipment name with
	its cost for all employees hired before "2014-01-01".
	Each equipment name and cost pair must be returned as an individual
	document.
*/

db.employee.aggregate([
  {
    $match: {
      hire_date: {
        $lt: ISODate("2014-01-01T00:00:00.000Z")
      }
    }
  },
  {
    $unwind: "$equipment"
  },
  {
    $project: {
      _id: 1,
      equipment_name: "$equpiment.equipment_name",
      equipment_cost: "$equipment.cost"
    }
  }
])

/*
	Exercise 7:
	Write an aggregate pipeline that returns for each employee the
	list of equipment that costs less than 100 dollars.
	The resulting documents must store this list  in a "cheap_equipment"
	field.
	Filter out those cases where the list is empty.
*/

db.employee.aggregate([
  {
    $project: {
      _id: 1,
      cheap_equipment: {
        $filter: {
          input: "$equipment",
          as: "e",
          cond: {
            $lt: ["$$e.cost", 100]
          }
        }
      }
    }
  },
  {
    $match: {
      cheap_equipment: {
        $ne: []
      }
    }
  }
])

/*
	Exercise 8:
	Write an aggregate pipeline that returns each department name
	with the last date when an employee was hired for that department.
	Do not take into account employees that do not belong not 
	any department.

*/

db.employee.aggregate([
  {
    $match: {
      department: {
        $ne: null
      }
    }
  },
  {
    $group: {
      _id: "$department.department_code",
      last_hire_date: {
        $max: "$hire_date"
      }
    }
  }
])


/*
	Exercise 9:
	Write an aggregate pipeline that returns each equipement_id 
	with the list of phone numbers of all employees using the
	equipment.

*/

db.employee.aggregate([
  {
    $unwind: "$equipment"
  },
  {
    $group: {
      _id: "$equipment.equipment_id",
      phone_numbers: {
        $push: "$phone_number"
      }
    }
  }
])

/*
	Exercise 10:
	Write an aggregate pipeline that return the first name,
	last name and training information for each employee.
	Note: the training information does not limit to the
	training id.
*/


db.employee.aggregate([
  {
    $lookup: {
      from: "training",
      localField: "training",
      foreignField: "_id",
      as: "training_information"
    }
  },
  {
    $project: {
      _id: 1,
      first_name: 1,
      last_name: 1,
      training_information: 1
    }
  }
])