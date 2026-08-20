SELECT 
    d.DayName AS DayOfWeek,
    ti.Period,
    ti.Hour,
    COUNT(f.AttendanceID) AS BookingsCount,  -- Количество записей в этот час
    COUNT(DISTINCT f.ClientID) AS UniqueClients, -- Количество уникальных клиентов
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ScheduleID), 2) AS AvgOccupancy -- Средняя заполняемость зала
FROM FactAttendance f
JOIN DimDate d ON f.DateID = d.DateID -- Присоединяем календарь для получения дня недели
JOIN DimTime ti ON f.TimeID = ti.TimeID  -- Присоединяем время для получения часа и периода
WHERE f.Status != 'отменена' -- Исключаем отменённые записи
GROUP BY d.DayName, ti.Period, ti.Hour, d.DayOfWeek
ORDER BY BookingsCount DESC-- Сортируем по популярности (от самого популярного слота)
LIMIT 10; -- Показываем только топ 10 временных слотов
