-- 1. List employee number, last name, first name, sex and salary of each employee

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries AS s ON s.emp_no = e.emp_no;

-- 2. List first name, last name and hire date for employees hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department along with their department number, department name, 
-- employee number, last name and first name

SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON d.dept_no = dm.dept_no;

-- 4. List department number for each employee and that employee's employee number, last name,
-- first name and department name

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-- 5. List the first name, last name and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department including employee number, last name and first name

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

-- 7. List each employee in the Sales and Development departments, including their employee number, last name,
-- first name and department name

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names
-- (that is, how many employees share each last name)

SELECT last_name, COUNT(*) AS last_name_frequency_count
FROM employees
GROUP BY last_name
ORDER BY last_name_frequency_count DESC;