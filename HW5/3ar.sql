SELECT 
    d.DayName AS DayOfWeek,
    ti.Period,
    ti.Hour,
    COUNT(f.AttendanceID) AS BookingsCount,
    COUNT(DISTINCT f.ClientID) AS UniqueClients,
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ScheduleID), 2) AS AvgOccupancy
FROM FactAttendance f
JOIN DimDate d ON f.DateID = d.DateID
JOIN DimTime ti ON f.TimeID = ti.TimeID
WHERE f.Status != 'отменена'
GROUP BY d.DayName, ti.Period, ti.Hour, d.DayOfWeek
ORDER BY BookingsCount DESC
LIMIT 10;