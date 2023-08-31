DROP TABLE departments;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE department_emp;
DROP TABLE department_manager;
DROP TABLE titles;

CREATE TABLE departments(
	dept_no VARCHAR(30) PRIMARY KEY NOT NULL,
	dept_names VARCHAR(30) NOT NULL
	);

CREATE TABLE titles(
    title_id VARCHAR(30) PRIMARY KEY NOT NULL,
    title VARCHAR(30) NOT NULL
);

CREATE TABLE employees(
    emp_no INT PRIMARY KEY NOT NULL,
    emp_title_id VARCHAR(30) NOT NULL,
    birth_date VARCHAR(30) NOT NULL,
    first_name VARCHAR(30) NOT NULL, 
    last_name VARCHAR(30) NOT NULL,
    sex VARCHAR(30) NOT NULL,
    hire_date VARCHAR(30) NOT NULL
);

CREATE TABLE salaries(
    emp_no INT NOT NULL,
    salary INT NOT NULL
);

ALTER TABLE salaries
ADD PRIMARY KEY(emp_no, salary);

CREATE TABLE department_emp(
    emp_no INT NOT NULL,
    dept_no VARCHAR(30) 
);

CREATE TABLE department_manager(
    dept_no VARCHAR(30) not null,
    emp_no INT NOT NULL
);

ALTER TABLE department_manager
ADD PRIMARY KEY(dept_no, emp_no);

SELECT * FROM department_emp
SELECT * FROM department_manager
SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- 1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
LEFT JOIN salaries as s
ON e.emp_no = s.emp_no; 

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986'

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT m.dept_no, d.dept_names, m.emp_no, e.last_name, e.first_name
FROM department_manager AS m
LEFT JOIN employees AS e
ON m.emp_no = e.emp_no 
LEFT JOIN departments AS d
ON m.dept_no = d.dept_no

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_names
FROM employees AS e
LEFT JOIN department_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON d.dept_no = de.dept_no

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT de.emp_no, e.last_name, e.first_name
FROM department_emp AS de
LEFT JOIN employees AS e
ON e.emp_no = de.emp_no
WHERE dept_no=
(SELECT dept_no
FROM departments
WHERE dept_names = 'Sales')

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_names
FROM department_emp AS de
LEFT JOIN employees AS e
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE de.dept_no=
(SELECT d.dept_no
FROM departments AS d
WHERE d.dept_names = 'Sales' OR d.dept_names = 'Development')


-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(emp_no)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;