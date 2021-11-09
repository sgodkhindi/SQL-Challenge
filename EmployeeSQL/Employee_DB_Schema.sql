-- Drop Table Dept_Emp;
-- Drop Table Dept_Manager;
-- Drop Table Salaries;
-- DROP TABLE Department;
-- Drop Table Employees;
-- DROP TABLE Titles;

-- Create schemas

-- Create tables
CREATE TABLE IF NOT EXISTS Department
(
    Dept_No VARCHAR(4) NOT NULL,
    Dept_Name VARCHAR(25),
    PRIMARY KEY(Dept_No)
);

CREATE TABLE IF NOT EXISTS Dept_Emp
(
    Employees_Emp_No INTEGER NOT NULL,
	Department_Dept_No VARCHAR(4) NOT NULL,
    PRIMARY KEY(Department_Dept_No, Employees_Emp_No)
);

CREATE TABLE IF NOT EXISTS Employees
(
    Emp_No INTEGER NOT NULL,
    Emp_Title_ID VARCHAR(5),
    Birth_Date DATE,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Sex VARCHAR(1),
    Hire_Date DATE,
    PRIMARY KEY(Emp_No)
);

CREATE TABLE IF NOT EXISTS Salaries
(
    Employees_Emp_No INTEGER NOT NULL,
    Salary DECIMAL(8, 2),
    PRIMARY KEY(Employees_Emp_No)
);

CREATE TABLE IF NOT EXISTS Titles
(
    Title_ID VARCHAR(5) NOT NULL,
    Title VARCHAR(25),
    PRIMARY KEY(Title_ID)
);

CREATE TABLE IF NOT EXISTS Dept_Manager
(
    Department_Dept_No VARCHAR(4) NOT NULL,
    Employees_Emp_No INTEGER NOT NULL,
    PRIMARY KEY(Department_Dept_No, Employees_Emp_No)
);


-- Create FKs
ALTER TABLE Dept_Emp
    ADD    FOREIGN KEY (Department_Dept_No)
    REFERENCES Department(Dept_No)
 ;
    
ALTER TABLE Dept_Emp
    ADD    FOREIGN KEY (Employees_Emp_No)
    REFERENCES Employees(Emp_No)
   ;
    
ALTER TABLE Salaries
    ADD    FOREIGN KEY (Employees_Emp_No)
    REFERENCES Employees(Emp_No)
  ;
    
ALTER TABLE Employees
    ADD    FOREIGN KEY (Emp_Title_ID)
    REFERENCES Titles(Title_ID)
 ;
    
ALTER TABLE Dept_Manager
    ADD    FOREIGN KEY (Department_Dept_No)
    REFERENCES Department(Dept_No)
  ;
    
ALTER TABLE Dept_Manager
    ADD    FOREIGN KEY (Employees_Emp_No)
    REFERENCES Employees(Emp_No)
;
    

--- Queries

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp_no, last_name, first_name, sex, salary FROM employees 
	JOIN salaries
	ON employees.emp_no = salaries.employees_emp_no

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
	WHERE DATE_PART('YEAR', hire_date) = 1986

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT department.dept_no as Dept_No, department.dept_name as Dept_Name, dept_manager.emp_no as Manager_EmpNo, last_name as Manager_LastName, first_name as Manager_FirstName
	FROM dept_manager
	JOIN department 
	ON dept_manager.department_dept_no = department.dept_no
	JOIN employees
	ON dept_manager.employees_emp_no = employees.emp_no
		

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, department.dept_name FROM employees
	JOIN dept_emp
	ON employees.emp_no = dept_emp.employees_emp_no
	JOIN department
	ON dept_emp.department_dept_no = department.dept_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT  first_name, last_name, sex FROM employees
	WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, department.dept_name FROM employees
	JOIN dept_emp
	ON employees.emp_no = dept_emp.employees_emp_no
	JOIN department
	ON dept_emp.department_dept_no = department.dept_no
	WHERE department.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, department.dept_name FROM employees
	JOIN dept_emp
	ON employees.emp_no = dept_emp.employees_emp_no
	JOIN department
	ON dept_emp.department_dept_no = department.dept_no
	WHERE department.dept_name IN ('Sales','Development');

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS Last_Name_Count FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC


