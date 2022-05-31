/*
Get the total amount of time that a student has spent on all assignments.
This should work for any student but use 'Ibrahim Schimmel' for now.
*/
SELECT sum(duration)
FROM students
JOIN assignment_submissions
ON students.id = student_id
WHERE name = 'Ibrahim Schimmel';

/*
Get the total amount of time that all students from a specific cohort have spent on all assignments.
This should work for any cohort but use FEB12 for now.
*/
SELECT sum(duration)
FROM assignment_submissions
JOIN students ON assignment_submissions.student_id = students.id
JOIN cohorts ON students.cohort_id = cohorts.id
WHERE cohorts.name = 'FEB12';
