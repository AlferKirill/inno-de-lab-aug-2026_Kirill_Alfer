SELECT 
    c.Category,
    c.ClassName,
    COUNT(f.AttendanceID) AS TotalBookings,  -- Общее количество записей на занятие
    COUNT(DISTINCT f.ClientID) AS UniqueClients, -- Количество уникальных клиентов
    ROUND(COUNT(f.AttendanceID)::NUMERIC / COUNT(DISTINCT f.ClientID), 2) AS AvgSessionsPerClient, -- Среднее число сеансов на 1 клиента
    ROUND(AVG(f.IsAttended) * 100, 2) AS AttendanceRate -- Процент посещаемости (сколько записавшихся реально пришли)
FROM FactAttendance f
JOIN DimClass c ON f.ClassID = c.ClassID -- Присоединяем справочник занятий, чтобы получить названия и категории
WHERE f.Status != 'отменена' -- Исключаем отменённые записи 
GROUP BY c.Category, c.ClassName
ORDER BY TotalBookings DESC  -- Сортируем от самого популярного к менее популярному
LIMIT 10; -- Показываем только топ 10 занятий
