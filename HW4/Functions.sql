CREATE OR REPLACE FUNCTION CalculateAnnualBonus (
    p_employee_id INT,
    p_salary DECIMAL
)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$ 
DECLARE 
    v_bonus DECIMAL;
BEGIN
    v_bonus := p_salary * 0.1;
    RETURN v_bonus;
END;
$$;

SELECT 
    EmployeeID, FirstName, LastName, Department, Salary,
    CalculateAnnualBonus(EmployeeID, Salary) AS annual_bonus
FROM Employees


CREATE OR REPLACE VIEW IT_Department_View AS
SELECT 
    EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE Department = 'Senior_IT';

SELECT * FROM IT_Department_View;