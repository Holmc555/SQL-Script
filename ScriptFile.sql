CREATE TABLE worker (
	id serial PRIMARY KEY,
	NAME varchar (1000) NOT NULL CHECK (LENGTH(NAME)>=2),
	BIRTHDAY date CHECK EXTRACT(YEAR FROM BIRTHDAY) > 1900,
	LEVEL varchar (50) NOT NULL CHECK (LEVEL IN ('Trainee', 'Junior', 'Middle', 'Senior')),
	salary int CHECK (salary >= 100 AND salary <= 100000)
);


CREATE TABLE CLIENT(
	id serial PRIMARY KEY,
	name varchar (1000) NOT NULL CHECK (LENGTH (NAME) >= 2)
);

CREATE TABLE project(
	id serial PRIMARY KEY,
	client_id int,
	START_DATE date,
	FINISH_DATE date,
	FOREIGN KEY (CLIENT_ID) REFERENCES client(ID)
);

CREATE TABLE project_worker(
	PROJECT_ID int,
	WORKER_ID int,
	PRIMARY KEY (PROJECT_ID, WORKER_ID),
	FOREIGN KEY (PROJECT_ID) REFERENCES project(ID),
	FOREIGN KEY (WORKER_ID) REFERENCES worker (ID)
);

INSERT INTO worker (NAME, BIRTHDAY, LEVEL, SALARY) VALUES
('Віктор Костюк', '1990-01-01', 'Senior', 5000),
('Олег Гордієнко', '1992-02-02', 'Middle', 3000),
('Крістіна Крисюкова', '1994-04-20', 'Junior', 1000),
('Валентин Радіонович', '2000-01-02', 'Senior', 4500),
('Ігор Романенко', '2001-10-05', 'Middle', 2300),
('Максим Король', '1989-12-02', 'Trainee', 800),
('Анна Дулуєва', '2004-02-02', 'Middle', 2500),
('Роман Калина', '1992-02-02', 'Junior', 1400),
('Іван Майданський', '1999-06-11', 'Junior', 1200),
('Софія Гадяцька', '2003-08-04', 'Trainee', 500);


INSERT INTO CLIENT (NAME) VALUES
('Олександр Голанов'),
('Артем Горбунов'),
('Вікторія Горник'),
('Світлана Зуб'),
('Катерина Кушніренко');

INSERT INTO PROJECT (CLIENT_ID, START_DATE, FINISH_DATE) VALUES
(1, '2023-01-01', '2023-12-01'),
(1, '2023-02-15', '2023-08-15'),
(2, '2023-03-10', '2023-09-10'),
(3, '2023-04-05', '2023-10-05'),
(4, '2023-05-20', '2023-11-20'),
(2, '2023-06-01', '2023-12-01'),
(3, '2023-07-15', '2024-01-15'),
(1, '2023-08-10', '2023-10-10'),
(4, '2023-09-05', '2024-02-05'),
(3, '2023-10-20', '2024-03-20');

INSERT INTO project_worker (PROJECT_ID, WORKER_ID) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(5, 4),
(6, 5),
(6, 1),
(7, 2),
(7, 3),
(7, 4),
(8, 5),
(8, 1),
(8, 2),
(9, 3),
(9, 4),
(9, 5),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5);

SELECT * FROM WORKER

SELECT * FROM PROJECT

SELECT * FROM PROJECT_WORKER

SELECT * FROM CLIENT

SELECT NAME FROM WORKER WHERE SALARY  = (SELECT MAX(SALARY) FROM WORKER); --Поиск сотрудника с наибольшей ЗП

SELECT c.NAME, COUNT(p.ID) AS PROJECT_COUNT
FROM client c
JOIN project p ON c.ID = p.CLIENT_ID
GROUP BY c.ID, c.NAME
HAVING COUNT(p.ID) = (
    SELECT MAX(PROJECT_COUNT)
    FROM (
        SELECT COUNT(p.ID) AS PROJECT_COUNT
        FROM client c
        JOIN project p ON c.ID = p.CLIENT_ID
        GROUP BY c.ID
    ) AS subquery
)
ORDER BY PROJECT_COUNT DESC;

SELECT 
    p.ID AS PROJECT_ID,
    TIMESTAMPDIFF(MONTH, p.START_DATE, p.FINISH_DATE) AS MONTH_COUNT
FROM 
    project p
WHERE 
    TIMESTAMPDIFF(MONTH, p.START_DATE, p.FINISH_DATE) = (
        SELECT MAX(TIMESTAMPDIFF(MONTH, START_DATE, FINISH_DATE))
        FROM project
    )
ORDER BY 
    MONTH_COUNT DESC;

(
    SELECT 'YOUNGEST' AS TYPE, NAME, BIRTHDAY
    FROM worker
    WHERE BIRTHDAY = (SELECT MAX(BIRTHDAY) FROM worker)
)
UNION ALL
(
    SELECT 'ELDEST' AS TYPE, NAME, BIRTHDAY
    FROM worker
    WHERE BIRTHDAY = (SELECT MIN(BIRTHDAY) FROM worker)
);

SELECT 
    p.ID AS PROJECT_ID,
    SUM(w.SALARY) * TIMESTAMPDIFF(MONTH, p.START_DATE, p.FINISH_DATE) AS PRICE
FROM 
    project_worker pw
JOIN 
    project p ON pw.PROJECT_ID = p.ID
JOIN 
    worker w ON pw.WORKER_ID = w.ID
GROUP BY 
    p.ID
ORDER BY 
    PRICE DESC;
