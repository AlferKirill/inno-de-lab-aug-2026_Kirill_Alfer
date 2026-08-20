SELECT 
    t.FullName AS TrainerName,
    t.Specialization,
    COUNT(DISTINCT f.ScheduleID) AS SessionsConducted,
    COUNT(DISTINCT f.ClientID) AS UniqueClients,
    COUNT(f.AttendanceID) AS TotalBookings,
    ROUND(AVG(f.IsAttended) * 100, 2) AS AvgAttendanceRate,
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ScheduleID), 2) AS AvgClientsPerSession
FROM FactAttendance f
JOIN DimTrainer t ON f.TrainerID = t.TrainerID
WHERE f.Status = 'посещена' OR f.Status = 'подтверждена'
GROUP BY t.TrainerID, t.FullName, t.Specialization
ORDER BY AvgAttendanceRate DESC, SessionsConducted DESC;