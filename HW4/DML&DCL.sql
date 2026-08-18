UPDATE Employees 
SET Salary = Salary * 1.1
WHERE Department = 'HR'

UPDATE Employees 
SET Department = 'Senior_IT'
WHERE Salary > 70000.00

DELETE FROM Employees e
WHERE NOT EXISTS (
     SELECT 1
     FROM EmployeeProjects ep
     WHERE ep.EmployeeID = e.EmployeeID
);


BEGIN;

INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate) 
VALUES ('AI Integration', 180000.00, '2024-01-15', '2024-08-30');

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) 
VALUES 
    (2, (SELECT MAX(ProjectID) FROM Projects), 150), 
    (4, (SELECT MAX(ProjectID) FROM Projects), 120); 

SELECT 
    e.FirstName,
    e.LastName,
    p.ProjectName,
    ep.HoursWorked
FROM EmployeeProjects ep
JOIN Employees e ON ep.EmployeeID = e.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID
WHERE p.ProjectName = 'AI Integration';

COMMIT;