SELECT 
    c.Category,
    c.ClassName,
    COUNT(f.AttendanceID) AS TotalBookings,
    COUNT(DISTINCT f.ClientID) AS UniqueClients,
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ClientID), 2) AS AvgSessionsPerClient,
    ROUND(AVG(f.IsAttended) * 100, 2) AS AttendanceRate
FROM FactAttendance f
JOIN DimClass c ON f.ClassID = c.ClassID
WHERE f.Status != 'отменена'
GROUP BY c.Category, c.ClassName
ORDER BY TotalBookings DESC
LIMIT 10;