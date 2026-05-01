-- Видалення старих таблиць
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS TeacherCompetencies;
DROP TABLE IF EXISTS Classrooms;
DROP TABLE IF EXISTS RoomTypes;
DROP TABLE IF EXISTS Teachers;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Groups;

-- 1. Групи (Groups)
CREATE TABLE Groups
(
    GroupID      INT PRIMARY KEY,
    GroupNumber  VARCHAR(10)  NOT NULL UNIQUE,
    HeadLastName NVARCHAR(50) NULL,
    Course       TINYINT      NULL,
    Specialty    NVARCHAR(100) NULL
);

-- 2. Предмети (Subjects)
CREATE TABLE Subjects
(
    SubjectID   INT PRIMARY KEY,
    SubjectName NVARCHAR(100) NOT NULL UNIQUE
);

-- 3. Типи аудиторій (RoomTypes)
CREATE TABLE RoomTypes
(
    RoomType           NVARCHAR(50) PRIMARY KEY,
    AllowedLessonTypes NVARCHAR(200) NULL
);

-- 4. Аудиторії (Classrooms)
CREATE TABLE Classrooms
(
    RoomID     INT PRIMARY KEY,
    RoomNumber VARCHAR(10)  NOT NULL UNIQUE,
    RoomType   NVARCHAR(50) NULL,
    Building   TINYINT      NULL,
    FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType)
);

-- 5. Викладачі (Teachers)
CREATE TABLE Teachers
(
    TeacherID   INT PRIMARY KEY,
    FullName    NVARCHAR(100) NOT NULL,
    Department  NVARCHAR(100) NULL,
    Position    NVARCHAR(50)  NULL,
    Degree      NVARCHAR(50)  NULL
);

-- 6. Компетенції викладачів (TeacherCompetencies)
CREATE TABLE TeacherCompetencies
(
    CompetenceID INT PRIMARY KEY,
    TeacherID    INT NOT NULL,
    LessonType   NVARCHAR(50) NULL,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- 7. Розклад занять (Schedule)
CREATE TABLE Schedule
(
    ScheduleID INT PRIMARY KEY,
    PairNumber TINYINT       NULL,
    GroupID    INT           NOT NULL,
    TeacherID  INT           NOT NULL,
    RoomID     INT           NOT NULL,
    SubjectID  INT           NOT NULL,
    LessonType NVARCHAR(50)  NULL,
    DayOfWeek  TINYINT       NULL,
    FOREIGN KEY (GroupID)   REFERENCES Groups(GroupID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    FOREIGN KEY (RoomID)    REFERENCES Classrooms(RoomID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

PRINT 'Vsi tablitsi uspishno stvoreno';
