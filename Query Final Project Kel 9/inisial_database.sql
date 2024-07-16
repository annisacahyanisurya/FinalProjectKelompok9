CREATE DATABASE EmployeeMS

USE EmployeeMS;
GO

CREATE TABLE Employees (
    employee_id INT IDENTITY(100,1) PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    email VARCHAR(40) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary INT NOT NULL,
    manager_id INT,
    department_id INT,
    CONSTRAINT FK_Employee_Job FOREIGN KEY (job_id) REFERENCES Jobs(JOB_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Employee_Manager FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (department_id) REFERENCES tbl_department(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Jobs (
    JOB_ID VARCHAR(10) PRIMARY KEY,
    JOB_TITLE VARCHAR(50) NOT NULL,
    MIN_SALARY INT,
    MAX_SALARY INT
);

CREATE TABLE Accounts (
    employee_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    otp INT,
    is_expired DATETIME,
    is_used BIT,
    CONSTRAINT FK_Account_Employee FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE Job_Histories (
    employee_id INT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(10) NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id INT
);

ALTER TABLE Job_Histories
ADD CONSTRAINT FK_JobHistories_Employee 
FOREIGN KEY (employee_id) 
REFERENCES Employees(employee_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- Create Table Departments
CREATE TABLE tbl_department(
	id INT IDENTITY(10,10) PRIMARY KEY, 
	name VARCHAR(35) NOT NULL, 
	location INT NOT NULL
);
GO

-- Foreign Key location department
ALTER TABLE tbl_department
ADD CONSTRAINT FK_Department_Locations
FOREIGN KEY (location) REFERENCES tbl_locations(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- Create tabel Locations
CREATE TABLE tbl_locations(
	id INT IDENTITY(1000, 100) PRIMARY KEY, 
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL, 
	state_province VARCHAR(25),
	country CHAR(3)
);
GO
-- Foreign key location
ALTER TABLE tbl_locations
ADD CONSTRAINT FK_Locations_Countries
FOREIGN KEY (country) REFERENCES tbl_countries(id)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

-- Create table Country
CREATE TABLE tbl_countries(
	id CHAR(3) PRIMARY KEY, 
	name VARCHAR(40) NOT NULL, 
	region INT NOT NULL
);
GO

-- Foreign key Region Country
ALTER TABLE tbl_countries
ADD CONSTRAINT FK_Countries_Regions
FOREIGN KEY (region) REFERENCES regions(region_id)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

CREATE TABLE regions(
	region_id int IDENTITY(1,1) PRIMARY KEY,
	region_name varchar(25) NOT NULL
);

CREATE TABLE roles(
	role_id int IDENTITY(1,1) PRIMARY KEY,
	role_name varchar(50) NOT NULL
);

CREATE TABLE permissions(
	permission_id int IDENTITY(1,1) PRIMARY KEY,
	permission_name varchar(100) NOT NULL
);

CREATE TABLE role_permissions(
	role_permission_id int IDENTITY(1,1) PRIMARY KEY,
	role int,
	permission int
	CONSTRAINT FK_Role FOREIGN KEY (role) REFERENCES roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Permission FOREIGN KEY (permission) REFERENCES permissions(permission_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE account_roles(
	id int IDENTITY(1,1) PRIMARY KEY,
	account int,
	role int
	CONSTRAINT FK_Account FOREIGN KEY (account) REFERENCES Accounts(employee_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_RoleAccount FOREIGN KEY (role) REFERENCES Roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE loans(
	id int IDENTITY(1000,1) PRIMARY KEY,
	employee_id int,
	total_loan int,
	loan_date date,
	payment_date date,
	due_date date,
	status varchar,
	days_late int
	CONSTRAINT FK_LoanEmployee FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE penalty(
	id INT PRIMARY KEY,
	penalty_amount DECIMAL
	CONSTRAINT FK_PenaltyLoan FOREIGN KEY (id) REFERENCES loans(id) ON UPDATE CASCADE ON DELETE CASCADE
);