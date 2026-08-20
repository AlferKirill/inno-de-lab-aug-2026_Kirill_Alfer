# 1. ОПИСАНИЕ БИЗНЕС-ПРОЦЕССА

**Бизнес-процесс:** Управление записью клиентов на групповые тренировки в фитнес-клубе.

## Что происходит:
1. Клиент выбирает тренировку (дата, время, тренер, зал).
2. Клиент записывается на конкретный сеанс.
3. Клиент посещает (или не посещает) тренировку.
4. Система фиксирует факт посещения/отмены/неявки.

### Ключевые вопросы бизнеса:
- Сколько клиентов записалось на каждое занятие?
- Какие занятия самые популярные?
- Какая заполняемость залов в разное время?
- Какова загрузка тренеров?
- Сколько клиентов приходит, а сколько не является?

---

# 2. УРОВЕНЬ ДЕТАЛИЗАЦИИ

**GRAIN:** ОДНА СТРОКА = ОДНА ЗАПИСЬ КЛИЕНТА НА ОДИН КОНКРЕТНЫЙ СЕАНС

> Каждая строка таблицы `FactAttendance` представляет собой факт записи одного клиента на один сеанс групповой тренировки, с указанием статуса (подтверждена, отменена, посещена, не явился).

---

# 3. ТАБЛИЦЫ ИЗМЕРЕНИЙ И ТАБЛИЦА ФАКТОВ

## Идентификация таблиц:
1. **FactAttendance** (Таблица фактов)
2. **DimClient** (Измерение "Клиенты")
3. **DimTrainer** (Измерение "Тренеры")
4. **DimClass** (Измерение "Групповые занятия")
5. **DimSchedule** (Измерение "Расписание сеансов")
6. **DimDate** (Измерение "Календарь")
7. **DimTime** (Измерение "Время")

---

## Проектирование таблиц:

### **FactAttendance**

**Описание:**
Центральная таблица фактов в звёздообразной схеме. Хранит информацию о каждом событии записи клиента на групповую тренировку. Каждая строка представляет собой факт записи одного клиента на один конкретный сеанс тренировки с указанием статуса и числовых показателей для анализа.

**Атрибуты:**
- `AttendanceID` (INTEGER, PK, NOT NULL, UNIQUE)
- `ClientID` (INTEGER, FK (REFERENCES DimClient), NOT NULL)
- `TrainerID` (INTEGER, FK (REFERENCES DimTrainer), NOT NULL)
- `ClassID` (INTEGER, FK (REFERENCES DimClass), NOT NULL)
- `ScheduleID` (INTEGER, FK (REFERENCES DimSchedule), NOT NULL)
- `DateID` (INTEGER, FK (REFERENCES DimDate), NOT NULL)
- `TimeID` (INTEGER, FK (REFERENCES DimTime), NOT NULL)
- `BookingDate` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `Status` (VARCHAR(20), DEFAULT 'подтверждена', CHECK(Status IN ('подтверждена', 'отменена', 'посещена', 'не явился')))
- `BookingPlatform` (VARCHAR(20))
- `IsAttended` (INTEGER, DEFAULT 0)
- `WasLate` (INTEGER, DEFAULT 0)
- `ClientAgeAtBooking` (INTEGER)
- `DurationMinutesActual` (INTEGER)

**Ограничения:**
- `PK_FactAttendance`: PRIMARY KEY (`AttendanceID`)
- `FK_FactAttendance_Client`: FOREIGN KEY (`ClientID`) REFERENCES `DimClient(ClientID)`
- `FK_FactAttendance_Trainer`: FOREIGN KEY (`TrainerID`) REFERENCES `DimTrainer(TrainerID)`
- `FK_FactAttendance_Class`: FOREIGN KEY (`ClassID`) REFERENCES `DimClass(ClassID)`
- `FK_FactAttendance_Schedule`: FOREIGN KEY (`ScheduleID`) REFERENCES `DimSchedule(ScheduleID)`
- `FK_FactAttendance_Date`: FOREIGN KEY (`DateID`) REFERENCES `DimDate(DateID)`
- `FK_FactAttendance_Time`: FOREIGN KEY (`TimeID`) REFERENCES `DimTime(TimeID)`
- `CHK_FactAttendance_Status`: CHECK (`Status IN ('подтверждена', 'отменена', 'посещена', 'не явился')`)
- `CHK_FactAttendance_IsAttended`: CHECK (`IsAttended IN (0, 1)`)
- `CHK_FactAttendance_WasLate`: CHECK (`WasLate IN (0, 1)`)

