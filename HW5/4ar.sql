SELECT 
    d.DayName AS DayOfWeek,
    c.Category,
    c.ClassName,
    COUNT(f.AttendanceID) AS TotalBookings,  -- Всего записей на это занятие
    SUM(CASE WHEN f.Status = 'не явился' THEN 1 ELSE 0 END) AS NoShows, -- Количество неявок
    SUM(CASE WHEN f.Status = 'отменена' THEN 1 ELSE 0 END) AS Cancellations, -- Количество отмен
    ROUND(SUM(CASE WHEN f.Status = 'не явился' THEN 1 ELSE 0 END)::NUMERIC / COUNT(f.AttendanceID) * 100, 2) AS NoShowRate, -- % неявок
    ROUND(SUM(CASE WHEN f.Status = 'отменена' THEN 1 ELSE 0 END)::NUMERIC / COUNT(f.AttendanceID) * 100, 2) AS CancellationRate -- % отмен
FROM FactAttendance f
JOIN DimDate d ON f.DateID = d.DateID -- Присоединяем календарь для дня недели
JOIN DimClass c ON f.ClassID = c.ClassID -- Присоединяем занятия для категории и названия
GROUP BY d.DayName, c.Category, c.ClassName, d.DayOfWeek
HAVING COUNT(f.AttendanceID) > 10 -- Показываем только занятия с > 10 записями (статистическая значимость)
ORDER BY NoShowRate DESC -- Сортируем по % неявок (самые проблемные — сверху)
LIMIT 10;  -- Показываем только топ 10 проблемных занятий
