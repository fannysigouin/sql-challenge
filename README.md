# sql-challenge

## Background

It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

This challenge is divided into three parts: data modeling, data engineering, and data analysis.

### Data Modeling 

An entity relationship diagram was created using QuickDB to map out the database and its tables:
![challenge_db_ERD](https://github.com/fannysigouin/sql-challenge/assets/136189686/4d7ea71a-10d0-43a9-9ced-0460b6f4d3ca)

### Data Engineering

The six tables in the database were created to import the corresponding CSV files, specifying data types, primary and foreign keys, and other constraints.

```
-- Drop tables if they already exist
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Create tables and import CSV files

CREATE TABLE departments (
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(50)
);

CREATE TABLE titles (
	title_id VARCHAR(10) NOT NULL PRIMARY KEY,
	title VARCHAR(50)
);

CREATE TABLE employees (
	emp_no INTEGER NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(10),
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex TEXT NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(10) NOT NULL,
	emp_no INTEGER NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(10) NOT NULL
);

CREATE TABLE salaries (
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL
);

-- Add foreign key constraints after importing CSV files

ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_dept_no 
FOREIGN KEY (dept_no)
REFERENCES departments(dept_no);

ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_dept_no
FOREIGN KEY (dept_no)
REFERENCES departments(dept_no);

ALTER TABLE salaries
ADD CONSTRAINT fk_salaries_emp_no
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_title_id
FOREIGN KEY (emp_title_id)
REFERENCES titles(title_id);
```

### Data Analysis

With the complete database and tables, the following queries were created:

1. List the employee number, last name, first name, sex, and salary of each employee.
```
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries AS s ON s.emp_no = e.emp_no;
```
![Screenshot 2023-10-21 at 10 47 50 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/e0e87fdd-a54e-4390-9925-ca3fddf35821)

2. List the first name, last name, and hire date for the employees who were hired in 1986.
```
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
```
![Screenshot 2023-10-21 at 10 48 35 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/3c06bab4-3513-4508-a7e3-85ba139c2718)

3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
```
SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON d.dept_no = dm.dept_no;
```
![Screenshot 2023-10-21 at 10 49 09 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/26683215-e6c0-4ad8-a885-8d9646db3e48)

4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
```
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;
```
![Screenshot 2023-10-21 at 10 49 42 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/3951b718-f08f-43fd-b9de-6cd312a86bb0)

5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
```
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
```
![Screenshot 2023-10-21 at 10 50 14 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/2df48752-50a1-413a-a3c2-8f01110d47ff)

6. List each employee in the Sales department, including their employee number, last name, and first name.
```
SELECT emp_no, last_name, first_name
FROM employees e
WHERE e.emp_no IN
	(
		SELECT de.emp_no
		FROM dept_emp de
		WHERE de.dept_no IN
			(
				SELECT d.dept_no
				FROM departments d
				WHERE d.dept_name = 'Sales'
			)
	);
```
![Screenshot 2023-10-21 at 10 51 07 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/df03968e-146e-4311-a242-026f0a00f55d)

7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';
```
![Screenshot 2023-10-21 at 10 51 42 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/74ee3b3f-3f67-4c2c-9a37-13587f1ee27c)

8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
```
SELECT last_name, COUNT(*) AS last_name_frequency_count
FROM employees
GROUP BY last_name
ORDER BY last_name_frequency_count DESC;
```
![Screenshot 2023-10-21 at 10 52 15 AM](https://github.com/fannysigouin/sql-challenge/assets/136189686/8c3834c1-fa53-461d-8a3d-68c784aab622)
