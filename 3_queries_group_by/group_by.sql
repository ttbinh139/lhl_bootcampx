/*
Get the total number of assignments for each day of bootcamp.
*/
SELECT day, count(assignments) as total_assignments
FROM assignments
GROUP BY day;

/*
The same query as before, but only return rows where total assignments is greater than or equal to 10.
*/
SELECT day, count(assignments) as total_assignments
FROM assignments
GROUP BY day
HAVING count(assignments) >= 10;

/*
Get all cohorts with 18 or more students.
*/
SELECT cohorts.name, count(students.id) as number_of_students
FROM cohorts
JOIN students ON cohorts.id = students.cohort_id
GROUP BY cohorts.name
HAVING count(students.id) >= 18
ORDER BY number_of_students;

/*
Get the total number of assignment submissions for each cohort.
*/
SELECT cohorts.name, count(assignment_submissions.*) as total_assignments_submissions
FROM cohorts
JOIN students ON cohorts.id = students.cohort_id
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
GROUP BY cohorts.name;

/*
Get currently enrolled students' average assignment completion time.
*/
SELECT students.name, avg(assignment_submissions.duration)
FROM students
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
WHERE students.end_date IS NULL
GROUP BY students.name;

/*
Get the students who's average time it takes to complete an assignment is less than the average estimated time it takes to complete an assignment.
*/
SELECT students.name, avg(assignment_submissions.duration) as average_assignment_duration, avg(assignments.duration) as average_estimated_duration
FROM students
JOIN assignment_submissions ON students.id = assignment_submissions.student_id
JOIN assignments ON assignments.id = assignment_submissions.assignment_id
WHERE students.end_date IS NULL
GROUP BY students.name
HAVING avg(assignment_submissions.duration) < avg(assignments.duration)
ORDER BY average_assignment_duration;


