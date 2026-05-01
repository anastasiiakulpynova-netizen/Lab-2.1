-- ============================================
-- ОЧИЩЕННЯ ТАБЛИЦЬ ПЕРЕД ВСТАВКОЮ
-- ============================================
DELETE FROM Schedule;
DELETE FROM TeacherCompetencies;
DELETE FROM Classrooms;
DELETE FROM Teachers;
DELETE FROM Subjects;
DELETE FROM Groups;
DELETE FROM RoomTypes;

-- ============================================
-- 1. RoomTypes
-- ============================================
INSERT INTO RoomTypes (RoomType, AllowedLessonTypes) VALUES
('Лекційна', 'Лекція'),
('Лабораторна', 'Лабораторна,Практична'),
('Компютерна', 'Лабораторна,Лекція'),
('Спортивна', 'Спортивне заняття');

-- ============================================
-- 2. Groups (ВИПРАВЛЕНО - унікальні номери)
-- ============================================
INSERT INTO Groups (GroupID, GroupNumber, HeadLastName, Course, Specialty) VALUES
(1, 'KS-11', 'Петренко', 1, 'Компютерні науки'),
(2, 'KS-12', 'Іваненко', 1, 'Компютерні науки'),
(3, 'KS-13', 'Сидоренко', 1, 'Компютерні науки'),
(4, 'KS-21', 'Коваленко', 2, 'Компютерні науки'),
(5, 'KS-22', 'Бондаренко', 2, 'Компютерні науки'),
(6, 'KS-31', 'Ткаченко', 3, 'Компютерні науки'),
(7, 'KS-32', 'Кравченко', 3, 'Компютерні науки'),
(8, 'KS-41', 'Олійник', 4, 'Компютерні науки'),
(9, 'IP-11', 'Шевченко', 1, 'Інженерія ПЗ'),
(10, 'IP-12', 'Бойко', 1, 'Інженерія ПЗ'),
(11, 'IP-21', 'Литвиненко', 2, 'Інженерія ПЗ'),
(12, 'IP-22', 'Мельник', 2, 'Інженерія ПЗ'),
(13, 'IP-31', 'Лисенко', 3, 'Інженерія ПЗ'),
(14, 'IP-41', 'Гончаренко', 4, 'Інженерія ПЗ'),
(15, 'KN-11', 'Марченко', 1, 'Кібербезпека'),
(16, 'KN-12', 'Руденко', 1, 'Кібербезпека'),
(17, 'KN-21', 'Савченко', 2, 'Кібербезпека'),
(18, 'KN-31', 'Романенко', 3, 'Кібербезпека'),
(19, 'KN-41', 'Пономаренко', 4, 'Кібербезпека'),
(20, 'EK-11', 'Кузьменко', 1, 'Економіка');

-- ============================================
-- 3. Subjects (ВИПРАВЛЕНО - унікальні назви)
-- ============================================
INSERT INTO Subjects (SubjectID, SubjectName) VALUES
(1, 'Databases'),
(2, 'Java Programming'),
(3, 'Web Technologies'),
(4, 'Operating Systems'),
(5, 'Computer Networks'),
(6, 'Calculus'),
(7, 'Algorithms'),
(8, 'AI'),
(9, 'Computer Architecture'),
(10, 'OOP'),
(11, 'English'),
(12, 'Physics'),
(13, 'Mathematics'),
(14, 'Probability'),
(15, 'Discrete Math'),
(16, 'Programming Methodology'),
(17, 'Software Testing'),
(18, 'Project Management'),
(19, 'Cybersecurity'),
(20, 'Cryptography'),
(21, 'Data Analysis'),
(22, 'Machine Learning'),
(23, 'Cloud Computing'),
(24, 'Mobile Development'),
(25, 'DevOps'),
(26, 'UI/UX Design'),
(27, 'History'),
(28, 'Philosophy'),
(29, 'Law'),
(30, 'Psychology');

-- ============================================
-- 4. Teachers
-- ============================================
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Teachers (TeacherID, FullName, Department, Position, Degree)
    VALUES (
        @i,
        CONCAT('Teacher ', @i),
        CONCAT('Department ', (@i % 5) + 1),
        CASE (@i % 4)
            WHEN 0 THEN 'Professor'
            WHEN 1 THEN 'Docent'
            WHEN 2 THEN 'Senior Lecturer'
            ELSE 'Assistant'
        END,
        CASE (@i % 3)
            WHEN 0 THEN 'Doctor'
            WHEN 1 THEN 'PhD'
            ELSE 'No Degree'
        END
    );
    SET @i = @i + 1;
END;

-- ============================================
-- 5. Classrooms
-- ============================================
DECLARE @j INT = 1;
WHILE @j <= 100
BEGIN
    INSERT INTO Classrooms (RoomID, RoomNumber, RoomType, Building)
    VALUES (
        @j,
        CONCAT(((@j - 1) % 5) + 1, '-', @j),
        CASE ((@j - 1) % 4)
            WHEN 0 THEN 'Лекційна'
            WHEN 1 THEN 'Лабораторна'
            WHEN 2 THEN 'Компютерна'
            ELSE 'Спортивна'
        END,
        ((@j - 1) % 5) + 1
    );
    SET @j = @j + 1;
END;

-- ============================================
-- 6. TeacherCompetencies
-- ============================================
DECLARE @k INT = 1;
WHILE @k <= 200
BEGIN
    INSERT INTO TeacherCompetencies (CompetenceID, TeacherID, LessonType)
    VALUES (
        @k,
        ((@k - 1) % 50) + 1,
        CASE ((@k - 1) % 4)
            WHEN 0 THEN 'Lecture'
            WHEN 1 THEN 'Practical'
            WHEN 2 THEN 'Laboratory'
            ELSE 'Seminar'
        END
    );
    SET @k = @k + 1;
END;

-- ============================================
-- 7. Schedule (ТІЛЬКИ з ІСНУЮЧИМИ GroupID)
-- ============================================
DECLARE @m INT = 1;
WHILE @m <= 1000
BEGIN
    INSERT INTO Schedule (ScheduleID, PairNumber, GroupID, TeacherID, RoomID, SubjectID, LessonType, DayOfWeek)
    VALUES (
        @m,
        ((@m - 1) % 6) + 1,
        ((@m - 1) % 20) + 1,
        ((@m - 1) % 50) + 1,
        ((@m - 1) % 100) + 1,
        ((@m - 1) % 30) + 1,
        CASE ((@m - 1) % 4)
            WHEN 0 THEN 'Lecture'
            WHEN 1 THEN 'Practical'
            WHEN 2 THEN 'Laboratory'
            ELSE 'Seminar'
        END,
        ((@m - 1) % 7) + 1
    );
    SET @m = @m + 1;
END;

-- ============================================
-- ПЕРЕВІРКА
-- ============================================
PRINT '========== RESULTS ==========';
SELECT COUNT(*) AS Groups FROM Groups;
SELECT COUNT(*) AS Subjects FROM Subjects;
SELECT COUNT(*) AS Teachers FROM Teachers;
SELECT COUNT(*) AS TeacherCompetencies FROM TeacherCompetencies;
SELECT COUNT(*) AS Classrooms FROM Classrooms;
SELECT COUNT(*) AS Schedule FROM Schedule;
PRINT '========== COMPLETED ==========';
