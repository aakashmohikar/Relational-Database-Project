# for retrieving number of doctors assigned to a particular patient
SELECT p.patient_id, first_name as patient_fname, last_name as patient_lname, count(p.patient_id) as "Number of doctors assigned" FROM user20DB3.appointment as a
inner join employees as e
on a.emp_id = e.emp_id
inner join patients as p
on a.patient_id = p.patient_id
inner join users as u
on p.user_id = u.user_id
GROUP BY p.patient_id;

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving number of patients assigned to a particular doctor
SELECT a.emp_id, emp_fname, emp_lname, u.role, count(a.emp_id) as "number of patients assigned"  FROM user20DB3.appointment as a
inner join employees as e
on a.emp_id = e.emp_id
inner join patients as p
on a.patient_id = p.patient_id
inner join users as u
on e.user_id = u.user_id
group by a.emp_id; 

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving occupancy rate 

CREATE INDEX avail_idx ON wards(availability);

select 
	(SELECT count(availability) as "number_of_rooms_occupied" FROM user20DB3.wards
	where availability = 'Occupied') /
    (SELECT count(availability) as "number_of_rooms_available" FROM user20DB3.wards
	where availability = 'Available') as OCCUPANCY_RATE;

-------------------------------------------------------------------------------------------------------------------------------------

# Which employees have not been assigned to any appointments?

CREATE INDEX emp_id_idx ON  employees(emp_id); 

SELECT emp_id, emp_fname, emp_lname FROM employees 
WHERE emp_id NOT IN 
	(SELECT emp_id FROM appointment);

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving the details of all patients and their assigned wards.
SELECT p.patient_id, w.ward_id, date_of_admission, charges
FROM patients p
INNER JOIN wards w 
ON p.ward_id = w.ward_id;

CREATE VIEW patient_ward_info as
SELECT p.patient_id, w.ward_id, date_of_admission, charges
FROM patients p
INNER JOIN wards w 
ON p.ward_id = w.ward_id;

-- This view was created for several reasons as follows:
-- 1) Security - Views can be used to restrict access to certain data 
-- in a table by granting access to the view rather than the underlying table. 
-- In order to hide sensitive inofrmation such as patient's blood group and illness views can come handy
-- 2)Simplification - Views can simplify complex queries by combining data from multiple tables and presenting it in a single virtual table.
-- 3)Maintenance: Views can make it easier to maintain consistency and accuracy of data

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving the first name, last name, role and email address of all employees along with their corresponding user details.
SELECT e.emp_fname, e.emp_lname, u.email, u.role
FROM employees e
INNER JOIN users u 
ON e.user_id = u.user_id;

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving patients with total number of medicines more than 5
SELECT p.patient_id, first_name as patient_fname, last_name as patient_lname, sum(m.medicine_quantity) as total_number_of_medicines 
FROM user20DB3.medicines_assigned as m
inner join patients p
on m.patient_id = p.patient_id
inner join users as u
on p.user_id = u.user_id
group by p.patient_id
having total_number_of_medicines > 5;

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving the details of all patients who are assigned to wards with charges greater than $5000.

CREATE INDEX patient_ward_charges_idx ON wards(charges);

SELECT p.*, w.charges
FROM patients p
INNER JOIN wards w ON p.ward_id = w.ward_id
WHERE w.charges > 5000;

-------------------------------------------------------------------------------------------------------------------------------------

# for retrieving the details of all medicines assigned to patients along with the first name and last name of the corresponding patients.
SELECT u.first_name, u.last_name, ma.patient_id, ma.med_id, m.med_name
FROM medicines_assigned ma
INNER JOIN medicines m ON ma.med_id = m.med_id
INNER JOIN patients p ON ma.patient_id = p.patient_id
INNER JOIN users u ON p.user_id = u.user_id;