---

### **DimClient**

**Описание:**
Хранит информацию о клиентах фитнес-клуба. Содержит демографические данные, информацию об абонементе и сегментации клиентов. Используется для анализа поведения клиентов, их лояльности, удержания и предпочтений.

**Атрибуты:**
- `ClientID` (INTEGER, PK, NOT NULL, UNIQUE)
- `FullName` (VARCHAR(100), NOT NULL)
- `FirstName` (VARCHAR(50), NOT NULL)
- `LastName` (VARCHAR(50), NOT NULL)
- `Phone` (VARCHAR(20), NOT NULL, UNIQUE)
- `Email` (VARCHAR(100), UNIQUE)
- `Gender` (VARCHAR(10))
- `DateOfBirth` (DATE)
- `AgeGroup` (VARCHAR(20))
- `RegistrationDate` (DATE)
- `MembershipType` (VARCHAR(20))
- `MembershipExpiry` (DATE)
- `ClientStatus` (VARCHAR(20), DEFAULT 'активен')
- `ClientSegment` (VARCHAR(20))
- `IsActive` (BOOLEAN, DEFAULT TRUE)

**Ограничения:**
- `PK_DimClient`: PRIMARY KEY (`ClientID`)
- `UQ_DimClient_Phone`: UNIQUE (`Phone`)
- `UQ_DimClient_Email`: UNIQUE (`Email`)

---
---

### **DimTrainer**

**Описание:**
Хранит информацию о тренерах фитнес-клуба. Содержит данные о специализации, стаже работы и активности. Используется для оценки загрузки тренеров, их популярности и эффективности.

**Атрибуты:**
- `TrainerID` (INTEGER, PK, NOT NULL, UNIQUE)
- `FullName` (VARCHAR(100), NOT NULL)
- `FirstName` (VARCHAR(30), NOT NULL)
- `LastName` (VARCHAR(30), NOT NULL)
- `Phone` (VARCHAR(20), NOT NULL, UNIQUE)
- `Specialization` (VARCHAR(100))
- `HireDate` (DATE)
- `CareerStartDate` (DATE)
- `ExperienceYears` (INTEGER)
- `IsActive` (BOOLEAN, DEFAULT TRUE)
- `Rating` (DECIMAL(3,2))

**Ограничения:**
- `PK_DimTrainer`: PRIMARY KEY (`TrainerID`)
- `UQ_DimTrainer_Phone`: UNIQUE (`Phone`)
- `CHK_DimTrainer_Experience`: CHECK (`ExperienceYears >= 0`)
- `CHK_DimTrainer_HireDate`: CHECK (`HireDate <= CURRENT_DATE`)
- `CHK_DimTrainer_CareerStart`: CHECK (`CareerStartDate <= HireDate`)

---
---

### **DimClass**

**Описание:**
Хранит справочную информацию о типах групповых тренировок, доступных в фитнес-клубе. Содержит категории занятий, уровень сложности, длительность и вместимость. Используется для анализа популярности различных типов занятий.

**Атрибуты:**
- `ClassID` (INTEGER, PK, NOT NULL, UNIQUE)
- `ClassName` (VARCHAR(100), NOT NULL, UNIQUE)
- `Description` (TEXT)
- `Category` (VARCHAR(50))
- `DifficultyLevel` (VARCHAR(20))
- `DurationMinutes` (INTEGER)
- `MaxCapacity` (INTEGER)
- `Intensity` (VARCHAR(20))
- `ClassType` (VARCHAR(20), DEFAULT 'Групповое')

**Ограничения:**
- `PK_DimClass`: PRIMARY KEY (`ClassID`)
- `UQ_DimClass_ClassName`: UNIQUE (`ClassName`)
- `CHK_DimClass_Duration`: CHECK (`DurationMinutes > 0`)
- `CHK_DimClass_Capacity`: CHECK (`MaxCapacity > 0`)

---
---

### **DimSchedule**

**Описание:**
Хранит информацию о конкретных сеансах групповых тренировок. Каждый сеанс привязан к определённому типу занятия, тренеру, залу и временному слоту. Используется для анализа заполняемости залов и загрузки тренеров.

