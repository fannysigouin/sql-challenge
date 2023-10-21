ERD

WITH REL 

departments
rel dept_manager
rel dept_emp
-
dept_no INT PK
dept_name VARCHAR

dept_manager
rel employees
-
dept_no INT FK - departments.dept_no
emp_no INT FK - employees.emp_no

dept_emp
rel employees
-
dept_no INT FK >- departments.dept_no
emp_no INT

employees
rel salaries
rel titles
-
emp_no INT PK
emp_title_id INT FK >- titles.title_id
birth_date DATE
first_name VARCHAR
last_name VARCHAR
sex TEXT
hire_date DATE

salaries
-
emp_no INT FK - employees.emp_no
salary FLOAT

titles
-
title_id INT PK
title VARCHAR

WITHOUT REL

departments
-
dept_no INT PK
dept_name VARCHAR

dept_manager
-
dept_no INT FK >- departments.dept_no
emp_no INT FK - employees.emp_no

dept_emp
-
dept_no INT FK >- departments.dept_no
emp_no INT FK >- employees.emp_no

employees
-
emp_no INT PK
emp_title_id INT FK >- titles.title_id
birth_date DATE
first_name VARCHAR
last_name VARCHAR
sex TEXT
hire_date DATE

salaries
-
emp_no INT FK - employees.emp_no
salary FLOAT

titles
-
title_id INT PK
title VARCHAR