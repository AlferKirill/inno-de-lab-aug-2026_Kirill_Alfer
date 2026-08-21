SELECT 
    t.FullName AS TrainerName,
    t.Specialization,
    COUNT(DISTINCT f.ScheduleID) AS SessionsConducted, -- Количество уникальных сеансов, которые провёл тренер
    COUNT(DISTINCT f.ClientID) AS UniqueClients, -- Количество уникальных клиентов, ходивших к этому тренеру
    COUNT(f.AttendanceID) AS TotalBookings, -- Общее количество записей на занятия тренера
    -- Метрики эффективности
    ROUND(AVG(f.IsAttended) * 100, 2) AS AvgAttendanceRate, -- Средний процент посещаемости занятий тренера
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ScheduleID), 2) AS AvgClientsPerSession -- Средняя заполняемость занятий тренера
FROM FactAttendance f 
JOIN DimTrainer t ON f.TrainerID = t.TrainerID  -- Присоединяем справочник тренеров
WHERE f.Status = 'посещена' OR f.Status = 'подтверждена' -- Учитываем только реальные записи (не отменённые)
GROUP BY t.TrainerID, t.FullName, t.Specialization -- Сортируем по посещаемости (от высокой к низкой)
ORDER BY AvgAttendanceRate DESC, SessionsConducted DESC; -- При равной посещаемости — по количеству сеансов
