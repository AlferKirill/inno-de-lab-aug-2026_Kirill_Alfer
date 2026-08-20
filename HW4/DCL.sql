CREATE USER hr_user WITH PASSWORD '123';
CREATE ROLE hruser;
GRANT SELECT ON Employees TO hruser;

GRANT hruser TO hr_user;



SET ROLE hr_user;

SELECT * FROM Employees;

RESET ROLE;

SET ROLE hr_user;

INSERT INTO Employees (FirstName, LastName, Department, Salary, Email) 
VALUES ('Test', 'User', 'IT', 70000.00, 'test.user@company.com');

RESET ROLE;

GRANT INSERT, UPDATE ON Employees TO hruser;

GRANT USAGE, SELECT ON SEQUENCE employees_employeeid_seq TO hr_user;

SET ROLE hr_user;

INSERT INTO Employees (FirstName, LastName, Department, Salary, Email) 
VALUES ('Test', 'User', 'IT', 70000.00, 'test2.user@company.com');