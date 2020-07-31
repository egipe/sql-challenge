-- create deparments table
CREATE TABLE departments (
	dept_no VARCHAR(20) NOT NULL,
	PRIMARY KEY (dept_no),
	dept_name VARCHAR(40) NOT NULL
);

-- create employees table
CREATE TABLE employees (
	emp_no VARCHAR (20) NOT NULL,
	PRIMARY KEY (emp_no),
	emp_title_id VARCHAR (20) NOT NULL,
	birth_date VARCHAR (20) NOT NULL,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	sex VARCHAR (5) NOT NULL,
	hire_date VARCHAR (10) NOT NULL
);

-- create table titles
CREATE TABLE titles (
	title_id VARCHAR (10) NOT NULL,
	PRIMARY KEY (title_id),
	title VARCHAR (30) NOT NULL
);

-- Junction table for dept_emp
CREATE TABLE dept_emp (
	emp_no VARCHAR (10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR (10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

--Junction table for dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR (10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no VARCHAR (10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, dept_no)
);
	
-- create salaries table
CREATE TABLE salaries (
	emp_no VARCHAR (10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	salary VARCHAR (30) NOT NULL,
	PRIMARY KEY (emp_no, salary)
);

select * from employees;

-- List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.hire_date
FROM employees e
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from dept_manager dm
INNER JOIN departments d
ON dm.dept_no = d.dept_no
INNER JOIN employees e
ON dm.emp_no = e.emp_no

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no

-- List first name, last name, and sex for employees 
-- whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) 
FROM employees
GROUP BY last_name 
ORDER BY count DESC;

-- Search your ID number 499942
Select * from employees
WHERE emp_no = '499942'