**Атрибуты:**
- `ScheduleID` (INTEGER, PK, NOT NULL, UNIQUE)
- `ClassID` (INTEGER, FK (REFERENCES DimClass), NOT NULL)
- `TrainerID` (INTEGER, FK (REFERENCES DimTrainer), NOT NULL)
- `Room` (VARCHAR(30), NOT NULL)
- `StartTime` (TIMESTAMP, NOT NULL)
- `EndTime` (TIMESTAMP, NOT NULL)
- `MaxCapacity` (INTEGER, DEFAULT 15)
- `IsCancelled` (BOOLEAN, DEFAULT FALSE)
- `CancellationReason` (VARCHAR(100))

**Ограничения:**
- `PK_DimSchedule`: PRIMARY KEY (`ScheduleID`)
- `FK_DimSchedule_Class`: FOREIGN KEY (`ClassID`) REFERENCES `DimClass(ClassID)`
- `FK_DimSchedule_Trainer`: FOREIGN KEY (`TrainerID`) REFERENCES `DimTrainer(TrainerID)`
- `CHK_DimSchedule_Time`: CHECK (`StartTime < EndTime`)
- `CHK_DimSchedule_Capacity`: CHECK (`MaxCapacity > 0`)

---
---

### **DimDate**

**Описание:**
Календарное измерение для временного анализа. Содержит все необходимые атрибуты даты, включая год, квартал, месяц, день недели, сезон и флаги праздников/выходных. Используется для анализа сезонности и трендов.

**Атрибуты:**
- `DateID` (INTEGER, PK, NOT NULL, UNIQUE)
- `Date` (DATE, NOT NULL)
- `Year` (INTEGER, NOT NULL)
- `Quarter` (INTEGER, NOT NULL)
- `Month` (INTEGER, NOT NULL)
- `MonthName` (VARCHAR(20), NOT NULL)
- `DayOfMonth` (INTEGER, NOT NULL)
- `DayOfWeek` (INTEGER, NOT NULL)
- `DayName` (VARCHAR(20), NOT NULL)
- `WeekNumber` (INTEGER, NOT NULL)
- `IsWeekend` (BOOLEAN, NOT NULL)
- `IsHoliday` (BOOLEAN, DEFAULT FALSE)
- `HolidayName` (VARCHAR(100))
- `Season` (VARCHAR(20), NOT NULL)

**Ограничения:**
- `PK_DimDate`: PRIMARY KEY (`DateID`)

---
---

### **DimTime**

**Описание:**
Временное измерение для анализа распределения событий в течение дня. Содержит атрибуты времени, включая час, минуту, период дня и флаги для категоризации времени суток. Используется для определения часов пик и оптимизации расписания.

**Атрибуты:**
- `TimeID` (INTEGER, PK, NOT NULL, UNIQUE)
- `Time` (TIME, NOT NULL)
- `Hour` (INTEGER, NOT NULL)
- `Minute` (INTEGER, NOT NULL)
- `Period` (VARCHAR(20))
- `IsMorning` (BOOLEAN, DEFAULT FALSE)
- `IsAfternoon` (BOOLEAN, DEFAULT FALSE)
- `IsEvening` (BOOLEAN, DEFAULT FALSE)
- `IsNight` (BOOLEAN, DEFAULT FALSE)

**Ограничения:**
- `PK_DimTime`: PRIMARY KEY (`TimeID`)
- `CHK_DimTime_Hour`: CHECK (`Hour BETWEEN 0 AND 23`)
- `CHK_DimTime_Minute`: CHECK (`Minute BETWEEN 0 AND 59`)

---
---
---

# 4. АНАЛИТИЧЕСКИЕ ПРИМЕРЫ

## №1
**Бизнес-вопрос:** Какие групповые занятия наиболее популярны среди клиентов? Какие категории занятий привлекают больше всего участников?
**Зачем нужно:** Для планирования расписания, расширения популярных направлений и оптимизации загрузки тренеров.

## №2
**Бизнес-вопрос:** Какой тренер проводит больше всего занятий? У кого самая высокая посещаемость и какие тренеры пользуются наибольшей популярностью у клиентов?
**Зачем нужно:** Для оценки эффективности тренеров, планирования нагрузки, премирования и выявления лучших специалистов.

## №3
**Бизнес-вопрос:** В какое время суток и в какие дни недели клиенты наиболее активны? Какие временные слоты самые популярные для записи?
**Зачем нужно:** Для оптимизации расписания, эффективного использования залов и распределения рабочего времени тренеров.

## №4
**Бизнес-вопрос:** Сколько клиентов не приходят на записанные занятия? Какие факторы влияют на неявки (день недели, время, тип занятия, сегмент клиента)?
**Зачем нужно:** Для снижения потерь, оптимизации заполняемости, разработки стратегии напоминаний и управления очередью.