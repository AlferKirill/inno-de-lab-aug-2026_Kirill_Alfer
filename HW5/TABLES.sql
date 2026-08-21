-- ТАБЛИЦЫ ИЗМЕРЕНИЙ (DIMENSIONS)

-- 1.1 DimClient
CREATE TABLE DimClient (
    ClientID SERIAL PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    AgeGroup VARCHAR(20),
    RegistrationDate DATE,
    MembershipType VARCHAR(20),
    MembershipExpiry DATE,
    ClientStatus VARCHAR(20) DEFAULT 'активен',
    ClientSegment VARCHAR(20),
    IsActive BOOLEAN DEFAULT TRUE
);

-- 1.2 DimTrainer
CREATE TABLE DimTrainer (
    TrainerID SERIAL PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Specialization VARCHAR(100),
    HireDate DATE,
    CareerStartDate DATE,
    ExperienceYears INTEGER,
    IsActive BOOLEAN DEFAULT TRUE,
    Rating DECIMAL(3,2)
);

-- 1.3 DimClass
CREATE TABLE DimClass (
    ClassID SERIAL PRIMARY KEY,
    ClassName VARCHAR(100) NOT NULL,
    Description TEXT,
    Category VARCHAR(50),
    DifficultyLevel VARCHAR(20),
    DurationMinutes INTEGER,
    MaxCapacity INTEGER,
    Intensity VARCHAR(20),
    ClassType VARCHAR(20) DEFAULT 'Групповое'
);

-- 1.4 DimSchedule
CREATE TABLE DimSchedule (
    ScheduleID SERIAL PRIMARY KEY,
    ClassID INTEGER NOT NULL,
    TrainerID INTEGER NOT NULL,
    Room VARCHAR(30) NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    MaxCapacity INTEGER DEFAULT 15,
    IsCancelled BOOLEAN DEFAULT FALSE,
    CONSTRAINT FK_DimSchedule_Class FOREIGN KEY (ClassID) 
        REFERENCES DimClass(ClassID),
    CONSTRAINT FK_DimSchedule_Trainer FOREIGN KEY (TrainerID) 
        REFERENCES DimTrainer(TrainerID)
);

-- 1.5 DimDate
CREATE TABLE DimDate (
    DateID INTEGER PRIMARY KEY,
    Date DATE NOT NULL,
    Year INTEGER NOT NULL,
    Quarter INTEGER NOT NULL,
    Month INTEGER NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    DayOfMonth INTEGER NOT NULL,
    DayOfWeek INTEGER NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    WeekNumber INTEGER NOT NULL,
    IsWeekend BOOLEAN NOT NULL,
    IsHoliday BOOLEAN DEFAULT FALSE,
    Season VARCHAR(20) NOT NULL
);

-- 1.6 DimTime
CREATE TABLE DimTime (
    TimeID INTEGER PRIMARY KEY,
    Time TIME NOT NULL,
    Hour INTEGER NOT NULL,
    Minute INTEGER NOT NULL,
    Period VARCHAR(20),
    IsMorning BOOLEAN DEFAULT FALSE,
    IsAfternoon BOOLEAN DEFAULT FALSE,
    IsEvening BOOLEAN DEFAULT FALSE,
    IsNight BOOLEAN DEFAULT FALSE
);


-- ТАБЛИЦА ФАКТОВ (FACT)

CREATE TABLE FactAttendance (
    -- Первичный ключ факта
    AttendanceID SERIAL PRIMARY KEY,
    
    -- Внешние ключи к измерениям (контекст события)
    ClientID INTEGER NOT NULL,
    TrainerID INTEGER NOT NULL,
    ClassID INTEGER NOT NULL,
    ScheduleID INTEGER NOT NULL,
    DateID INTEGER NOT NULL,
    TimeID INTEGER NOT NULL,
    
    -- Атрибуты события
    BookingDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'подтверждена',
    BookingPlatform VARCHAR(20),
    
    -- Меры (числовые показатели)
    IsAttended INTEGER DEFAULT 0,        -- 1 = пришёл, 0 = нет
    WasLate INTEGER DEFAULT 0,           -- 1 = опоздал, 0 = нет
    ClientAgeAtBooking INTEGER,          -- Возраст клиента на момент записи
    DurationMinutesActual INTEGER,       -- Фактическая длительность
    
    -- Ограничения (FK)
    CONSTRAINT FK_FactAttendance_Client 
        FOREIGN KEY (ClientID) REFERENCES DimClient(ClientID),
    CONSTRAINT FK_FactAttendance_Trainer 
        FOREIGN KEY (TrainerID) REFERENCES DimTrainer(TrainerID),
    CONSTRAINT FK_FactAttendance_Class 
        FOREIGN KEY (ClassID) REFERENCES DimClass(ClassID),
    CONSTRAINT FK_FactAttendance_Schedule 
        FOREIGN KEY (ScheduleID) REFERENCES DimSchedule(ScheduleID),
    CONSTRAINT FK_FactAttendance_Date 
        FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    CONSTRAINT FK_FactAttendance_Time 
        FOREIGN KEY (TimeID) REFERENCES DimTime(TimeID)
);