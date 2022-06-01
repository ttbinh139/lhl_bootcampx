/*
Get the total number of assistance_requests for a teacher.
Since this query needs to work with any specific teacher name, use 'Waylon Boehm' for the teacher's name here.
*/
SELECT teachers.name as name, count(assistance_requests.*) as total_number_of_assistance
FROM assistance_requests
JOIN teachers ON assistance_requests.teacher_id = teachers.id
WHERE teachers.name = 'Waylon Boehm'
GROUP BY teachers.name;

/*
Get the total number of assistance_requests for a student.
Since this query needs to work with any specific student name, use 'Elliot Dickinson' for the student's name here.
*/

SELECT students.name as name, count(assistance_requests.*) as total_assistance_requests
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
WHERE students.name = 'Elliot Dickinson'
GROUP BY students.name;

/*
Get important data about each assistance request.
Select the teacher's name, student's name, assignment's name, and the duration of each assistance request.
Subtract completed_at by started_at to find the duration.
Order by the duration of the request.
*/

SELECT teachers.name as teacher_name, students.name as student_name, assignments.name as assignment_name, (assistance_requests.completed_at - assistance_requests.started_at) as duration
FROM assistance_requests
JOIN teachers ON assistance_requests.teacher_id = teachers.id
JOIN students ON assistance_requests.student_id = students.id
JOIN assignments ON assistance_requests.assignment_id = assignments.id
ORDER BY duration;

/*
Get the average time of an assistance request.
*/
SELECT avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_request_duration
FROM assistance_requests;

/*
Get the average duration of assistance requests for each cohort.
*/
SELECT cohorts.name as cohort_name, avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_request_duration
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY average_assistance_request_duration;

/*
Get the cohort with the longest average duration of assistance requests.
*/
SELECT cohorts.name as cohort_name, avg(assistance_requests.completed_at - assistance_requests.started_at) as average_assistance_request_duration
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY average_assistance_request_duration DESC
LIMIT 1;

/*
Calculate the average time it takes to start an assistance request.
*/
SELECT avg(assistance_requests.started_at - assistance_requests.created_at) as average_waiting_time
FROM assistance_requests;


/*
Get the total duration of all assistance requests for each cohort.
*/
SELECT cohorts.name as cohort_name, sum(assistance_requests.completed_at - assistance_requests.started_at) as total_duration
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY total_duration;

/*
Calculate the average total duration of assistance requests for each cohort.
*/

SELECT avg(total_duration) as average_total_duration
FROM (SELECT cohorts.name as cohort_name, sum(assistance_requests.completed_at - assistance_requests.started_at) as total_duration
  FROM assistance_requests
  JOIN students ON assistance_requests.student_id = students.id
  JOIN cohorts ON students.cohort_id = cohorts.id
  GROUP BY cohorts.name
  ORDER BY total_duration) as total_duration;

/*
List each assignment with the total number of assistance requests with it. 
*/
SELECT assignments.id, assignments.day, assignments.chapter, assignments.name, count(assistance_requests.*) as total_assistance_requests
FROM assignments
JOIN assistance_requests ON assistance_requests.assignment_id = assignments.id
GROUP BY assignments.id;

/*
Get each day with the total number of assignments and the total duration of the assignments.
Select the day, number of assignments, and the total duration of assignments.
Order the results by the day.
*/

SELECT assignments.day, count(assignments.*) as number_of_assignments, sum(assignments.duration) as total_duration
FROM assignments
GROUP BY assignments.day
ORDER BY assignments.day;

/*
Get the name of all teachers that performed an assistance request during a cohort.
This query needs to select data for a cohort with a specific name, use 'JUL02' for the cohort's name here.
*/

SELECT DISTINCT teachers.name as teacher_name, cohorts.name as cohort_name
FROM teachers
JOIN assistance_requests ON assistance_requests.teacher_id = teachers.id
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
ORDER BY teachers.name;

/*
Perform the same query as before, but include the number of assistances as well.
*/
SELECT teachers.name as teacher_name, cohorts.name as cohort_name, count(assistance_requests.*) as total_assistancs
FROM teachers
JOIN assistance_requests ON assistance_requests.teacher_id = teachers.id
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teachers.name;
