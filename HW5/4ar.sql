SELECT 
    d.DayName AS DayOfWeek,
    c.Category,
    c.ClassName,
    COUNT(f.AttendanceID) AS TotalBookings,
    SUM(CASE WHEN f.Status = 'не явился' THEN 1 ELSE 0 END) AS NoShows,
    SUM(CASE WHEN f.Status = 'отменена' THEN 1 ELSE 0 END) AS Cancellations,
    ROUND(SUM(CASE WHEN f.Status = 'не явился' THEN 1 ELSE 0 END)::NUMERIC / COUNT(f.AttendanceID) * 100, 2) AS NoShowRate,
    ROUND(SUM(CASE WHEN f.Status = 'отменена' THEN 1 ELSE 0 END)::NUMERIC / COUNT(f.AttendanceID) * 100, 2) AS CancellationRate
FROM FactAttendance f
JOIN DimDate d ON f.DateID = d.DateID
JOIN DimClass c ON f.ClassID = c.ClassID
GROUP BY d.DayName, c.Category, c.ClassName, d.DayOfWeek
HAVING COUNT(f.AttendanceID) > 10
ORDER BY NoShowRate DESC
LIMIT 10;