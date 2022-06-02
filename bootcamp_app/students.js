const {Pool} = require('pg')

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

// let query = "SELECT * FROM students LIMIT 5;";
//let query = "SELECT students.id as student_id, students.name as name, cohorts.name as cohort FROM students JOIN cohorts ON cohorts.id = cohort_id LIMIT 5;"

let cohortName = process.argv[2];
let maximumResult = process.argv[3];

let query = ` SELECT students.id as student_id, students.name as name, cohorts.name as cohort
FROM students
JOIN cohorts ON cohorts.id = cohort_id
WHERE cohorts.name LIKE '%${cohortName}%'
LIMIT ${maximumResult || 5};`

pool.query(query).then(res => {
  //console.log(res.rows);
  res.rows.forEach(user => {
    console.log(`${user.name} has an id of ${user.student_id} and was in the ${user.cohort} cohort`);
  })
}).catch(err => {
  console.log('query error: ', err);
})

