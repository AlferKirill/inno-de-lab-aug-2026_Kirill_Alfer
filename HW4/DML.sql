INSERT INTO Employees (FirstName, LastName, Department, Salary) VALUES
('Oleg', 'Ivanov', 'Finance', 75000.00),
('Kate', 'Titova', 'HR', 51000.00); 
SELECT * FROM Employees

SELECT FirstName, LastName FROM Employees where 
Department = 'IT'

UPDATE Employees 
SET Salary = 65000.00
WHERE FirstName = 'Alice'AND LastName = 'Smith'

DELETE FROM Employees
WHERE FirstName = 'Eve' AND LastName = 'Davis'

SELECT * FROM Employees