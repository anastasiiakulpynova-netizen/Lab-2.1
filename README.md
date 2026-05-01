# Lab-2.1
# Лабораторна робота №7

## Тема: Розклад занять (University Schedule Database)

### Виконав(ла):
Студент(ка) групи ЗКС 21 Кульпинова Анастасія Дмитрівна

---

## 1. Вербальна модель предметної області

Система призначена для управління розкладом занять у вищому навчальному закладі. Вона забезпечує зберігання та обробку інформації про:

- **Групи студентів** – кожна група має унікальний номер, курс, спеціальність та старосту.
- **Викладачів** – кожен викладач має унікальний ідентифікатор, ПІБ, кафедру, посаду та науковий ступінь.
- **Аудиторії** – кожна аудиторія має унікальний номер, тип (лекційна, лабораторна, комп'ютерна, спортивна) та належить до певного корпусу.
- **Предмети** – кожен предмет має унікальну назву.
- **Розклад занять** – визначає, коли, де, яка група, з яким викладачем і з якого предмета має заняття.

### Основні бізнес-правила:

1. Кожна група студентів має унікальний номер групи.
2. Кожна аудиторія має унікальний номер.
3. Кожен викладач має унікальний ідентифікатор.
4. Кожне заняття обов'язково пов'язане з однією групою, одним викладачем, однією аудиторією та одним предметом.
5. У певний час (день тижня + пара) аудиторія може бути зайнята лише одним заняттям.
6. У певний час викладач може проводити лише одне заняття.
7. У певний час група може бути присутня лише на одному занятті.
8. Тип аудиторії повинен відповідати типу заняття (лекція, лабораторна тощо).
9. Викладач може проводити лише ті види занять, які входять до його переліку компетенцій.

---

## 2. Логічна модель (ER-модель)

### Сутності та атрибути:

| Сутність | Атрибути |
|----------|----------|
| **Groups** | GroupID (PK), GroupNumber (UNIQUE), HeadLastName, Course, Specialty |
| **Subjects** | SubjectID (PK), SubjectName (UNIQUE) |
| **RoomTypes** | RoomType (PK), AllowedLessonTypes |
| **Classrooms** | RoomID (PK), RoomNumber (UNIQUE), RoomType (FK), Building |
| **Teachers** | TeacherID (PK), FullName, Department, Position, Degree |
| **TeacherCompetencies** | CompetenceID (PK), TeacherID (FK), LessonType |
| **Schedule** | ScheduleID (PK), PairNumber, GroupID (FK), TeacherID (FK), RoomID (FK), SubjectID (FK), LessonType, DayOfWeek |

### ER-діаграма:
## ER-модель (зв'язки між таблицями)

### Схема зв'язків:

| Таблиця 1 | Таблиця 2 | Тип зв'язку | Зовнішній ключ |
|-----------|-----------|-------------|----------------|
| Groups | Schedule | 1 : M | Schedule.GroupID → Groups.GroupID |
| Teachers | Schedule | 1 : M | Schedule.TeacherID → Teachers.TeacherID |
| Classrooms | Schedule | 1 : M | Schedule.RoomID → Classrooms.RoomID |
| Subjects | Schedule | 1 : M | Schedule.SubjectID → Subjects.SubjectID |
| Teachers | TeacherCompetencies | 1 : M | TeacherCompetencies.TeacherID → Teachers.TeacherID |
| RoomTypes | Classrooms | 1 : M | Classrooms.RoomType → RoomTypes.RoomType |

### Діаграма зв'язків:
Groups ──────────┐
Teachers ────────┼──► Schedule ◄── Subjects
Classrooms ──────┘
│
▼
RoomTypes

Teachers ────────► TeacherCompetencies

## ER-діаграма (Mermaid)

```mermaid
erDiagram
    Groups ||--o{ Schedule : has
    Subjects ||--o{ Schedule : has
    Teachers ||--o{ Schedule : teaches
    Classrooms ||--o{ Schedule : uses
    RoomTypes ||--o{ Classrooms : defines
    Teachers ||--o{ TeacherCompetencies : has

    Groups {
        int GroupID PK
        string GroupNumber UK
        string HeadLastName
        int Course
        string Specialty
    }

    Subjects {
        int SubjectID PK
        string SubjectName UK
    }

    Teachers {
        int TeacherID PK
        string FullName
        string Department
        string Position
        string Degree
    }

    Classrooms {
        int RoomID PK
        string RoomNumber UK
        string RoomType FK
        int Building
    }

    Schedule {
        int ScheduleID PK
        int PairNumber
        int GroupID FK
        int TeacherID FK
        int RoomID FK
        int SubjectID FK
        string LessonType
        int DayOfWeek
    }

    RoomTypes {
        string RoomType PK
        string AllowedLessonTypes
    }

    TeacherCompetencies {
        int CompetenceID PK
        int TeacherID FK
        string LessonType
    }
